import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:ozare/features/dash/bloc/basket_bloc.dart';
import 'package:ozare/features/dash/bloc/soccer_bloc.dart';
import 'package:ozare/features/dash/bloc/cricket_bloc.dart';
import 'package:ozare/features/dash/view/basket_view.dart';
import 'package:ozare/features/dash/view/soccer_view.dart';
import 'package:ozare/features/dash/view/cricket_view.dart';
import 'package:ozare/features/dash/widgets/widgets.dart';
import 'package:ozare/l10n/l10n.dart';

class DashView extends StatefulWidget {
  const DashView({
    super.key,
  });

  @override
  State<DashView> createState() => _DashViewState();
}

class _DashViewState extends State<DashView> {
  int selectedTab = 0;

  final _tabs = [
    const SoccerView(),
    const BasketView(),
    const CricketView(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        ///// APP BAR /////

        const UpperSection(),

        /// Match Categories
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MatchCategoryTabItem(
                  isActive: selectedTab == 0,
                  label: l10n.soccer,
                  onTap: () {
                    if (selectedTab == 0) return;
                    context.read<BasketBloc>().add(const BasketToggleLive());
                    context.read<CricketBloc>().add(const CricketToggleLive());

                    context
                        .read<SoccerBloc>()
                        .add(const SoccerLeaguesRequested(isNew: true));
            
                    setState(() {
                      selectedTab = 0;
                    });
                  },
                  icon: FontAwesome5.futbol,
                ),
                MatchCategoryTabItem(
                  isActive: selectedTab == 1,
                  label: l10n.basketball,
                  onTap: () {
                    if (selectedTab == 1) return;
                    context.read<SoccerBloc>().add(const SoccerToggleLive());
                    context.read<CricketBloc>().add(const CricketToggleLive());
                    context
                        .read<BasketBloc>()
                        .add(const BasketLeaguesRequested(isNew: true));
                  
                    setState(() {
                      selectedTab = 1;
                    });
                  },
                  icon: FontAwesome5.basketball_ball,
                ),
                MatchCategoryTabItem(
                  isActive: selectedTab == 2,
                  label: l10n.cricket,
                  onTap: () {
                    if (selectedTab == 2) return;
                    context.read<SoccerBloc>().add(const SoccerToggleLive());
                    context.read<BasketBloc>().add(const BasketToggleLive());
                 
                    context
                        .read<CricketBloc>()
                        .add(const CricketLeaguesRequested(isNew: true));
                    setState(() {
                      selectedTab = 2;
                    });
                  },
                  icon: FontAwesome5.bowling_ball,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _tabs[selectedTab],
      ],
    );
  }
}
