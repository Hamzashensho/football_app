import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/core/widget/image/carousel_slider.dart';
import 'package:sport_app_user/core/widget/match/match_card.dart';
import 'package:sport_app_user/core/widget/match/match_group.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 5),
      children: [
        CarouselWithDots(imageList: dummyImageList),
        SizedBox(height: SizeConfig.heightMultiplier * 3),
        MatchGroup(
          isFromHomePage: true,
          title: 'Junior Championship 8-10 years',
          matches: [
            MatchCard(
              date: '03/03/2024',
              time: '20:30',
              stadium: 'Stadium Name',
              group: 'Group A',
              status: 'Playing now',
              teamA: dummyTeams[1],
              teamB: dummyTeams[4],
              score: '2 - 1',
            ),
            MatchCard(
              date: '03/03/2024',
              time: '22:30',
              stadium: 'Stadium Name',
              group: 'Group B',
              status: 'Not started yet',
              teamA: dummyTeams[2],
              teamB: dummyTeams[0],
              score: '0 - 0',
            ),
          ],
        ),
        SizedBox(height: SizeConfig.heightMultiplier * 3),
        MatchGroup(
          title: 'Junior Championship 12-14 years',
          isFromHomePage: true,
          matches: [
            MatchCard(
              date: '03/03/2024',
              time: '16:30',
              stadium: 'Stadium Name',
              group: 'Group A',
              status: 'Playing now',
              teamA: dummyTeams[1],
              teamB: dummyTeams[4],
              score: '1 - 3',
            ),
          ],
        ),
        SizedBox(height: SizeConfig.heightMultiplier * 5),
      ],
    );
  }
}
