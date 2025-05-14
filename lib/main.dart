
import 'package:flutter/material.dart';
import 'package:sport_app_user/core/routing/route_paths.dart';
import 'package:sport_app_user/core/routing/router.dart';
import 'package:sport_app_user/core/utils/theme.dart';

import 'features/account/presentation/screens/cookies_screen.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      initialRoute: RoutePaths.cookiesScreen,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: AppTheme.lightTheme,
      home: const CookiesScreen(),
    );
  }
}

