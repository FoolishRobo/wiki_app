import 'package:either_dart/either.dart';
import 'package:wiki_app/modules/home_page_module/models/wiki_item_model.dart';
import 'package:wiki_app/services/api_service.dart';
import 'package:wiki_app/services/custom_error.dart';
import 'package:wiki_app/utils/constants.dart';

class HomePageRepo {
  final _api = ApiService(baseUrl: baseUrl);

  Future<Either<CustomError, List<WikiItemModel>>> getWikiItems({required String query, required int limit, required int offset}) async {
    Either<CustomError, List<WikiItemModel>> response = await _api.get<List<WikiItemModel>>(
      '$baseUrl?action=query&format=json&prop=pageimages|description&generator=prefixsearch&formatversion=2&gpssearch=$query&gpslimit=$limit&gpsoffset=$offset',
      getListFromJson,
    );
    response.fold((left) {
      return left;
    }, (right) {
      return right;
    });
    return response;
  }
}
