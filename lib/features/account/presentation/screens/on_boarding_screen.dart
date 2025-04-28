import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/routing/route_paths.dart';
import 'package:sport_app_user/core/utils/size_config.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage(Assets.onBoarding1), context);
      precacheImage(const AssetImage(Assets.onBoarding2), context);
      precacheImage(const AssetImage(Assets.onBoarding3), context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          titleWidget: buildText("Train Your Squad", false),
          bodyWidget: buildText("Manage your dream team like a pro.", true),
          backgroundImage: Assets.onBoarding1,
        ),
        PageViewModel(
          titleWidget: buildText("Join Live Matches", false),
          bodyWidget: buildText("Compete and rise in the global ranks.", true),
          backgroundImage: Assets.onBoarding2,
        ),
        PageViewModel(
          titleWidget: buildText("Track Player Stats", false),
          bodyWidget: buildText(
            "Analyze performance with detailed stats.",
            true,
          ),
          backgroundImage: Assets.onBoarding3,
        ),
      ],
      onDone: () => Navigator.pushReplacementNamed(context, RoutePaths.register),
      showSkipButton: true,
      skip: Text(
        "Skip",
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.textMultiplier * 2,
        ),
      ),
      next: Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: SizeConfig.imageSizeMultiplier * 7,
      ),
      done: Text(
        "Get Started",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: SizeConfig.textMultiplier * 2,
        ),
      ),
      dotsDecorator: DotsDecorator(
        size: Size(
          SizeConfig.widthMultiplier * 2,
          SizeConfig.heightMultiplier * 2,
        ),
        color: Colors.grey,
        activeSize: Size(
          SizeConfig.widthMultiplier * 8,
          SizeConfig.heightMultiplier,
        ),
        activeColor: Colors.deepPurple,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.imageSizeMultiplier * 10),
          ),
        ),
      ),
    );
  }

  Text buildText(String text, bool isBody) {
    return Text(
      text,
      style: TextStyle(
        fontSize:
            isBody
                ? SizeConfig.textMultiplier * 2
                : SizeConfig.textMultiplier * 4,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
