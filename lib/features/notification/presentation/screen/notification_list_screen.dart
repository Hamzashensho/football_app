import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/core/widget/buttons/custom_tab_button.dart';
import 'package:sport_app_user/features/notification/presentation/widgets/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int selectedTab = 0;
  List<NotificationModel> notifications = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTabButton(
              title: 'Today',
              isSelected: selectedTab == 0,
              onTap:
                  () => setState(() {
                    selectedTab = 0;
                  }),
            ),
            SizedBox(width: SizeConfig.widthMultiplier * 5),
            CustomTabButton(
              title: 'All',
              isSelected: selectedTab == 1,
              onTap:
                  () => setState(() {
                    selectedTab = 1;
                  }),
            ),
          ],
        ),

        SizedBox(height: SizeConfig.heightMultiplier * 2),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.widthMultiplier * 4),
            child: ListView.builder(
              itemCount:
                  selectedTab == 0
                      ? dummyNotifications.length
                      : dummyNotifications
                          .where((notification) => notification.isFavorite)
                          .length,
              itemBuilder: (context, index) {
                notifications =
                    selectedTab == 0
                        ? dummyNotifications
                        : dummyNotifications
                            .where((notification) => notification.isFavorite)
                            .toList();
                final notification = notifications[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.heightMultiplier * 1,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(notification.image),
                      SizedBox(width: SizeConfig.widthMultiplier * 3),
                      Expanded(
                        child: NotificationCard(notification: notification),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
