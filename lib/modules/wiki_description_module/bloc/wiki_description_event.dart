class WikiDescriptionEvent {}

class GetAllBookmarksEvent extends WikiDescriptionEvent {}

class AddToBookmarkEvent extends WikiDescriptionEvent {
  final String wikiId;
  AddToBookmarkEvent(this.wikiId);
}

class RemoveFromBookmarkEvent extends WikiDescriptionEvent {
  final String wikiId;
  RemoveFromBookmarkEvent(this.wikiId);
}
