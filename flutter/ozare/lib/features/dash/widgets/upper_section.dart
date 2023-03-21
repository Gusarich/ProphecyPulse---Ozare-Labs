import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:ozare/features/dash/widgets/search_bar.dart';
import 'package:ozare/features/search/bloc/search_bloc.dart';
import 'package:ozare/l10n/l10n.dart';
import 'package:ozare/styles/common/common.dart';
import 'package:ozare/features/wallet/widgets/widgets.dart';

import 'package:ozare/styles/common/widgets/widgets.dart';

class UpperSection extends StatefulWidget {
  const UpperSection({
    super.key,
  });

  @override
  State<UpperSection> createState() => _UpperSectionState();
}

class _UpperSectionState extends State<UpperSection> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.22,
      width: size.width,
      child: Stack(
        children: [
          // Oval Bottom Clipper
          Positioned(
            top: 0,
            child: SizedBox(
              height: size.height * 0.22,
              width: size.width,
              child: ClipPath(
                clipper: OvalBottomClipper(),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: gradient,
                  ),
                ),
              ),
            ),
          ),

          // Pattern Image
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/pattern.png',
              color: Colors.white.withOpacity(0.11),
              width: size.width,
              height: size.height * 0.3,
              fit: BoxFit.cover,
            ),
          ),

          // Menu & Title
          Positioned(
            top: 46,
            right: 24,
            left: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _Title(),
              ],
            ),
          ),

          Positioned(
            top: 10,
            right: 24,
            child: const WalletButton(),
          ),

          // SearchBar
          Positioned(
            top: size.height * 0.125,
            child: Container(
              height: 40,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: SearchBar(
                searchController: searchController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Ozare',
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
