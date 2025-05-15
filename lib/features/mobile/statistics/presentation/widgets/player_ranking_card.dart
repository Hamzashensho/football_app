import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/features/mobile/statistics/presentation/widgets/team_logo_tile.dart';
import '../../../../../core/utils/size_config.dart';

class PlayerRankingCard extends StatelessWidget {
  final PlayerModel player;

  const PlayerRankingCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.heightMultiplier,
        horizontal: SizeConfig.widthMultiplier * 2.2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 3),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          vertical: SizeConfig.heightMultiplier * 0.2,
          horizontal: SizeConfig.widthMultiplier * 3,
        ),
        leading: Container(
          width: SizeConfig.widthMultiplier * 8,
          height: SizeConfig.widthMultiplier * 8,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 2),
          ),
          child: Center(
            child: Text(
              '${player.order}°',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TeamLogoTile(
                  imagePath: player.team.logo,
                  onTap: () {},
                  isSelected: false,
                ),
                SizedBox(width: SizeConfig.widthMultiplier * 2), // Added spacing
                Text(
                  player.name,
                  style: TextStyle(fontSize: SizeConfig.textMultiplier * 2),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 16),
              child: Text(
                player.team.name,
                style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.5),
              ),
            ),
          ],
        ),
        trailing: Text(
          '${player.goals}',
          style: TextStyle(
            fontSize: SizeConfig.textMultiplier * 2.2,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }
}