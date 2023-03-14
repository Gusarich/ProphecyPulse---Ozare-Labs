import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:ozare/features/auth/bloc/auth_bloc.dart';
import 'package:ozare/features/profile/view/language_view.dart';
import 'package:ozare/features/profile/widgets/widgets.dart';
import 'package:ozare/l10n/l10n.dart';
import 'package:ozare/styles/common/widgets/widgets.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Heading(heading: l10n.personalInfo),
            const SizedBox(height: 8),
            OptionsBox(
              children: [
                ProfileTile(
                  label: l10n.wallet,
                  icon: Icons.account_balance_wallet_outlined,
                  onTap: () {},
                ),
                ProfileTile(
                  label: l10n.statistics,
                  icon: Icons.bar_chart_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            Heading(heading: l10n.settings),
            const SizedBox(height: 8),
            OptionsBox(
              children: [
                ProfileTile(
                  label: l10n.notifications,
                  icon: Icons.notifications_active_outlined,
                  onTap: () {},
                ),
                ProfileTile(
                  label: l10n.preferences,
                  icon: Icons.settings_outlined,
                  onTap: () {},
                ),
                ProfileTile(
                  label: l10n.languages,
                  icon: Icons.language_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LanguageView(),
                      ),
                    );
                  },
                ),
                ProfileTile(
                  label: l10n.logOut,
                  icon: Icons.logout_outlined,
                  onTap: () {
                    context.read<AuthBloc>().add(const AuthLogoutRequested());
                    Phoenix.rebirth(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Heading(heading: l10n.support),
            const SizedBox(height: 8),
            OptionsBox(
              children: [
                ProfileTile(
                  label: l10n.getHelp,
                  icon: Icons.help_outline,
                  onTap: () {},
                ),
                ProfileTile(
                  label: l10n.faq,
                  icon: Icons.question_answer_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 72),
          ],
        ),
      ),
    );
  }
}
