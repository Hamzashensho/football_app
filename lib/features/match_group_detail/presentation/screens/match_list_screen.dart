import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/core/widget/buttons/custom_tab_button.dart';
import 'package:sport_app_user/core/widget/match/match_card.dart';
import 'package:sport_app_user/core/widget/match/match_group.dart';

class MatchesListScreen extends StatefulWidget {
  final String title;
  final List<MatchCard> matches;

  const MatchesListScreen({
    super.key,
    required this.title,
    required this.matches,
  });

  @override
  State<MatchesListScreen> createState() => _MatchesListScreenState();
}

class _MatchesListScreenState extends State<MatchesListScreen> {
  int selectedTab=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.onBoarding3),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            // TabBar and TabViews
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.grey[200],
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CustomTabButton(title: "Current matches", isSelected:selectedTab==0 , onTap: (){
                          setState(() {
                            selectedTab=0;
                          });
                        }),
                        CustomTabButton(title: "Quarter-finals", isSelected:selectedTab==1 , onTap: (){
                          setState(() {
                            selectedTab=1;
                          });
                        }),
                        CustomTabButton(title: "Semi-finals", isSelected:selectedTab==2, onTap: (){
                          setState(() {
                            selectedTab=2;
                          });
                        }),CustomTabButton(title: "Final", isSelected:selectedTab==3, onTap: (){
                          setState(() {
                            selectedTab=3;
                          });
                        }),
                      ],
                    ),
                  ),
                ),
                selectedTab==0?MatchGroupTab(
                  title: widget.title,
                  matches: widget.matches,
                ):selectedTab==1?
                MatchGroupTab(
                  title: widget.title,
                  matches: widget.matches,
                ):selectedTab==2?
                MatchGroupTab(
                  title: widget.title,
                  matches: widget.matches,
                ):selectedTab==3?
                MatchGroupTab(
                  title: widget.title,
                  matches: widget.matches,
                ):Placeholder()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MatchGroupTab extends StatelessWidget {
  final String title;
  final List<MatchCard> matches;

  const MatchGroupTab({super.key,
    required this.title,
    required this.matches,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all( SizeConfig.widthMultiplier * 5),
      child: MatchGroup(
        title: title,
        matches: matches,
      ),
    );
  }
}
