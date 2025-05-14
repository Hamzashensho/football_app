import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/core/widget/buttons/custom_tab_button.dart';
import 'package:sport_app_user/features/profile/presentation/screens/profile_tab_view.dart';
import 'package:sport_app_user/features/profile/presentation/screens/setting_tab_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTabButton(
              title: 'Profile',
              isSelected: selectedTab == 0,
              onTap:
                  () => setState(() {
                    selectedTab = 0;
                  }),
            ),
            SizedBox(width: SizeConfig.widthMultiplier * 5),
            CustomTabButton(
              title: 'Settings',
              isSelected: selectedTab == 1,
              onTap:
                  () => setState(() {
                    selectedTab = 1;
                  }),
            ),
          ],
        ),
        selectedTab == 0 ? const ProfileTabView() : const SettingTabView(),
      ],
    );
  }
}
