import 'dart:convert';
import 'dart:html' as html;

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart'
    if (dart.library.html) 'dart:ui' as ui;
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/features/bet/bloc/bet_bloc.dart';
import 'package:ozare/features/wallet/bloc/wallet_bloc.dart' as wallet;
import 'package:ozare/features/wallet/bloc/wallet_bloc.dart';
import 'package:ozare/features/wallet/models/models.dart';
import 'package:ozare/styles/common/widgets/dialogs/dialogs.dart';
import 'package:ozare_repository/ozare_repository.dart';

class SignTransactionPage extends StatefulWidget {
  final BetBloc betBloc;
  const SignTransactionPage({
    required this.betBloc,
    super.key,
  });

  @override
  State<SignTransactionPage> createState() => _SignTransactionPageState();
}

class _SignTransactionPageState extends State<SignTransactionPage> {
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
    return BlocBuilder<wallet.WalletBloc, wallet.WalletState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            title: const Text(
              'My Wallet',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            elevation: 0,
          ),
          body: webViewPlatformWebsite(
            webviewId: 12,
            url: 'https://ozare-final.vercel.app/ton/',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            payload: state.payload,
          ),
        );
      },
    );
  }

  Widget webViewPlatformWebsite({
    required int webviewId,
    required String url,
    required Payload payload,
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

    // postMessage to the iframe on load
    iFrameElement.onLoad.listen((_) {
      iFrameElement.contentWindow!.postMessage(
        payload.toJson(),
        '*',
      );
    });

    return SizedBox(width: width, height: height, child: child);
  }

  void htmlListener() {
    html.window.addEventListener('message', handleMessage);
  }

  void handleMessage(html.Event event) {
    if (event is html.MessageEvent) {
      final data = event.data;

      if (data['response'] != null) {
        final dataJson = data['response'] as Map<dynamic, dynamic>;
        final status = dataJson['status'].toString();
        final message = dataJson['message'].toString();
        final innerData = dataJson['data'] as Map<dynamic, dynamic>;
        final dataAddress = innerData['address'].toString();
        final dataUid = innerData['uid'] as int;

        widget.betBloc.add(
          BetCreated(
            Bet.fromJson(context.read<WalletBloc>().state.bet!),
            context.read<WalletBloc>().state.event!,
          ),
        );
        context.read<WalletBloc>().add(
              PayloadSubmitted(
                Response(status: status, message: message, data: innerData),
              ),
            );

        Navigator.pop(context);
        //ANCHOR - Return the message from the iframe
        showAlertDialog(
          context: context,
          title: status,
          content: 'Bet placed successfully',
        );
        // Post the updated message
      }
    }
  }
}
