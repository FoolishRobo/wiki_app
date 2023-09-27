import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wiki_app/modules/home_page_module/home_page.dart';
import 'package:wiki_app/modules/wiki_description_module/wiki_description.dart';

GoRouter route = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
      routes: <GoRoute>[
        GoRoute(
          path: 'description/:id/:title',
          name: 'wiki_desc',
          builder: (BuildContext context, GoRouterState state) => WikiDescription(
            wikiId: state.pathParameters['id']!,
            title: state.pathParameters['title']!,
          ),
        ),
      ],
    ),
  ],
);
