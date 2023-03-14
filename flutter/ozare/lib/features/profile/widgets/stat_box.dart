import 'package:flutter/material.dart';
import 'package:ozare/styles/common/common.dart';

class StatBox extends StatelessWidget {
  const StatBox({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 80,
      width: size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primary1Color),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 12,
            top: 12,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              height: 54,
              width: 54,
              decoration: const BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(15, 15),
                  topLeft: Radius.circular(32),
                  topRight: Radius.elliptical(22, 6),
                  bottomLeft: Radius.elliptical(6, 22),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
