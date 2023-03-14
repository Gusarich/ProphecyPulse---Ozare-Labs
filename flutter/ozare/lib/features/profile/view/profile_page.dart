import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ozare/features/profile/bloc/profile_bloc.dart';
import 'package:ozare/features/profile/view/profile_view.dart';
import 'package:ozare/styles/common/common.dart';
import 'package:ozare_repository/ozare_repository.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        final status = state.status;

        if (status == ProfileStatus.loading) {
          return const Loader(message: 'Loading...');
        } else if (status == ProfileStatus.failure) {
          return const Center(child: Text('Something went wrong'));
        } else if (status == ProfileStatus.loaded) {
          final oUser = state.user;
          final page = state.page;

          return ProfileView(oUser: oUser, page: page, state: state);
        }
        return const Loader(message: 'Loading...');
      },
    );
  }
}
