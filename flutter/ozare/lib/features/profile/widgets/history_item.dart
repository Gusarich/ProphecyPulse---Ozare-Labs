import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:ozare_repository/ozare_repository.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    super.key,
    required this.bet,
  });

  final Bet bet;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 22,
          width: 52,
          decoration: BoxDecoration(
            color: !bet.finished
                ? Colors.grey.withOpacity(0.1)
                : getColor(won: bet.won).withOpacity(0.1),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Center(
            child: Text(
              bet.finished ? getStatus(won: bet.won) : 'Pending',
              style: TextStyle(
                color: !bet.finished ? Colors.grey : getColor(won: bet.won),
                fontWeight: FontWeight.w600,
                fontSize: 8,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${DateFormat.Hm().format(bet.createdAt.toLocal())} - ${DateFormat.yMMMd().format(bet.createdAt.toLocal())}',
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.245,
              child: AutoSizeText(
                bet.team1,
                maxFontSize: 12,
                minFontSize: 8,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 6),
            SizedBox(
              width: 24,
              height: 24,
              child: Image.network(bet.logo1),
            ),
            const SizedBox(width: 8),
            Text(
              '${bet.score1} : ${bet.score2}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 24,
              height: 24,
              child: Image.network(bet.logo2),
            ),
            const SizedBox(width: 6),
            SizedBox(
              width: size.width * 0.245,
              child: AutoSizeText(
                bet.team2,
                maxFontSize: 12,
                minFontSize: 8,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'You betted ${bet.tokens} Tokens on ${bet.yourTeam == 0 ? bet.team1 : bet.team2} to win',
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 10,
          ),
        ),
        Divider(
          color: Colors.grey[500],
        ),
      ],
    );
  }

  Color getColor({bool? won = false}) {
    switch (won) {
      case true:
        return const Color(0xFF00BA88);
      case false:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String getStatus({bool? won = false}) {
    switch (won) {
      case true:
        return 'Won';
      case false:
        return 'Lost';
      default:
        return 'Pending';
    }
  }
}
