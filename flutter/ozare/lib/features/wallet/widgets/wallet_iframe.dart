import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart'
    if (dart.library.html) 'dart:ui' as ui;

class WebViewIFrame extends StatefulWidget {
  const WebViewIFrame({
    required this.webviewId,
    required this.url,
    required this.width,
    required this.height,
    super.key,
  });
  final int webviewId;
  final String url;
  final double width;
  final double height;

  @override
  _WebViewIFrameState createState() => _WebViewIFrameState();
}

class _WebViewIFrameState extends State<WebViewIFrame> {
  late html.IFrameElement _iFrameElement;

  @override
  void initState() {
    super.initState();
    _iFrameElement = _createIFrameElement(widget.url);
    _registerIFrameMessageListener(_iFrameElement);

    final webviewRegisterKey = 'webpage${widget.webviewId}';
    _registerViewFactory(webviewRegisterKey, _iFrameElement);
  }

  @override
  void dispose() {
    html.window.removeEventListener('message', handleMessage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = HtmlElementView(viewType: 'webpage${widget.webviewId}');
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: child,
        );
      },
    );
  }

  html.IFrameElement _createIFrameElement(String url) {
    return html.IFrameElement()
      ..src = url
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%';
  }

  void _registerIFrameMessageListener(html.IFrameElement iFrameElement) {
    html.window.addEventListener('message', handleMessage);
  }

  void _registerViewFactory(
    String webviewRegisterKey,
    html.IFrameElement iFrameElement,
  ) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      webviewRegisterKey,
      (int viewId) => iFrameElement,
    );
  }

  void handleMessage(html.Event event) {
    if (event is html.MessageEvent) {
      final data = event.data;

      if (data['address'] != null) {
        //FIXME - Do something here.
      }
    }
  }
}
