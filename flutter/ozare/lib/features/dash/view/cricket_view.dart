import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/features/dash/bloc/cricket_bloc.dart';
import 'package:ozare/features/dash/widgets/league_section.dart';
import 'package:ozare/features/dash/widgets/loading_section.dart';
import 'package:ozare/features/dash/widgets/no_events_tile.dart';

class CricketView extends StatefulWidget {
  const CricketView({
    super.key,
  });

  @override
  State<CricketView> createState() => _CricketViewState();
}

class _CricketViewState extends State<CricketView> {
  late final ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });
      BlocProvider.of<CricketBloc>(context).add(
        const CricketLeaguesRequested(isNew: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CricketBloc, CricketState>(
      builder: (context, state) {
        final status = state.status;
        if (status == CricketStatus.loading && state.leagues.isEmpty) {
          return const LoadingSection();
        } else if (status == CricketStatus.failure) {
          return Center(
            child: Text(state.message),
          );
        }

        final leagues = state.leagues;
        return leagues.isEmpty
            ? const NoEventsTile()
            : NotificationListener<ScrollNotification>(
                onNotification: (_) {
                  return true;
                },
                child: Flexible(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    controller: _scrollController,
                    padding: const EdgeInsets.only(bottom: 32),
                    itemCount:
                        _isLoadingMore ? leagues.length + 1 : leagues.length,
                    itemBuilder: (context, index) {
                      if (_isLoadingMore && index == leagues.length) {
                        return const SizedBox();
                      }

                      final league = leagues[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: LeagueSection(
                          league: league,
                          category: 'cricket',
                        ),
                      );
                    },
                  ),
                ),
              );
      },
    );
  }
}
