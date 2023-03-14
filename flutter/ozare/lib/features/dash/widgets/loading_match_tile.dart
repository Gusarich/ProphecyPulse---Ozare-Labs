import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:ozare/styles/common/common.dart';

class LoadingMatchTile extends StatelessWidget {
  const LoadingMatchTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      onComplete: (controller) {
        controller.repeat();
      },
      effects: [
        ShimmerEffect(
          duration: const Duration(milliseconds: 400),
          color: primary2Color.withOpacity(0.3),
        ),
      ],
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
      ),
    );
  }
}
