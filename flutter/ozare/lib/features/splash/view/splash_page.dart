import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ozare/app/routes.dart';
import 'package:ozare/features/auth/view/auth_page.dart';
import 'package:ozare/l10n/l10n.dart';
import 'package:ozare/styles/common/common.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, Routes.auth);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = context.l10n;
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: gradient,
              ),
            ),
            Image.asset(
              'assets/images/pattern.png',
              height: size.height * 1.1,
              width: size.width * 1.1,
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.05),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.width < 500 ? size.width * 0.4 : 76,
                  width: size.width < 500 ? size.width * 0.4 : 76,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: gradient,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF50ABEA).withGreen(180),
                        blurRadius: 12,
                        spreadRadius: 12,
                      )
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Animate(
                      effects: const [
                        ShakeEffect(
                          duration: Duration(
                            milliseconds: 500,
                          ),
                          delay: Duration(milliseconds: 500),
                        )
                      ],
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: size.width < 500 ? size.width * 0.4 : 72,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Ozare',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  l10n.firstSocialBettingPlatformOnTheTonBlockchain,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
