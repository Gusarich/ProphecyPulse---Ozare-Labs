import 'package:flutter/material.dart';
import 'package:livescore_repository/livescore_repository.dart';
import 'package:ozare/features/dash/widgets/upper_section.dart';
import 'package:ozare/features/search/bloc/search_bloc.dart';
import 'package:ozare/features/search/widgets/widgets.dart';

class SearchView extends StatelessWidget {
  const SearchView({
    super.key,
    required this.teams,
    required this.state,
  });

  final List<Team> teams;
  final SearchState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const UpperSection(),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 24),
            child: Text(
              "Showing Results for '${state.query}'",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 241, 146, 146),
                fontSize: 12,
              ),
            ), 
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 64),
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final team = teams[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TeamTile(team: team),
              );
            },
          ),
        )
      ],
    );
  }
}
