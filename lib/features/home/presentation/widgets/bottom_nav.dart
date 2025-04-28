import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/size_config.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.widthMultiplier * 5,
        right: SizeConfig.widthMultiplier * 5,
        bottom: SizeConfig.heightMultiplier * 2.2,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeConfig.heightMultiplier * 2.5),
        child: Container(
          height: SizeConfig.heightMultiplier * 9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(SizeConfig.heightMultiplier * 2),
            border: Border.all(color: Colors.white10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              )
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            showUnselectedLabels: true,
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.grey[500],
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.sports_soccer), label: 'Matches'),
              BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'Standings'),
              BottomNavigationBarItem(icon: Icon(Icons.article), label: 'News'),
              BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
