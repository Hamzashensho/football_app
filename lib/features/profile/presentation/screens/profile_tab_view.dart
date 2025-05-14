import 'package:flutter/material.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/features/profile/presentation/widgets/profile_widget.dart';


class ProfileTabView extends StatelessWidget {
  const ProfileTabView({super.key});

  @override
  Widget build(BuildContext context) {

    return Flexible(
      child: Padding(
        padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2 * SizeConfig.heightMultiplier),

              // General Information
              const SectionTitle(title: 'General Information'),
              const UserInfoCard(),

              SizedBox(height: 3 * SizeConfig.heightMultiplier),

              // Favorite Team Section
              const SectionTitle(title: 'Favorite Team'),
              const FavoriteTeamsList(),
            ],
          ),
        ),
      ),
    );
  }
}
