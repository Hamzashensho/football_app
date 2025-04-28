import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/size_config.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: SizeConfig.widthMultiplier*1.5,left: SizeConfig.widthMultiplier*1.5),
        height: 1,
        color: Colors.white,
      ),
    );
  }
}