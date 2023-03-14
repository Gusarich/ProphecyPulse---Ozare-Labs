import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:livescore_repository/livescore_repository.dart';
import 'package:ozare/features/dash/widgets/event_tile.dart';
import 'package:ozare/features/event/bloc/event_bloc.dart';
import 'package:ozare/features/event/view/event_page.dart';

class LeagueSection extends StatelessWidget {
  const LeagueSection({
    required this.league,
    required this.category,
    super.key,
  });

  final League league;
  final String category;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final events = league.events;
    return SizedBox(
      height: 216,
      width: size.width,
      child: Column(
        children: [
          // League Title
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 24),
            child: Row(
              children: [
                const Icon(
                  FontAwesome5.futbol,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '${league.name} (${league.events.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 190,
            width: size.width,
            child: CarouselSlider.builder(
              itemCount: events.length,
              options: CarouselOptions(
                height: 190,
                viewportFraction: 0.84,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
              ),
              itemBuilder: (context, index, _) {
                final event = events[index];

                return GestureDetector(
                  onTap: () {
                    context.read<EventBloc>()
                      ..add(EventInitializedRequested(event: event))
                      ..add(
                        EventLiveRequested(
                          event: event,
                          category: category,
                        ),
                      );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventPage(
                          leagueId: league.id,
                          event: event,
                          isLive: true,
                          fixture: null,
                        ),
                      ),
                    );
                  },
                  child: EventTile(event: event),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
