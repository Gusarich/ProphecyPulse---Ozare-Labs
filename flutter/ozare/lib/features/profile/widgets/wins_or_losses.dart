import 'package:flutter/material.dart';
import 'package:ozare/features/profile/widgets/stat_box.dart';
import 'package:ozare/l10n/l10n.dart';

class WinOrLosses extends StatelessWidget {
  const WinOrLosses({
    required this.wins,
    required this.losses,
    super.key,
  });

  final int wins;
  final int losses;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StatBox(
          label: l10n.wins,
          value: wins,
        ),
        const SizedBox(width: 16),
        StatBox(
          label: l10n.loss,
          value: losses,
        ),
      ],
    );
  }
}
