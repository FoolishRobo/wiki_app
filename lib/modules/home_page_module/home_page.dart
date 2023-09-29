import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wiki_app/common/debouncer.dart';
import 'package:wiki_app/modules/home_page_module/bloc/home_page_bloc.dart';
import 'package:wiki_app/modules/wiki_description_module/bloc/wiki_description_bloc.dart';
import 'package:wiki_app/modules/wiki_description_module/bloc/wiki_description_event.dart';
import 'package:wiki_app/modules/wiki_description_module/bloc/wiki_description_state.dart';
import 'package:wiki_app/utils/extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  late final TextEditingController _textEditingController;
  // ignore: prefer_typing_uninitialized_variables
  late final Debouncer _textFieldDebouncer;
  late final Debouncer _paginationApiCallDebouncer;

  @override
  void initState() {
    super.initState();
    _textFieldDebouncer = Debouncer(delay: const Duration(milliseconds: 500));
    _paginationApiCallDebouncer = Debouncer(delay: const Duration(milliseconds: 500));
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _textFieldDebouncer.dispose();
    _paginationApiCallDebouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext homePagecontext) {
    return Builder(builder: (context) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                20.h,
                getTextField(),
                20.h,
                getBodyView(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget getTextField() {
    return BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
      return TextField(
        controller: _textEditingController,
        onChanged: (value) {
          _textFieldDebouncer.run(() {
            context.read<HomePageBloc>().add(SearchHomePageDataEvent(query: value));
          });
        },
        decoration: InputDecoration(
          hintText: "Search",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    });
  }

  Widget getBodyView() {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state is InitialHomePageState) {
          return const Text("Please search something");
        } else if (state is ErrorHomePageState) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is LoadingHomePageState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedHomePageState) {
          return getListView(state, false);
        } else if (state is LoadingPaginatedHomePageState) {
          return getListView(state, true);
        }
        return Container();
      },
    );
  }

  Widget getListView(state, bool isLoadingPaginatedView) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController
          // paginated api call, added inside debouncer to reject multiple scroll triggers
          ..addListener(() => _paginationApiCallDebouncer.run(() {
                if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
                  context.read<HomePageBloc>().add(SearchHomePageDataEvent(query: _textEditingController.text));
                }
              })),
        shrinkWrap: true,
        itemCount: state.pages.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              BlocBuilder<WikiDescriptionBloc, WikiDescriptionState>(builder: (bookmarkContext, bookmarkState) {
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: state.pages[index].thumbnail?.source ?? '',
                    errorWidget: (context, url, error) => const SizedBox(width: 60, child: Center(child: Icon(Icons.error))),
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      BlocProvider.of<WikiDescriptionBloc>(context).add(bookmarkState.isBookmarkAddedEvent.contains(state.pages[index].pageid.toString())
                          ? RemoveFromBookmarkEvent(state.pages[index].pageid.toString())
                          : AddToBookmarkEvent(state.pages[index].pageid.toString()));
                    },
                    icon: Icon(bookmarkState.isBookmarkAddedEvent.contains(state.pages[index].pageid.toString()) ? Icons.bookmark : Icons.bookmark_border),
                  ),
                  title: Text(state.pages[index].title ?? ''),
                  subtitle: Text(state.pages[index].description ?? ''),
                  onTap: () {
                    context.goNamed('wiki_desc', pathParameters: {'id': state.pages[index].pageid.toString(), 'title': state.pages[index].title.toString()});
                  },
                );
              }),
              if (isLoadingPaginatedView && index == state.pages.length - 1)
                const Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
