import 'dart:convert';
import 'dart:html' as html;
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart'
    if (dart.library.html) 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/features/auth/auth.dart';
import 'package:ozare/features/wallet/bloc/wallet_bloc.dart' as wallet;
import 'package:ozare/features/wallet/models/models.dart';
import 'package:ozare/styles/common/widgets/dialogs/dialogs.dart';

class ConnectWalletPage extends StatefulWidget {
  const ConnectWalletPage({Key? key}) : super(key: key);

  @override
  State<ConnectWalletPage> createState() => _ConnectWalletPageState();
}

class _ConnectWalletPageState extends State<ConnectWalletPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildWebView(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.read<AuthBloc>().add(const AuthLoginPageRequested());
        },
      ),
      centerTitle: true,
      title: const Text(
        'Connect Wallet',
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      elevation: 0,
    );
  }

  Widget _buildWebView(BuildContext context) {
    return webViewPlatformWebsite(
      webviewId: 12,
      url: 'https://ozare-final.vercel.app/?connect=true',
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
    iFrameElement.onLoad.listen((event) {
      iFrameElement.addEventListener('message', handleMessage);
    });
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
        context.read<AuthBloc>().add(
              AuthWalletLoginCompleted(
                oUser: {
                  'uid': null,
                  'email': 'anonymous@pulse.xyz',
                  'email': 'anonymous@pulse.xyz',
                  'firstName': data['address'].toString(),
                  'lastName': data['address'].toString(),
                },
              ),
            );
      }
    }
  }
}
