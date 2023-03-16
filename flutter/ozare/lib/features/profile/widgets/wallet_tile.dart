import 'package:flutter/material.dart';
import 'package:ozare/features/profile/models/models.dart';
import 'package:ozare/features/profile/view/view.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class WalletTile extends StatelessWidget {
  const WalletTile({
    super.key,
    required this.wallet,
  });

  final Wallet wallet;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      margin: const EdgeInsets.only(bottom: 12, right: 24, left: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Image.asset(
            wallet.iconPath,
            height: 42,
            width: 42,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                wallet.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.5,
                    child: Text(
                      wallet.key,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Icon(
                  //   Icons.copy,
                  //   color: Colors.grey[600],
                  //   size: 16,
                  // ),
                ],
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.copy,
              color: Colors.grey[600]!,
              size: 22,
            ),
          )
        ],
      ),
    );
  }
}
