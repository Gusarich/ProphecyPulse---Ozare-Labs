import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ozare/styles/common/common.dart';

class OButton extends StatelessWidget {
  const OButton({
    super.key,
    required this.onTap,
    required this.label,
  })  : iconPath = '',
        isIcon = false;

  const OButton.icon({
    super.key,
    required this.onTap,
    required this.iconPath,
  })  : label = '',
        isIcon = true;

  final VoidCallback onTap;
  final String label;
  final String iconPath;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isIcon ? Colors.grey[200] : null,
          gradient: isIcon ? null : gradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: isIcon
              ? SvgPicture.asset(
                  iconPath,
                  height: 32,
                  width: 32,
                )
              : Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.4,
                  ),
                ),
        ),
      ),
    );
  }
}
