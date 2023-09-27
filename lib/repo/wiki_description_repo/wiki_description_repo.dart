import 'package:either_dart/either.dart';
import 'package:wiki_app/modules/wiki_description_module/models/wiki_description_model.dart';
import 'package:wiki_app/services/api_service.dart';
import 'package:wiki_app/services/custom_error.dart';
import 'package:wiki_app/utils/constants.dart';

class WikiDescriptionRepo {
  final _api = ApiService(baseUrl: baseUrl);

  Future<Either<CustomError, WikiDescriptionModel>> getWikiDescription(String wikiId) async {
    Either<CustomError, WikiDescriptionModel> response = await _api.get<WikiDescriptionModel>(
      '$baseUrl?action=query&format=json&prop=pageimages|description|extracts&pageids=$wikiId&explaintext=true',
      (Map<String, dynamic> resp) {
        print(resp);
      },
    );
    response.fold((left) {
      return left;
    }, (right) {
      return right;
    });
    return response;
  }
}
