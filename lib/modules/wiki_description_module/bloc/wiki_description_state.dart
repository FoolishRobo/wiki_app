import 'package:wiki_app/modules/wiki_description_module/bloc/wiki_description_event.dart';
import 'package:wiki_app/modules/wiki_description_module/models/wiki_description_model.dart';

class WikiDescriptionState {
  List<String> isBookmarkAddedEvent = [];
  WikiDescriptionState(this.isBookmarkAddedEvent);
}

class BookMarkAddedState extends WikiDescriptionState {
  BookMarkAddedState(super.isBookmarkAddedEvent);
}

class BookMarkRemovedState extends WikiDescriptionState {
  BookMarkRemovedState(super.isBookmarkAddedEvent);
}
