import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/features/profile/presentation/widgets/profile_widget.dart';


class ProfileTabView extends StatelessWidget {
  const ProfileTabView({super.key});

  @override
  Widget build(BuildContext context) {

    return Flexible(
      fit: FlexFit.loose,

      child: Padding(
        padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2 * SizeConfig.heightMultiplier),

              // General Information
              SectionTitle(title: "General Information"),
              UserInfoCard(),

              SizedBox(height: 3 * SizeConfig.heightMultiplier),

              // Favorite Team Section
              SectionTitle(title: "Favorite Team"),
              FavoriteTeamsList(),
            ],
          ),
        ),
      ),
    );
  }
}
