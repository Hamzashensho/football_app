// widgets/match_header.dart
import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/features/match_detai/presentation/widgets/time_progress_indecator.dart';

class MatchHeader extends StatelessWidget {
  final TeamModel teamA, teamB;
  final String stadium, group;
  final String score;

  const MatchHeader({
    super.key,
    required this.teamA,
    required this.teamB,
    required this.stadium,
    required this.group,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          Assets.onBoarding1,
          height: SizeConfig.heightMultiplier * 40,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: SizeConfig.heightMultiplier * 3.5,
          left: SizeConfig.widthMultiplier * 6,
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MatchTimerIndicator(
                progress: 71 / 90, // 71 minutes out of 90
                timeText: '71:05',
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 5),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        teamA.logo,
                        height: SizeConfig.heightMultiplier * 5,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1.8),
                      Text(teamA.name, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(width: SizeConfig.widthMultiplier * 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '2 - 1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: SizeConfig.widthMultiplier * 8),
                  Column(
                    children: [
                      Image.asset(
                        teamB.logo,
                        height: SizeConfig.heightMultiplier * 5,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1.8),
                      Text(teamB.name, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
               SizedBox(height: SizeConfig.heightMultiplier*10),
              Padding(
                padding: EdgeInsets.only(right: SizeConfig.widthMultiplier*60),
                child:  Text(
                  stadium,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
