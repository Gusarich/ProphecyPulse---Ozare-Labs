import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/app/routes.dart';
import 'package:ozare/features/profile/bloc/profile_bloc.dart';
import 'package:ozare/features/profile/models/models.dart';
import 'dart:html' as html;
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart'
    if (dart.library.html) 'dart:ui' as ui;

import 'package:ozare/features/profile/widgets/widgets.dart';
import 'package:ozare/styles/common/widgets/dialogs/dialogs.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBarProfileSection.singlePage(
          title: 'My Wallet',
          appBarAction: GestureDetector(
            onTap: () async {
              await Navigator.pushNamed(context, Routes.signTransaction);
            },
            child: const SizedBox(),
          ),
        ),
        _buildWebView(context),
      ],
    );
  }

  Widget _buildWebView(BuildContext context) {
    return webViewPlatformWebsite(
      webviewId: 12,
      url: 'https://ozare-final.vercel.app/ton/?connect=true',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
  }

  Widget webViewPlatformWebsite({
    required int webviewId,
    required String url,
    required double width,
    required double height,
    Key? key,
  }) {
    final iFrameElement = _createIFrameElement(url);
    _registerIFrameMessageListener(iFrameElement);

    final webviewRegisterKey = 'webpage$webviewId';
    _registerViewFactory(webviewRegisterKey, iFrameElement);

    final child = HtmlElementView(viewType: webviewRegisterKey);
    return SizedBox(width: width, height: height, child: child);
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
      String webviewRegisterKey, html.IFrameElement iFrameElement) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      webviewRegisterKey,
      (int viewId) => iFrameElement,
    );
  }

  void handleMessage(html.Event event) {
    print('Received event: $event');
    if (event is html.MessageEvent) {
      final data = event.data;

      if (data['address'] != null) {
        //Do something here.
      }
    }
  }
}
