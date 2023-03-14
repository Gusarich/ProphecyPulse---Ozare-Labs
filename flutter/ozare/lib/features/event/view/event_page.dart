import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescore_repository/livescore_repository.dart' as livescore;
import 'package:ozare/features/event/bloc/event_bloc.dart';
import 'package:ozare/features/event/view/event_view.dart';

class EventPage extends StatelessWidget {
  const EventPage({
    required this.leagueId,
    required this.event,
    required this.isLive,
    required this.fixture,
    super.key,
  });

  final String? leagueId;
  final livescore.Event event;
  final bool isLive;
  final livescore.Fixture? fixture;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventBloc, EventState>(
      listener: (context, state) {
        log('Event Bloc listener ${state.runtimeType}');
      },
      builder: (context, state) {
        return EventView(
          event: event,
          leagueId: leagueId,
          isLive: isLive,
          fixture: fixture,
        );
      },
    );
  }
}
