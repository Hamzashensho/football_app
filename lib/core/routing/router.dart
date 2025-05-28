import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/core/routing/route_paths.dart';
import 'package:sport_app_user/core/widget/match/match_card.dart';
import 'package:sport_app_user/features/mobile/account/presentation/screens/cookies_screen.dart';
import 'package:sport_app_user/features/mobile/account/presentation/screens/on_boarding_screen.dart';
import 'package:sport_app_user/features/mobile/account/presentation/screens/register_screen.dart';
import 'package:sport_app_user/features/mobile/account/presentation/screens/splash_screen.dart';
import 'package:sport_app_user/features/mobile/home/presentation/screens/home_screen.dart';
import 'package:sport_app_user/features/mobile/match_detai/presentation/screens/match_screen_detail.dart';
import 'package:sport_app_user/features/mobile/match_group_detail/presentation/screens/match_list_screen.dart';
import 'package:sport_app_user/features/mobile/news/presentation/screens/news_detail_screen.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.cookiesScreen:
        return _buildRoute(const CookiesScreen(),settings);
      case RoutePaths.onBoarding:
        return _buildRoute(const OnBoardingScreen(),settings);
      case RoutePaths.register:
        return _buildRoute(const RegisterScreen(),settings);
      case RoutePaths.homeScreen:
        return _buildRoute(const MainPage(),settings);
      case RoutePaths.matchListScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(
          MatchesListScreen(
            title: args['title'],
            matches: args['matches'] as List<MatchCard>,
          ),
          settings
        );
      case RoutePaths.matchDetailScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(
          MatchDetailScreen(
            group: args['group'],
            teamA: args['teamA'] as TeamModel,
            teamB: args['teamB'] as TeamModel,
            score: args['score'],
            stadium: args['stadium'],
          ),
          settings
        );
      case RoutePaths.newsDetailScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute(
          NewsDetailsScreen(
            title: args['title'],
            image: args['image'],
            description: args['description'],
            dateTime: args['dateTime'] as DateTime,
          ),
          settings
        );
      case RoutePaths.splashScreen:
        return _buildRoute(const SplashScreen(),settings);


      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute _buildRoute(Widget child, [RouteSettings? settings]) {
    return MaterialPageRoute(builder: (_) => child,settings:settings );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Page not found')),
          ),
    );
  }
}
