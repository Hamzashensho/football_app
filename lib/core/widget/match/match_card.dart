import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/core/routing/route_paths.dart';
import 'package:sport_app_user/core/utils/size_config.dart';

class MatchCard extends StatelessWidget {
  final String date, time, stadium, group, status;
  final TeamModel teamA, teamB;
  final String score;

  const MatchCard({
    super.key,
    required this.date,
    required this.time,
    required this.stadium,
    required this.group,
    required this.status,
    required this.teamA,
    required this.teamB,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, RoutePaths.matchDetailScreen,arguments: {
          'score':score,
          'stadium':stadium,
          'group':group,
          'teamA':teamA,
          'teamB':teamB,
        });
      },
      child: Container(
        margin:  EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier*1.1),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(SizeConfig.heightMultiplier*2),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Column(
          children: [
            Container(
              padding:  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*2, vertical: SizeConfig.heightMultiplier*1.3),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(SizeConfig.heightMultiplier*2),
                  topRight:  Radius.circular(SizeConfig.heightMultiplier*2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),

                  Text(
                    stadium,
                    style:  TextStyle(fontSize: SizeConfig.textMultiplier*1.4, color: Colors.white),
                  ),
                  SizedBox(width: SizeConfig.widthMultiplier*2),
                  //const Spacer(),
                  Text(time,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*2, vertical: SizeConfig.heightMultiplier*1.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    group,
                    style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:  SizeConfig.textMultiplier*1.4,
                      color: Color(0xFF5B2E91),
                    ),
                  ),
                  if (status.isNotEmpty)
                    Padding(
                      padding:  EdgeInsets.only(top: SizeConfig.heightMultiplier*0.3),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontSize: SizeConfig.textMultiplier*1.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                   SizedBox(height: SizeConfig.heightMultiplier*2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTeam(teamA),
                      const Spacer(),
                      Container(
                        padding:  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*4, vertical: SizeConfig.heightMultiplier*1.3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.circular(SizeConfig.heightMultiplier*2),
                        ),
                        child: Text(
                          score,
                          style:  TextStyle(
                            fontSize: SizeConfig.textMultiplier*2.1,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const Spacer(),
                      _buildTeam(teamB),
                    ],
                  ),
                   SizedBox(height: SizeConfig.heightMultiplier*1.6),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTeam(TeamModel team) {
    return Column(
      children: [
        Image.asset(team.logo, height: SizeConfig.heightMultiplier*4, width: SizeConfig.widthMultiplier*9),
         SizedBox(height: SizeConfig.heightMultiplier*1.2),
        SizedBox(
          width: SizeConfig.widthMultiplier*15,
          child: Text(
            team.name,
            style:  TextStyle(fontSize: SizeConfig.textMultiplier*1.2),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
