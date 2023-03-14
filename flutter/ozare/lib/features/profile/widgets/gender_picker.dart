import 'package:flutter/material.dart';
import 'package:ozare/styles/common/common.dart';

class GenderPicker extends StatelessWidget {
  const GenderPicker({
    required this.label,
    required this.onTap,
    required this.isActive,
    super.key,
  });

  final String label;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: size.width * 0.42,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Checkbox(
              activeColor: primary1Color,
              checkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              value: isActive,
              onChanged: (val) {},
            ),
            const SizedBox(width: 2),
            Text(label),
          ],
        ),
      ),
    );
  }
}
