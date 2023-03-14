import 'package:flutter/material.dart';
import 'package:ozare/styles/common/common.dart';

class ConversationHeader extends StatelessWidget {
  const ConversationHeader({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xFF14142B),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          // User Avatar
          const CircleAvatar(
            radius: 23,
            backgroundColor: primary1Color,
            child: CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
          ),

          // User Name
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Tomer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                'Online',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
