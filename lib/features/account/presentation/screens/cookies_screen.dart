import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/routing/route_paths.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/features/account/presentation/widgets/background_image.dart';
import 'package:sport_app_user/features/account/presentation/widgets/elevated_button.dart';

class CookiesScreen extends StatelessWidget {
  const CookiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(imagePath: Assets.accountBackgroundImage),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 8),
              child: Container(
                padding: EdgeInsets.all(SizeConfig.widthMultiplier * 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '“Every champion was once a contender who refused to give up.”',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.textMultiplier * 3,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        shadows: const [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 4),
                    AccountButton(
                      onPressed: () {
                        precacheImage(const AssetImage(Assets.onBoarding1), context);
                        Navigator.pushReplacementNamed(context, RoutePaths.onBoarding);
                      },
                      title: 'Accept',
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    AccountButton(
                      onPressed: () {},
                      title: 'Reject Non-Essential',
                      foregroundColor: Colors.redAccent.withValues(alpha: 0.8),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    AccountButton(
                      onPressed: () {},
                      title: 'Set Preferences',
                      foregroundColor: Colors.grey.withValues(alpha: 0.7),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
