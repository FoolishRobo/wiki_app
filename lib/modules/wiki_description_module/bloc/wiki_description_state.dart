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
