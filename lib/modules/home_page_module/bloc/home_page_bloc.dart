import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_app/modules/home_page_module/models/wiki_item_model.dart';
import 'package:wiki_app/repo/home_page_repo/home_page_repo.dart';
part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvents, HomePageState> {
  HomePageBloc() : super(InitialHomePageState()) {
    on<SearchHomePageDataEvent>(search);
  }

  List<WikiItemModel> wikiItems = [];

  void search(SearchHomePageDataEvent event, Emitter<HomePageState> emit) async {
    if (event.query.isEmpty) {
      emit(InitialHomePageState());
      return;
    }
    if (event.offset == 0) {
      emit(LoadingHomePageState());
    } else {
      emit(LoadingPaginatedHomePageState(pages: wikiItems));
    }
    var resp = await HomePageRepo().getWikiItems(query: event.query, limit: event.limit, offset: event.offset);
    resp.fold((left) {
      if (wikiItems.isNotEmpty) {
        emit(LoadedHomePageState(pages: wikiItems));
      } else {
        emit(ErrorHomePageState(message: left.message));
      }
      emit(ErrorHomePageState(message: left.message));
    }, (right) {
      if (right.isEmpty && wikiItems.isEmpty) {
        emit(ErrorHomePageState(message: "No results found"));
      } else {
        wikiItems = [...wikiItems, ...right];
        emit(LoadedHomePageState(pages: wikiItems));
      }
    });
  }
}
