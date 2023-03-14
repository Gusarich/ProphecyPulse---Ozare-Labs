import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/features/dash/view/dash_view.dart';
import 'package:ozare/features/search/bloc/search_bloc.dart';
import 'package:ozare/features/search/view/schedule_view.dart';
import 'package:ozare/features/search/view/search_view.dart';
import 'package:ozare/styles/common/common.dart';

class DashPage extends StatelessWidget {
  const DashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          final searchStatus = state.status;
          switch (searchStatus) {
            case SearchStatus.none:
              return const DashView();

            case SearchStatus.loading:
              return const Loader(message: 'searching ...');
            case SearchStatus.succeed:
              return SearchView(teams: state.teams, state: state);
            case SearchStatus.failure:
              return const Loader(message: 'failure');

            case SearchStatus.fixtures:
              return ScheduleView(team: state.team!, fixtures: state.fixtures);
          }
        },
      ),
    );
  }
}
