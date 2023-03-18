import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescore_repository/livescore_repository.dart' as livescore;
import 'package:ozare/features/bet/bloc/bet_bloc.dart';
import 'package:ozare/features/chat/bloc/chat_bloc.dart';
import 'package:ozare/features/dash/widgets/event_tile.dart';
import 'package:ozare/features/event/bloc/event_bloc.dart';
import 'package:ozare/features/event/widgets/widgets.dart';
import 'package:ozare/features/search/widgets/schedule_tile.dart';
import 'package:ozare/styles/common/common.dart';
import 'package:ozare_repository/ozare_repository.dart' as ozare;

class EventView extends StatefulWidget {
  const EventView({
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
  State<EventView> createState() => _MatchViewState();
}

class _MatchViewState extends State<EventView> {
  late final List<Widget> _tabs;

  int selectedTab = 0;

  @override
  void initState() {
    _tabs = [
      BlocProvider(
        create: (context) => ChatBloc(
          chatRepository:
              ozare.ChatRepository(firestore: FirebaseFirestore.instance),
          eventId: widget.event.id,
        )..add(ChatSubscriptionRequested()),
        child: const ChatView(),
      ),
      BlocProvider(
        create: (context) => BetBloc(
          betRepository:
              ozare.BetRepository(firestore: FirebaseFirestore.instance),
          eventId: widget.event.id,
        )..add(const BetSubscriptionRequested()),
        child: BetView(event: widget.event),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UpperSection(
            event: widget.event,
            leagueId: widget.leagueId,
            isLive: widget.isLive,
            fixture: widget.fixture,
          ),
          const SizedBox(height: 12),
          // Tab Bar Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                TabItem(
                  isActive: selectedTab == 0,
                  label: 'Chat',
                  onTap: () {
                    setState(() {
                      selectedTab = 0;
                    });
                  },
                ),
                TabItem(
                  isActive: selectedTab == 1,
                  label: 'Bets',
                  onTap: () {
                    setState(() {
                      selectedTab = 1;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          DottedLine(
            dashColor: Colors.grey[300]!,
          ),
          Expanded(child: _tabs[selectedTab]),
        ],
      ),
    );
  }
}

/// Upper Section
class UpperSection extends StatelessWidget {
  const UpperSection({
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
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.27,
      width: size.width,
      child: Stack(
        children: [
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
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white30,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                const Text(
                  'Match',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white30,
                  child: Icon(Icons.more_vert, color: Colors.white),
                ),
              ],
            ),
          ),

          // Match List Section
          // height: size.height * 0.15,
          Positioned(
            top: size.height * 0.12,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.155,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: isLive
                  ? EventTile(
                      event: event,
                    )
                  : ScheduleTile(
                      fixture: fixture!,
                      fromEvent: true,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
