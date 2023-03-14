import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:ozare/features/profile/bloc/profile_bloc.dart';
import 'package:ozare/features/profile/widgets/widgets.dart';
import 'package:ozare/l10n/l10n.dart';
import 'package:ozare/styles/common/common.dart';

class AppBarProfileSection extends StatelessWidget {
  const AppBarProfileSection({
    required this.page,
    required this.imageUrl,
    super.key,
  })  : title = '',
        singlePage = false,
        appBarAction = null;

  const AppBarProfileSection.singlePage({
    required this.title,
    super.key,
    this.appBarAction,
  })  : singlePage = true,
        page = ProfileRoutes.profile,
        imageUrl = null;

  final ProfileRoutes page;
  final String title;
  final String? imageUrl;
  final bool singlePage;
  final Widget? appBarAction;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = context.l10n;

    return SizedBox(
      height: singlePage ? size.height * 0.125 : size.height * 0.28,
      width: size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // App Bar Section
          // height: size.height * 0.25,
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
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/pattern.png',
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.11),
              width: size.width,
              height: size.height * 0.3,
            ),
          ),
          Positioned(
            top: 46,
            right: 24,
            left: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (page == ProfileRoutes.profile || singlePage)
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white30,
                    child: Icon(
                      FontAwesome.award,
                      color: Colors.white,
                    ),
                  ),
                if (page != ProfileRoutes.profile)
                  GestureDetector(
                    onTap: () {
                      context
                          .read<ProfileBloc>()
                          .add(const ProfilePageChanged(ProfileRoutes.profile));
                    },
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white30,
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                Text(
                  singlePage ? title : getAppBarTitle(l10n),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                appBarAction ??
                    GestureDetector(
                      onTap: () {
                        context.read<ProfileBloc>().add(
                              const ProfilePageChanged(
                                ProfileRoutes.notifications,
                              ),
                            );
                      },
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white30,
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
              ],
            ),
          ),
          if (!singlePage)
            Positioned(
              top: size.height * 0.135,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PButton(
                    label: l10n.account,
                    icon: Icons.person_outline,
                    onTap: () {
                      context.read<ProfileBloc>().add(
                          const ProfilePageChanged(ProfileRoutes.editAccount));
                    },
                  ),
                  ProfilePhotoBox(
                    page: page,
                    imageUrl: imageUrl,
                  ),
                  PButton(
                    label: l10n.settings,
                    icon: Icons.settings_outlined,
                    onTap: () {
                      context.read<ProfileBloc>().add(
                            const ProfilePageChanged(ProfileRoutes.settings),
                          );
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String getAppBarTitle(AppLocalizations l10n) {
    switch (page) {
      case ProfileRoutes.profile:
        return l10n.profile;
      case ProfileRoutes.settings:
        return l10n.settings;
      case ProfileRoutes.editAccount:
        return l10n.editAccount;
      case ProfileRoutes.notifications:
        return l10n.notifications;
      case ProfileRoutes.wallet:
        return l10n.wallets;
      case ProfileRoutes.selectLanguage:
        return l10n.selectLanguage;
    }
  }
}
