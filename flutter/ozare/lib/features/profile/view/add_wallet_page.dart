import 'dart:html' as html;
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart'
    if (dart.library.html) 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/features/profile/bloc/profile_bloc.dart';
import 'package:ozare/features/profile/models/models.dart';

class AddWallet extends StatefulWidget {
  const AddWallet({super.key});

  @override
  State<AddWallet> createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
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
          'Add New Wallet',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        elevation: 0,
      ),
      body: webViewPlatformWebsite(
        webviewId: 12,
        url: 'https://ozare-final.vercel.app/',
        width: 700,
        height: 4000,
      ),
    );
  }

  Widget webViewPlatformWebsite({
    required int webviewId,
    required String url,
    required double width,
    required double height,
  }) {
    final iFrameElement = html.IFrameElement()
      ..src = url
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%';

    html.window.addEventListener('message', (event) {
      // Cast the Event object to the MessageEvent subtype
      if (event is html.MessageEvent) {
        // Get the data sent from the postMessage
        final data = event.data;

        // Check if the data contains the address key
        if (data['address'] != null) {
          // Access the address value and use it as needed
          final walletAddress = data['address'].toString();
          final walletName = data['walletName'].toString();
          var walletIcon = 'assets/images/tonkeeper.png';

          if (walletName.contains('openmask')) {
            walletIcon = 'assets/images/tonwallet.png';
          }

          final newWallet = Wallet(
            name: walletName,
            key: walletAddress,
            iconPath: walletIcon,
          );

          context.read<ProfileBloc>().add(
                ProfileWalletChanged(
                  [newWallet],
                ),
              );
          Navigator.pop(context);
        }
      }
    });
    final webviewRegisterKey = 'webpage$webviewId';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      webviewRegisterKey,
      (int viewId) => iFrameElement,
    );

    final child = HtmlElementView(viewType: webviewRegisterKey); //unique key

    return SizedBox(width: width, height: height, child: child);
  }
}
