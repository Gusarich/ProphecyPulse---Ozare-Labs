import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:livescore_repository/livescore_repository.dart';

import 'package:ozare/features/bet/bloc/bet_bloc.dart';
import 'package:ozare/features/bet/widgets/widgets.dart';

import 'package:ozare/styles/common/common.dart';
import 'package:ozare/styles/common/widgets/dialogs/dialogs.dart';
import 'package:ozare_repository/ozare_repository.dart' as ozare;

class BetView extends StatelessWidget {
  const BetView({
    required this.event,
    super.key,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          /// show input dialog
          showDialog(
            context: context,
            builder: (_) => BlocProvider<BetBloc>.value(
              value: context.read<BetBloc>(),
              child: BetDialog(event: event),
            ),
          );
        },
        backgroundColor: primary2Color,
        label: const Text('Place a Bet'),
        icon: const Icon(
          FontAwesome.award,
          color: Colors.white,
        ),
      ),
      body: SizedBox(
        height: size.height * 0.55,
        child: Column(
          children: [
            const BetHeader(),
            const Divider(),

            //// BET LIST ////

            BlocConsumer<BetBloc, BetState>(
              listener: (context, state) {
                if (state.betStatus == CreateBetStatus.exists) {
                  showSnackBar(context, 'You already betted on this match');
                }
              },
              builder: (context, state) {
                final status = state.status;
                if (status == BetStatus.loading) {
                  return const Loader(
                    message: 'Bets Loading ...',
                  );
                } else if (status == BetStatus.failure) {
                  return const Center(
                    child: Text('Bets Loading Failed'),
                  );
                } else if (status == BetStatus.success) {
                  final bets = state.bets;
                  if (bets.isEmpty) {
                    return const Center(
                      child: Text('No Bets Found'),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: bets.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: BetTile(bet: bets[index]),
                        );
                      },
                    ),
                  );
                }

                return const Loader(message: 'Loading...');
              },
            ),
          ],
        ),
      ),
    );
  }
}
