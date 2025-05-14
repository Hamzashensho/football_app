import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/core/utils/size_config.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 2 * SizeConfig.textMultiplier,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3 * SizeConfig.widthMultiplier),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 5 * SizeConfig.imageSizeMultiplier,
                  child: Image.asset(Assets.profilePictureIcon),
                ),
                SizedBox(width: 3 * SizeConfig.widthMultiplier),
                Expanded(
                  child: Text(
                    'Hamza Zohair',
                    style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier),
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: const Text('Edit')),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Icon(Icons.person_outline),
                SizedBox(width: 2 * SizeConfig.widthMultiplier),
                const Expanded(child: Text('Sha')),
                ElevatedButton(onPressed: () {}, child: const Text('Logout')),
              ],
            ),
            const Divider(),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier*1.8),
              child: Row(
                children: [
                  const Icon(Icons.email_outlined),
                  SizedBox(width: 2 * SizeConfig.widthMultiplier),
                  const Expanded(child: Text('hamza.sh@gmail.com')),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteTeamsList extends StatelessWidget {
  const FavoriteTeamsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3 * SizeConfig.widthMultiplier),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier),
        child: Column(
          children: [
            for (int i = 1; i <= 3; i++) ...[
              Row(
                children: [
                  Image.asset(
                    dummyTeams[i].logo,
                    width: 8 * SizeConfig.imageSizeMultiplier,
                  ),
                  SizedBox(width: 3 * SizeConfig.widthMultiplier),
                  Expanded(child: Text(dummyTeams[i].name)),

                  InkWell(onTap:(){},child: const Icon(Icons.star, color: Colors.red)),
                ],
              ),
              if (i != 3) const Divider(),
            ],
            SizedBox(height: 2 * SizeConfig.heightMultiplier),
            ElevatedButton(onPressed: () {}, child: const Text('Add')),
          ],
        ),
      ),
    );
  }
}
