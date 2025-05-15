import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/core/utils/utils.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 3),
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.widthMultiplier * 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Utils.formatDateToTodayOrYesterday(notification.dateTime),
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 1.6,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  notification.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: notification.isFavorite
                      ?const Color(0xFF9C0101):Colors.black,
                ),
              ],
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 0.8),
            Text(
              notification.title,
              //maxLines: 2,
              //overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 1.8,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 0.5),
            Text(
              notification.subtitle,
              //maxLines: 2,
              //overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
