import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ozare/features/auth/bloc/auth_bloc.dart';

import 'package:ozare/features/onboard/widgets/widgets.dart';
import 'package:ozare/l10n/l10n.dart';
import 'package:ozare/styles/common/common.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = context.l10n;
    final contents = [
      OnboardContent(
        bgImage: 'assets/images/mockup.png',
        fgImage: 'assets/images/tiles.png',
        title: l10n.transformAnyTestIntoABet,
        subtitle: l10n.addOurTelegramBot,
      ),
    ];
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: gradient,
              ),
            ),
            Animate(
              effects: const [
                SlideEffect(
                  begin: Offset(1, 0),
                  duration: Duration(milliseconds: 500),
                )
              ],
              child: Positioned(
                top: size.height * 0.15,
                right: 0,
                bottom: size.height * 0.1,
                child: Image.asset(contents[_currentPage].bgImage),
              ),
            ),
            Animate(
              effects: const [
                SlideEffect(
                  begin: Offset(-1, 0),
                  delay: Duration(milliseconds: 400),
                  duration: Duration(milliseconds: 400),
                )
              ],
              child: Positioned(
                top: size.height * 0.12,
                left: -30,
                right: size.width * 0.3,
                bottom: size.height * 0.1,
                child: Image.asset(contents[_currentPage].fgImage),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                height: size.height * 0.36,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    const Spacer(),
                    AutoSizeText(
                      contents[_currentPage].title,
                      maxFontSize: 24,
                      minFontSize: 20,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      contents[_currentPage].subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    // const Spacer(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children:
                    //       List.generate(3, (index) => buildDot(index: index))
                    // ,
                    // ),
                    const Spacer(),
                    if (!kIsWeb)
                      Animate(
                        onComplete: (controller) {
                          controller.repeat();
                        },
                        effects: const [
                          // repeat this effect

                          ShimmerEffect(
                            duration: Duration(milliseconds: 1000),
                            delay: Duration(milliseconds: 900),
                          )
                        ],
                        child: CButton(
                          onTap: () {
                            context
                                .read<AuthBloc>()
                                .add(const AuthOnboardingCompleted());
                          },
                          label: l10n.getStarted,
                        ),
                      ),
                    if (kIsWeb)
                      CButton(
                        onTap: () {
                          context
                              .read<AuthBloc>()
                              .add(const AuthOnboardingCompleted());
                        },
                        label: l10n.getStarted,
                      ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 7),
      height: _currentPage == index ? 8 : 8,
      width: _currentPage == index ? 16 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? primary1Color : Colors.grey[200],
        shape: _currentPage == index ? BoxShape.rectangle : BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class OnboardContent {
  const OnboardContent({
    required this.bgImage,
    required this.fgImage,
    required this.title,
    required this.subtitle,
  });

  final String bgImage;
  final String fgImage;
  final String title;
  final String subtitle;
}
