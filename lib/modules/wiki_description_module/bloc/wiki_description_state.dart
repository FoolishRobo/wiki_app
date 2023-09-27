import 'package:wiki_app/modules/wiki_description_module/models/wiki_description_model.dart';

class WikiDescriptionState {}

class InitialWikiDescriptionState extends WikiDescriptionState {}

class LoadingWikiDescriptionState extends WikiDescriptionState {}

class LoadedWikiDescriptionState extends WikiDescriptionState {
  final WikiDescriptionModel wikiDescriptionModel;

  LoadedWikiDescriptionState({required this.wikiDescriptionModel});
}

class ErrorWikiDescriptionState extends WikiDescriptionState {
  final String message;

  ErrorWikiDescriptionState({required this.message});
}
