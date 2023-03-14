import 'package:flutter/material.dart';
import 'package:ozare_repository/ozare_repository.dart';


class BetTile extends StatelessWidget {
  const BetTile({
    required this.bet,
    super.key,
  });

  final Bet bet;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 1, 1, 1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.4,
                child: Row(
                  children: [
                    // User Avatar
                    // const CircleAvatar(
                    //   radius: 21,
                    //   backgroundColor: primary1Color,
                    //   child: CircleAvatar(
                    //     radius: 20,
                    //     backgroundImage: AssetImage('assets/images/user.png'),
                    //   ),
                    // ),

                    // User Name
                    const SizedBox(width: 8),
                    Text(
                      bet.userName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.2,
                child: Center(
                  child: Text(
                    "${bet.tokens} TON",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.2,
                child: Center(
                  child: Image.asset(
                    'assets/images/token.png',
                    height: 28,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
