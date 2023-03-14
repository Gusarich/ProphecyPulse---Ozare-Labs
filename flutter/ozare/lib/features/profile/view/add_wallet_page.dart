import 'dart:developer';
import 'dart:html' as html;
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart'
    if (dart.library.html) 'dart:ui' as ui;
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:ozare/features/profile/utils/utils.dart';
import 'package:ozare/l10n/l10n.dart';
import 'package:ozare/styles/common/widgets/dialogs/dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

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
    // _sub.cancel();
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
        url: 'https://ozare-react.vercel.app/',
        width: 700,
        height: 4000,
      ),

      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      //   child: Column(
      //     children: [
      //       const Align(
      //         alignment: Alignment.centerLeft,
      //         child: Text(
      //           'Which Wallet\nyou want to add?',
      //           style: TextStyle(
      //             color: Colors.black,
      //             fontSize: 24,
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //       ),
      //       const SizedBox(height: 24),
      //       Expanded(
      //         child: GridView.count(
      //           crossAxisCount: 2,
      //           mainAxisSpacing: 12,
      //           crossAxisSpacing: 12,
      //           children: wallets
      //               .map(
      //                 (wallet) => WalletSelector(
      //                   name: wallet['name'] as String,
      //                   iconPath: wallet['iconPath'] as String,
      //                 ),
      //               )
      //               .toList(),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget webViewPlatformWebsite({
    required int webviewId,
    required String url,
    required double width,
    required double height,
  }) {
    final iFrameElement = html.IFrameElement();
    iFrameElement
      ..src = url
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..onLoad.listen((event) {
        log(iFrameElement.className);
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

class WalletSelector extends StatelessWidget {
  const WalletSelector({
    super.key,
    required this.name,
    required this.iconPath,
  });

  final String name;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = context.l10n;
    return InkWell(
      onTap: () async {
        if (name.toLowerCase() == 'TON Wallet'.toLowerCase() ||
            name.toLowerCase() == 'Tonkeeper'.toLowerCase()) {
          if (await canLaunchUrl(tonApiWallet)) {
            await launchUrl(tonApiWallet, mode: LaunchMode.externalApplication);
            FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
              showAlertDialog(
                context: context,
                title: 'Success',
                content: 'Wallet connected successfully',
              );
            }).onError((error) {});
          }
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width * 0.4,
              height: size.width * 0.28,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            child: Image.asset(
              iconPath,
              height: size.width * 0.24,
            ),
          ),
        ],
      ),
    );
  }
}
