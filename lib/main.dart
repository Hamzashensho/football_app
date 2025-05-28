import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sport_app_user/core/routing/route_observer.dart';
import 'package:sport_app_user/core/routing/route_paths.dart';
import 'package:sport_app_user/core/routing/router.dart';
import 'package:sport_app_user/core/utils/theme.dart';
import 'package:sport_app_user/features/mobile/account/presentation/screens/splash_screen.dart';
import 'package:sport_app_user/injection_container.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main()async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MyRouteObserver myRouteObserver = MyRouteObserver();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [myRouteObserver],
      initialRoute: RoutePaths.splashScreen,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

