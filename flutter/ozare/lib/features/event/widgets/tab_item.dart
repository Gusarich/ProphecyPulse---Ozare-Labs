import 'package:flutter/material.dart';
import 'package:ozare/styles/common/common.dart';

class TabItem extends StatelessWidget {
  const TabItem({
    required this.isActive,
    required this.label,
    required this.onTap,
    super.key,
  });

  final bool isActive;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: isActive
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: gradient,
              )
            : null,
        color: isActive ? null : Colors.transparent,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
