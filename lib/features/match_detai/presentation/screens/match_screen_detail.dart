// match_screen.dart
import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/features/match_detai/presentation/widgets/match_event_item.dart';
import 'package:sport_app_user/features/match_detai/presentation/widgets/match_header.dart';
import 'package:sport_app_user/features/match_detai/presentation/widgets/match_time_line_section.dart';

class MatchDetailScreen extends StatelessWidget {
  final TeamModel teamA;
  final TeamModel teamB;
  final String stadium;
  final String group;
  final String score;

  const MatchDetailScreen({
    super.key,
    required this.teamA,
    required this.teamB,
    required this.stadium,
    required this.group,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
             MatchHeader(teamA:teamA ,teamB: teamB,stadium: stadium,score: score,group:group ,),
            Expanded(
              child: ListView(
                padding:  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*4, vertical: SizeConfig.heightMultiplier*1.2),
                children: const [
                  MatchTimelineSection(
                    title: 'First Half',
                    events: [
                      MatchEventItem(
                        playerName: 'Ferran Torres',
                        minute: '15\'',
                        iconAsset: Assets.goalIcon,
                        isLeftSide: true,
                      ),
                      MatchEventItem(
                        playerName: 'Kylian Mbappé',
                        minute: '21\'',
                        iconAsset: Assets.yellowCardIcon,
                        isLeftSide: false,
                      ),
                      MatchEventItem(
                        playerName: 'Kylian Mbappé',
                        minute: '33\'',
                        iconAsset: Assets.goalIcon,
                        isLeftSide: false,
                      ),
                    ],
                  ),
                  MatchTimelineSection(
                    title: 'Second Half',
                    events: [
                      MatchEventItem(
                        playerName: 'Ferran Torres',
                        minute: '51\'',
                        iconAsset: Assets.goalIcon,
                        isLeftSide: true,
                      ),
                      MatchEventItem(
                        playerName: 'Ferran Torres',
                        minute: '51\'',
                        iconAsset: Assets.yellowCardIcon,
                        isLeftSide: true,
                      ),
                      MatchEventItem(
                        playerName: 'Kylian Mbappé',
                        minute: '65\'',
                        iconAsset: Assets.redCardIcon,
                        isLeftSide: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
