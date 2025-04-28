import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/routing/route_paths.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'match_card.dart';

class MatchGroup extends StatelessWidget {
  final String title;
  final List<MatchCard> matches;
  final bool isFromHomePage;

  const MatchGroup({
    super.key,
    required this.title,
    required this.matches,
    this.isFromHomePage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            isFromHomePage
                ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: SizeConfig.heightMultiplier * 2.8,
                      width: SizeConfig.widthMultiplier * 12,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(
                          SizeConfig.widthMultiplier * 5,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RoutePaths.matchListScreen,
                          arguments: {
                            'title': title,
                            'matches': matches,
                          },
                        );

                      },
                      icon: Image.asset(Assets.rightArrowIcon),
                    ),
                  ],
                )
                : const SizedBox(),
          ],
        ),
        const SizedBox(height: 8),
        ...matches,
      ],
    );
  }
}
