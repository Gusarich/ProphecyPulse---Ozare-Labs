import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livescore_repository/livescore_repository.dart';
import 'package:ozare/features/dash/bloc/basket_bloc.dart';
import 'package:ozare/features/dash/widgets/league_section.dart';
import 'package:ozare/features/dash/widgets/loading_section.dart';
import 'package:ozare/features/dash/widgets/no_events_tile.dart';

class BasketView extends StatefulWidget {
  const BasketView({
    super.key,
  });

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
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
      BlocProvider.of<BasketBloc>(context).add(
        const BasketLeaguesRequested(isNew: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
        final status = state.status;
        if (status == BasketStatus.loading && state.leagues.isEmpty) {
          return const LoadingSection();
        } else if (status == BasketStatus.failure) {
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
                          category: 'basketball',
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
