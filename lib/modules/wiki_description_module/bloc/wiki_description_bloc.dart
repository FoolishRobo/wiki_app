import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_app/modules/wiki_description_module/bloc/wiki_description_event.dart';
import 'package:wiki_app/modules/wiki_description_module/bloc/wiki_description_state.dart';
import 'package:wiki_app/modules/wiki_description_module/models/wiki_description_model.dart';
import 'package:wiki_app/repo/wiki_description_repo/wiki_description_repo.dart';

class WikiDescriptionBloc extends Bloc<WikiDescriptionEvent, WikiDescriptionState> {
  WikiDescriptionBloc() : super(InitialWikiDescriptionState()) {
    on<FetchWikiDescriptionEvent>((event, emit) async {
      emit(LoadingWikiDescriptionState());
      try {
        var resp = await WikiDescriptionRepo().getWikiDescription(event.wikiId);
        resp.fold((left) {
          emit(ErrorWikiDescriptionState(message: left.message));
        }, (right) {
          emit(LoadedWikiDescriptionState(wikiDescriptionModel: right));
        });
      } catch (e) {
        emit(ErrorWikiDescriptionState(message: e.toString()));
      }
    });
  }
}
