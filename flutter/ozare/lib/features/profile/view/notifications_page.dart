import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/features/profile/bloc/profile_bloc.dart';

import '../widgets/widgets.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppBarProfileSection.singlePage(
          title: 'Notifications',
        ),
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Expanded(
              child: state.notifications.isEmpty
                  ?

                  // If there are no notifications
                  const Center(
                      child: Text('No Notifications'),
                    )
                  : ListView.builder(
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child:
                                HistoryItem(bet: state.notifications[index]));
                      },
                    ),
            );
          },
        )
      ],
    );
  }
}


