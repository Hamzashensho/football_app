import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/routing/route_paths.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/features/mobile/account/domain/repositories/auth_repository.dart';
import 'package:sport_app_user/features/mobile/account/domain/usecases/get_current_user.dart';
import 'package:sport_app_user/injection_container.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    _checkConsentAndNavigate();
  }

  Future<void> _checkConsentAndNavigate() async {
    final consent = await GetCurrentUser(sl<AuthRepository>()).call(true);

    if (!mounted) return;

    consent.fold(
      (failure) =>
          Navigator.pushReplacementNamed(context, RoutePaths.cookiesScreen),
      (user) {
        (user != null)
            ? Navigator.pushReplacementNamed(context, RoutePaths.homeScreen)
            : Navigator.pushReplacementNamed(context, RoutePaths.cookiesScreen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Center(
        child: Image.asset(
          Assets.logoWithoutBackground,
          width: SizeConfig.imageSizeMultiplier * 70,
        ),
      ),
    );
  }
}
