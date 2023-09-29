import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wiki_app/modules/wiki_description_module/bloc/wiki_description_bloc.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:wiki_app/modules/wiki_description_module/bloc/wiki_description_event.dart';
import 'package:wiki_app/modules/wiki_description_module/bloc/wiki_description_state.dart';

class WikiDescriptionPage extends StatefulWidget {
  final String wikiId;
  final String title;
  const WikiDescriptionPage({super.key, required this.wikiId, required this.title});

  @override
  State<WikiDescriptionPage> createState() => _WikiDescriptionPageState();
}

class _WikiDescriptionPageState extends State<WikiDescriptionPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    // Use Android or iOS specific WebView platform.
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);

    controller.loadRequest(Uri.parse('https://en.wikipedia.org/wiki/${widget.title}'));

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
          child: WebViewWidget(
        controller: _controller,
      )),
    );
  }
}
