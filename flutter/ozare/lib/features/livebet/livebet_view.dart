import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import 'package:ozare/features/livebet/bloc/livebet_bloc.dart';
import 'package:ozare/features/profile/widgets/widgets.dart';
import 'package:ozare/styles/common/common.dart';
import 'package:ozare_repository/ozare_repository.dart';

class LiveBetsView extends StatelessWidget {
  const LiveBetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Hero(
              tag: 'trophy',
              child: Icon(
                FontAwesome.award,
                color: primary2Color,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Your Bets',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[900],
              ),
            ),
            const SizedBox(width: 32),
          ],
        ),
        actions: const [
          SizedBox(
            width: 32,
          ),
        ],
      ),
      body: BlocBuilder<LiveBetBloc, LiveBetState>(
        builder: (context, state) {
          final bets = state.liveBets;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: bets.isEmpty
                ? Center(
                    child: Text(
                      'No bets yet',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[900],
                      ),
                    ),
                  )
                : SizedBox.expand(
                    child: ListView.builder(
                      itemCount: bets.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: HistoryItem(bet: bets[index]),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class LivebetTile extends StatelessWidget {
  const LivebetTile({
    super.key,
    required this.bet,
  });

  final Bet bet;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: 120,
      width: size.width,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(
            'assets/images/bg.png',
          ),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.hardLight,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primary2Color.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: size.width * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  bet.logo1,
                  height: size.height * 0.05,
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: size.height * 0.04,
                  child: AutoSizeText(
                    bet.team1,
                    maxLines: 2,
                    maxFontSize: 14,
                    minFontSize: 10,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${bet.score1} : ${bet.score2}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${bet.tokens} Tokens',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(
            width: size.width * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  bet.logo2,
                  height: size.height * 0.05,
                ),
                const SizedBox(height: 2),
                SizedBox(
                  height: size.height * 0.04,
                  child: AutoSizeText(
                    bet.team2,
                    maxLines: 2,
                    maxFontSize: 14,
                    minFontSize: 10,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
