import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/size_config.dart';

class AccountButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Color? foregroundColor;
  final String? iconImagePath;
  final double? imageRightPadding;
  final double? labelLeftPadding;

  const AccountButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.foregroundColor,
    this.iconImagePath,
    this.imageRightPadding,
    this.labelLeftPadding,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.widthMultiplier * 90,
      child:
      iconImagePath!=null
              ? ElevatedButton.icon(
                onPressed: onPressed,
                icon: Padding(
                  padding:  EdgeInsets.only(left: imageRightPadding??SizeConfig.widthMultiplier*8),
                  child: Image.asset(iconImagePath??'',height: SizeConfig.heightMultiplier*3.5),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: foregroundColor
                ),
                label: Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.heightMultiplier * 0.8,
                    bottom: SizeConfig.heightMultiplier * 0.8,
                    left: labelLeftPadding??0,

                  ),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      title,
                      style: TextStyle(fontSize: SizeConfig.textMultiplier * 2.5,color: Colors.black),
                    ),
                  ),
                ),
              )
              : ElevatedButton(
                style:
                    foregroundColor != null
                        ? ElevatedButton.styleFrom(
                          foregroundColor: foregroundColor,
                        )
                        : null,
                onPressed: onPressed,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.heightMultiplier * 0.8,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: SizeConfig.textMultiplier * 2.5),
                  ),
                ),
              ),
    );
  }
}
