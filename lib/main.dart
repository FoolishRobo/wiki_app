import 'package:flutter/material.dart';
import 'package:wiki_app/modules/home_page_module/home_page.dart';
import 'package:wiki_app/route/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: route,
      // home: const HomePage(),
    );
  }
}
