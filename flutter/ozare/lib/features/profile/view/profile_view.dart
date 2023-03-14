import 'package:flutter/material.dart';
import 'package:ozare/features/profile/bloc/profile_bloc.dart';
import 'package:ozare/features/profile/view/view.dart';
import 'package:ozare/features/profile/widgets/widgets.dart';
import 'package:ozare/l10n/l10n.dart';
import 'package:ozare/styles/common/widgets/widgets.dart';
import 'package:ozare_repository/ozare_repository.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
    required this.oUser,
    required this.page,
    required this.state,
  });

  final ProfileRoutes page;
  final OUser oUser;
  final ProfileState state;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        AppBarProfileSection(
          page: widget.page,
          imageUrl: widget.oUser.photoURL,
        ),

        // Name
        if (widget.page != ProfileRoutes.editAccount) ...[
          Text(
            '${widget.oUser.firstName} ${widget.oUser.lastName}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
        ],

        /// wins and losses
        if (widget.page != ProfileRoutes.editAccount) ...[
          WinOrLosses(
            wins: widget.oUser.wins,
            losses: widget.oUser.losses,
          ),
          const SizedBox(height: 24),
        ],

        /// Notifications
        /// For Notifications Page Only
        if (widget.page == ProfileRoutes.notifications) ...[
          Heading(heading: l10n.notifications),
          const SizedBox(height: 8),
          Expanded(
            child: widget.state.notifications.isEmpty
                ? const Center(child: Text('No Notifications'))
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 64),
                    itemCount: widget.state.notifications.length,
                    itemBuilder: (context, index) {
                      return HistoryItem(
                        bet: widget.state.notifications[index],
                      );
                    },
                  ),
          ),
        ],

        /// Edit Account
        /// For Edit account Page Only
        if (widget.page == ProfileRoutes.editAccount)
          EditAccountView(oUser: widget.oUser),

        /// Personal Info
        /// For Settings Page Only
        if (widget.page == ProfileRoutes.settings) const SettingsView(),

        /// Recent History
        /// for Profile Page only
        if (widget.page == ProfileRoutes.profile) ...[
          Heading(heading: l10n.recentHistory),
          const SizedBox(height: 8),
          Expanded(
            child: widget.state.history.isEmpty
                ? const Center(child: Text('No History'))
                : ListView.builder(
                    padding: const EdgeInsets.only(
                      bottom: 64,
                      left: 24,
                      right: 24,
                    ),
                    itemCount: widget.state.history.length,
                    itemBuilder: (context, index) {
                      return HistoryItem(
                        bet: widget.state.history[index],
                      );
                    },
                  ),
          ),
        ]
      ],
    );
  }
}
