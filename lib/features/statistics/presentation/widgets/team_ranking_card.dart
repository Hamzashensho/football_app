import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/features/statistics/presentation/widgets/team_logo_tile.dart';
import '../../../../core/utils/size_config.dart';

class TeamRankingCard extends StatelessWidget {
  final TeamModel team;
  final int goals;

  const TeamRankingCard({super.key, required this.team, required this.goals});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier,horizontal: SizeConfig.widthMultiplier*2.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 3)),
      child: ListTile(
        contentPadding:EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier*0.9,horizontal:SizeConfig.widthMultiplier*3 ),
        leading:Container(
          width: SizeConfig.widthMultiplier * 8,
          height: SizeConfig.widthMultiplier * 8,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 2),
          ),
          child: Center(child: Text("${team.order}°",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
        ) ,
        title: Row(
          children: [
            TeamLogoTile(imagePath: team.logo,onTap: (){},isSelected: false,),
            Text(team.name, style: TextStyle(fontSize: SizeConfig.textMultiplier * 2)),
          ],
        ),
        trailing: Text('$goals', style: TextStyle(fontSize: SizeConfig.textMultiplier * 2.2, color: Colors.teal)),
      ),
    );
  }
}
