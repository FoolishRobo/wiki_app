import 'package:flutter/material.dart';
import 'package:wiki_app/route/app_router.dart';
import 'package:wiki_app/services/hive_service/hive_service.dart';
import 'package:wiki_app/services/hive_service/hive_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveService.instance.init(HiveUtils.wikiSearchBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: route,
    );
  }
}
