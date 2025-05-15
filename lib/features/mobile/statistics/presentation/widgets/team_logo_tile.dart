import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/size_config.dart';

class TeamLogoTile extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isFromTeamLogosRow;

  const TeamLogoTile({super.key, required this.imagePath, required this.isSelected, required this.onTap,this.isFromTeamLogosRow=false});

  @override
  Widget build(BuildContext context) {
    return isFromTeamLogosRow?InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(SizeConfig.widthMultiplier * 2),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.teal, width: 1.5),
        ),
        child: Image.asset(
          imagePath,
          height: SizeConfig.heightMultiplier * 5,
          width: SizeConfig.widthMultiplier * 10,
        ),
      ),
    ):Container(
      padding: EdgeInsets.all(SizeConfig.widthMultiplier * 1.5),
      decoration: BoxDecoration(
        color:   Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.teal, width: 1.5),
      ),
      child: Image.asset(
        imagePath,
        height: SizeConfig.heightMultiplier * 4,
        width: SizeConfig.widthMultiplier * 10,
      ),
    );
  }
}
