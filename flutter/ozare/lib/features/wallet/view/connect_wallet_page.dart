import 'dart:convert';
import 'dart:html' as html;

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart'
    if (dart.library.html) 'dart:ui' as ui;
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/features/auth/auth.dart';
import 'package:ozare/features/wallet/bloc/wallet_bloc.dart' as wallet;
import 'package:ozare/features/wallet/bloc/wallet_bloc.dart';
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
    htmlListener();
  }

  @override
  void dispose() {
    html.window.removeEventListener('message', handleMessage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: webViewPlatformWebsite(
        webviewId: 12,
        url: 'https://ozare-final.vercel.app/?connect=true',
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }

  Widget webViewPlatformWebsite({
    required int webviewId,
    required String url,
    required double width,
    required double height,
    Key? key,
  }) {
    final iFrameElement = html.IFrameElement()
      ..src = url
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%';
    final webviewRegisterKey = 'webpage$webviewId';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      webviewRegisterKey,
      (int viewId) => iFrameElement,
    );

    final child = HtmlElementView(viewType: webviewRegisterKey); //unique key

    return SizedBox(width: width, height: height, child: child);
  }

  void htmlListener() {
    html.window.addEventListener('message', handleMessage);
  }

  void handleMessage(html.Event event) {
    if (event is html.MessageEvent) {
      final data = event.data;

      if (data['address'] != null) {
        context.read<AuthBloc>().add(
              AuthWalletLoginCompleted(
                oUser: {
                  'uid': null,
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
