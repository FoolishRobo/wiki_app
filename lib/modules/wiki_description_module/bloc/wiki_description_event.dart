class WikiDescriptionEvent {}

class FetchWikiDescriptionEvent extends WikiDescriptionEvent {
  final String wikiId;
  FetchWikiDescriptionEvent(this.wikiId);
}
