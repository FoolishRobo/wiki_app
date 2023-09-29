import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wiki_app/modules/home_page_module/bloc/home_page_bloc.dart';
import 'package:wiki_app/modules/home_page_module/home_page.dart';
import 'package:wiki_app/modules/wiki_description_module/bloc/wiki_description_bloc.dart';
import 'package:wiki_app/modules/wiki_description_module/bloc/wiki_description_event.dart';
import 'package:wiki_app/modules/wiki_description_module/wiki_description_page.dart';

GoRouter route = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<HomePageBloc>(
            create: (_) => HomePageBloc(),
          ),
          BlocProvider(
            create: (_) => WikiDescriptionBloc()..add(GetAllBookmarksEvent()),
          )
        ],
        child: const HomePage(),
      ),
      routes: <GoRoute>[
        GoRoute(
          path: 'description/:id/:title',
          name: 'wiki_desc',
          builder: (BuildContext context, GoRouterState state) => WikiDescriptionPage(
            wikiId: state.pathParameters['id']!,
            title: state.pathParameters['title']!,
          ),
        ),
      ],
    ),
  ],
);
