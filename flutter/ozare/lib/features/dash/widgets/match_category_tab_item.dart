import 'package:flutter/material.dart';
import 'package:ozare/styles/common/common.dart';

class MatchCategoryTabItem extends StatelessWidget {
  const MatchCategoryTabItem({
    required this.onTap,
    required this.isActive,
    required this.label,
    required this.icon,
    super.key,
  });

  final VoidCallback onTap;
  final bool isActive;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        margin: const EdgeInsets.only(right: 16, bottom: 12),
        padding: const EdgeInsets.only(left: 10, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: isActive ? primary2Color : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : primary2Color.withOpacity(0.9),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : primary2Color.withOpacity(0.9),
                fontWeight: isActive ? FontWeight.w600 : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
