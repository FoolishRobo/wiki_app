import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wiki_app/common/debouncer.dart';
import 'package:wiki_app/modules/home_page_module/bloc/home_page_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  late final TextEditingController _textEditingController;
  // ignore: prefer_typing_uninitialized_variables
  late final Debouncer _debouncer;
  late int offset;

  @override
  void initState() {
    super.initState();
    offset = 0;
    _debouncer = Debouncer(delay: const Duration(milliseconds: 500));
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageBloc>(
      create: (_) => HomePageBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                getTextField(),
                SizedBox(
                  height: 20,
                ),
                getBodyView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTextField() {
    return BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
      return TextField(
        controller: _textEditingController,
        onChanged: (value) {
          _debouncer.run(() {
            context.read<HomePageBloc>().add(SearchHomePageDataEvent(query: value, offset: offset));
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
          return getListView(state, false, () {
            context.read<HomePageBloc>().add(SearchHomePageDataEvent(query: _textEditingController.text, offset: offset));
          });
        } else if (state is LoadingPaginatedHomePageState) {
          return getListView(state, true, () {
            context.read<HomePageBloc>().add(SearchHomePageDataEvent(query: _textEditingController.text, offset: offset));
          });
        }
        return Container();
      },
    );
  }

  Widget getListView(state, bool isLoadingPaginatedView, Function search) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController
          ..addListener(() {
            if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
              offset += 10;
              search();
            }
          }),
        shrinkWrap: true,
        itemCount: state.pages.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: Image.network(
                  state.pages[index].thumbnail?.source ?? '',
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(width: 60, child: Center(child: Icon(Icons.error)));
                  },
                  width: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(state.pages[index].title ?? ''),
                subtitle: Text(state.pages[index].description ?? ''),
                onTap: () {
                  print(state.pages[index].title.toString());
                  context.go(context
                      .namedLocation('wiki_desc', pathParameters: {'id': state.pages[index].pageid.toString(), 'title': state.pages[index].title.toString()}));
                  // context.read<HomePageBloc>().add(SelectHomePageDataEvent(selectedItem: state.pages[index].pageid.toString()));
                },
              ),
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
