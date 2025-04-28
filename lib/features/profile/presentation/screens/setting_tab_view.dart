import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import '../widgets/settings_widget.dart';

class SettingTabView extends StatelessWidget {
  const SettingTabView({super.key});


  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier),
        child: ListView(
          children: [
            // Tabs

            SizedBox(height: 2 * SizeConfig.heightMultiplier),

            // Notification Settings
            SectionTitle(title: "Notification Settings"),
            NotificationToggle(title: " Receive notifications for your favorite team"),
            NotificationToggle(title: " Receive app notifications"),

            SizedBox(height: 3 * SizeConfig.heightMultiplier),

            // Account Settings
            SectionTitle(title: "Account Settings"),
            AccountOption(
              title: "Change Password",
              icon: Icons.lock_outline,
              onTap: () {},
            ),
            AccountOption(
              title: "Delete my account",
              icon: Icons.delete_outline,
              onTap: () {},
              isDanger: true,
            ),
          ],
        ),
      ),
    );
  }
}
