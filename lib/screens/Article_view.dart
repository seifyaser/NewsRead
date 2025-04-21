import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  const ArticleView({super.key, required this.blogUrl});
  final String blogUrl;

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // تأكد من تهيئة WebViewController بشكل صحيح
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => isLoading = true),
          onPageFinished: (_) => setState(() => isLoading = false),
        ),
      );
    // تحميل الرابط
    _controller.loadRequest(Uri.parse(widget.blogUrl));
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: WebViewWidget(controller: _controller),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
