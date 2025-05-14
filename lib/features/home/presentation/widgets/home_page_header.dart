import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/utils/size_config.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*3),
      child: Row(
        children: [
          Image.asset(
            Assets.logoWithoutBackground,
            height: SizeConfig.heightMultiplier * 12,
          ),
          SizedBox(width: SizeConfig.widthMultiplier * 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WELCOME TO',
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 1.7,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                ),
                Text(
                  'FUTZONE CUP, Europe',
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 1.7,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage(Assets.profilePictureIcon),
          ),
        ],
      ),
    );
  }
}
