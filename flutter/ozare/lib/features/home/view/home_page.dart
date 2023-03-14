import 'package:flutter/material.dart';
import 'package:ozare/features/dash/bloc/basket_bloc.dart';
import 'package:ozare/features/dash/bloc/cricket_bloc.dart';
import 'package:ozare/features/dash/bloc/soccer_bloc.dart';
import 'package:ozare/features/home/view/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/features/livebet/bloc/livebet_bloc.dart';
import 'package:ozare/features/profile/bloc/profile_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<SoccerBloc>().add(const SoccerLeaguesRequested(isNew: false));
    context.read<ProfileBloc>()
      ..add(const ProfileHistoryRequested())
      ..add(const ProfileNotificationsRequested());
    context.read<LiveBetBloc>().add(const LiveBetsRequested());
    context.read<LiveBetBloc>().add(const LiveBetsUpdated());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}
