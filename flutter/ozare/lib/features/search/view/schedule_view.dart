import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescore_repository/livescore_repository.dart';
import 'package:ozare/features/search/bloc/search_bloc.dart';
import 'package:ozare/features/search/widgets/schedule_tile.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({
    required this.fixtures,
    required this.team,
    super.key,
  });

  final List<Fixture> fixtures;
  final Team team;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.read<SearchBloc>().add(const SearchScheduleBackPressed());
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          "${team.name}'s Schedule",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      body: fixtures.isEmpty
          ? const Center(
              child: Text('No Schedule found!'),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 66),
              itemCount: fixtures.length,
              itemBuilder: (context, index) => ScheduleTile(
                fixture: fixtures[index],
                fromEvent: false,
              ),
            ),
    );
  }
}
