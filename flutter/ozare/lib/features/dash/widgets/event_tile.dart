import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:livescore_repository/livescore_repository.dart';
import 'package:ozare/styles/common/common.dart';

class EventTile extends StatelessWidget {
  const EventTile({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(
            'assets/images/bg.png',
          ),
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.hardLight),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
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
                if (event.logo1.isEmpty &&
                    event.category.contains('cricket')) ...[
                  Image.asset(
                    'assets/images/cricket_logo.png',
                    height: size.height * 0.07,
                  ),
                ] else ...[
                  Image.network(
                    event.logo1,
                    height: size.height * 0.07,
                  ),
                ],
                const SizedBox(height: 2),
                SizedBox(
                  height: size.height * 0.04,
                  child: AutoSizeText(
                    event.team1,
                    maxLines: 2,
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
            children: [
              Container(
                height: 22,
                width: 52,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  // add border circle only to bottom
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Live',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              if (event.score1 != '' && event.score2 != '') ...[
                Text(
                  '${event.score1} : ${event.score2}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ] else ...[
                const Text(
                  'VS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
              Text(
                event.time,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
            ],
          ),
          SizedBox(
            width: size.width * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (event.logo2.isEmpty &&
                    event.category.contains('cricket')) ...[
                  Image.asset(
                    'assets/images/cricket_logo.png',
                    height: size.height * 0.07,
                  )
                ] else ...[
                  Image.network(
                    event.logo2,
                    height: size.height * 0.07,
                  ),
                ],
                const SizedBox(height: 2),
                SizedBox(
                  height: size.height * 0.04,
                  child: AutoSizeText(
                    event.team2,
                    maxLines: 2,
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
