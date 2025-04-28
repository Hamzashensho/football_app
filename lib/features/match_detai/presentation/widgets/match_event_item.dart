// widgets/match_event_item.dart
import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/size_config.dart'; // adjust path if needed

class MatchEventItem extends StatelessWidget {
  final String playerName;
  final String minute;
  final String iconAsset;
  final bool isLeftSide;

  const MatchEventItem({
    super.key,
    required this.playerName,
    required this.minute,
    required this.iconAsset,
    required this.isLeftSide,
  });

  @override
  Widget build(BuildContext context) {

    final rowChildren = <Widget>[
      if (isLeftSide)
        Row(
          children: [
            Image.asset(
              iconAsset,
              height: 5 * SizeConfig.imageSizeMultiplier, // responsive icon
            ),
            SizedBox(width: 1 * SizeConfig.widthMultiplier),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 3 * SizeConfig.widthMultiplier,
                vertical: 1.2 * SizeConfig.heightMultiplier,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(2 * SizeConfig.heightMultiplier),
              ),
              child: Text(
                playerName,
                style: TextStyle(fontSize: 1.6 * SizeConfig.textMultiplier),
              ),
            ),
          ],
        ),
      Spacer(),
      Text(
        minute,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 1.7 * SizeConfig.textMultiplier,
        ),
      ),
      if (!isLeftSide) const Spacer(),
      if (!isLeftSide)
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 3 * SizeConfig.widthMultiplier,
                vertical: 1.2 * SizeConfig.heightMultiplier,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(2 * SizeConfig.heightMultiplier),
              ),
              child: Text(
                playerName,
                style: TextStyle(fontSize: 1.6 * SizeConfig.textMultiplier),
              ),
            ),
            SizedBox(width: 1 * SizeConfig.widthMultiplier),
            Image.asset(
              iconAsset,
              height: 5 * SizeConfig.imageSizeMultiplier,
            ),
          ],
        ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 1 * SizeConfig.heightMultiplier,
      ),
      child: Row(children: rowChildren),
    );
  }
}
