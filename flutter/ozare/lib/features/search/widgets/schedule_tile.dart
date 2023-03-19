import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:livescore_repository/livescore_repository.dart';
import 'package:ozare/features/event/view/event_page.dart';
import 'package:ozare/styles/common/common.dart';

class ScheduleTile extends StatelessWidget {
  const ScheduleTile({
    super.key,
    required this.fixture,
    required this.fromEvent,
  });

  final Fixture fixture;
  final bool fromEvent;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final d = DateTime.parse(fixture.date);
    final dt =
        '${d.hour}:${d.minute.toString().padRight(2, '0')}\n${d.day}-${d.month}-${d.year}';
    return GestureDetector(
      onTap: fromEvent
          ? () {}
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventPage(
                    event: Event(
                      category: 'event',
                      id: fixture.id.toString(),
                      id1: fixture.team1ID.toString(),
                      id2: fixture.team2ID.toString(),
                      team1: fixture.team1Name,
                      team2: fixture.team2Name,
                      logo1: fixture.team1Logo,
                      logo2: fixture.team2Logo,
                      score1: '',
                      score2: '',
                      time: dt,
                    ),
                    leagueId: null,
                    fixture: fixture,
                    isLive: false,
                  ),
                ),
              );
            },
      child: Container(
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
                    fixture.team1Logo,
                    height: size.height * 0.05,
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: size.height * 0.04,
                    child: AutoSizeText(
                      fixture.team1Name,
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
                SizedBox(
                  width: 64,
                  child: AutoSizeText(
                    dt,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    maxFontSize: 12,
                    minFontSize: 10,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'VS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 64,
                  child: AutoSizeText(
                    fixture.venueName,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    maxFontSize: 10,
                    minFontSize: 9,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 64,
                  child: AutoSizeText(
                    fixture.venueCity,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    maxFontSize: 10,
                    minFontSize: 8,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
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
                    fixture.team2Logo,
                    height: size.height * 0.05,
                  ),
                  const SizedBox(height: 2),
                  SizedBox(
                    height: size.height * 0.04,
                    child: AutoSizeText(
                      fixture.team2Name,
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
      ),
    );
  }
}
