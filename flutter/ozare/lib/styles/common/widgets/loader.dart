import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ozare/styles/common/common.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: primary1Color,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Animate(
                onComplete: (controller) {
                  controller.repeat();
                },
                effects: const [ShimmerEffect()],
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
