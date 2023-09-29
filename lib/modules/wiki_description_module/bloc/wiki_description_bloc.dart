import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_app/modules/wiki_description_module/bloc/wiki_description_event.dart';
import 'package:wiki_app/modules/wiki_description_module/bloc/wiki_description_state.dart';
import 'package:wiki_app/repo/wiki_description_repo/wiki_description_repo.dart';

class WikiDescriptionBloc extends Bloc<WikiDescriptionEvent, WikiDescriptionState> {
  List<String> bookmakrs = [];
  WikiDescriptionBloc() : super(BookMarkRemovedState([])) {
    on<AddToBookmarkEvent>((event, emit) async {
      bookmakrs = await WikiDescriptionRepo().addBookMark(event.wikiId);
      emit(BookMarkAddedState(bookmakrs));
    });
    on<RemoveFromBookmarkEvent>((event, emit) async {
      bookmakrs = await WikiDescriptionRepo().removeBookMark(event.wikiId);
      emit(BookMarkRemovedState(bookmakrs));
    });
    on<GetAllBookmarksEvent>((event, emit) async {
      bookmakrs = WikiDescriptionRepo().getAllBookMark();
      emit(BookMarkRemovedState(bookmakrs));
    });
  }
}
