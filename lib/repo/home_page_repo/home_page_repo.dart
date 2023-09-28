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
      Either<CustomError, ListOfWikiItemModel> response = await _api.get<ListOfWikiItemModel>(
        url,
        (json) => ListOfWikiItemModel.fromJson(json['query']),
      );
      response.fold((left) {}, (right) async {
        // HiveService.instance.deleteAllBoxes();
        if (offset > 0 && await HiveService.instance.isDataCached(HiveUtils.wikiSearchBox, query)) {
          ListOfWikiItemModel wikiItems = await HiveService.instance.getData(HiveUtils.wikiSearchBox, query);
          right.wikiItemList = [...wikiItems.wikiItemList, ...right.wikiItemList]; //.addAll(wikiItems.wikiItemList);
        }
        HiveService.instance.saveData(HiveUtils.wikiSearchBox, query, right, isPaginatedApi: offset > 0);
      });
      return response;
    } else {
      if (await HiveService.instance.isDataCached(HiveUtils.wikiSearchBox, query)) {
        //in offline mode, hive will return all the paginated data at once.
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
