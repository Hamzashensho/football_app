import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/features/home/presentation/screens/main_screen.dart';
import 'package:sport_app_user/features/home/presentation/widgets/bottom_nav.dart';
import 'package:sport_app_user/features/home/presentation/widgets/home_page_header.dart';
import 'package:sport_app_user/features/news/presentation/screens/news_list_screen.dart';
import 'package:sport_app_user/features/notification/presentation/screen/notification_list_screen.dart';
import 'package:sport_app_user/features/profile/presentation/screens/profile_screen.dart';
import 'package:sport_app_user/features/statistics/presentation/screens/statistics_screen.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    MainScreen(),
    StatisticsScreen(),
    NewsListScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const HomePageHeader(),
            SizedBox(height: SizeConfig.heightMultiplier * 2),
            Expanded(child: _screens[_selectedIndex]),
          ],
        ),
      ),
    );
  }
}


