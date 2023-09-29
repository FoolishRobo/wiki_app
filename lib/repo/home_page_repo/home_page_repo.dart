import 'package:either_dart/either.dart';
import 'package:wiki_app/modules/home_page_module/models/wiki_item_model.dart';
import 'package:wiki_app/services/api_service/api_service.dart';
import 'package:wiki_app/services/connectivity_service/connectivity_service.dart';
import 'package:wiki_app/services/error_service/custom_error.dart';
import 'package:wiki_app/services/hive_service/hive_utils.dart';
import 'package:wiki_app/services/hive_service/hive_service.dart';
import 'package:wiki_app/utils/constants.dart';

class HomePageRepo {
  final _api = ApiService(baseUrl: baseUrl);

  Future<Either<CustomError, ListOfWikiItemModel>> getWikiItems({required String query, required int limit, required int offset}) async {
    String url =
        '$baseUrl?action=query&format=json&prop=pageimages|description&generator=prefixsearch&formatversion=2&gpssearch=$query&gpslimit=$limit&gpsoffset=$offset';

    bool isConnected = await ConnectivityService().isUserConnectedToInternet();

    if (isConnected) {
      /// if user is connected to internet, make api call
      Either<CustomError, ListOfWikiItemModel> response = await _api.get<ListOfWikiItemModel>(
        url,
        (json) => ListOfWikiItemModel.fromJson(json['query']),
      );

      /// TODO: We can create a Cache Service class which can handle the caching of data
      /// Store data in hive for offline use
      response.fold((left) {}, (right) async {
        /// if data is already cached in hive, append the new api data to the existing data
        if (offset > 0 && await HiveService.instance.isDataCached(HiveUtils.wikiSearchBox, query)) {
          ListOfWikiItemModel wikiItems = await HiveService.instance.getData(HiveUtils.wikiSearchBox, query);
          right.wikiItemList = [...wikiItems.wikiItemList, ...right.wikiItemList];
        }

        /// save data in hive
        HiveService.instance.saveData(HiveUtils.wikiSearchBox, query, right, isPaginatedApi: offset > 0);
      });
      return response;
    } else {
      /// TODO: We can create a Cache Service class which can handle retrieving cached data
      /// if data is cached in hive, return the cached data
      if (HiveService.instance.isDataCached(HiveUtils.wikiSearchBox, query)) {
        //in offline mode, hive will return all the paginated page's data at once.
        if (offset > 0) {
          return Right(ListOfWikiItemModel([]));
        }
        ListOfWikiItemModel wikiItems = await HiveService.instance.getData(HiveUtils.wikiSearchBox, query);
        return Right(wikiItems);
      } else {
        return Left(CustomError(message: 'No Internet Connection'));
      }
    }
  }
}
