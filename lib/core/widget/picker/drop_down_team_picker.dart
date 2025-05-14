import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/core/utils/size_config.dart';



class SimpleTeamDropdown extends StatefulWidget {
  const SimpleTeamDropdown({super.key});

  @override
  State<SimpleTeamDropdown> createState() => _SimpleTeamDropdownState();
}

class _SimpleTeamDropdownState extends State<SimpleTeamDropdown> {


  TeamModel? selectedTeam;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(SizeConfig.imageSizeMultiplier*0.5),
      child: DropdownButtonFormField<TeamModel>(
        icon: Image.asset(
          Assets.bottomArrowIcon,
          height: SizeConfig.imageSizeMultiplier * 2.5,
        ),
        value: selectedTeam,
        dropdownColor: Colors.black38,
        hint: const Text(
          'Choose your team',
          style: TextStyle(color: Colors.white),
        ),
        items:
        dummyTeams.map((team) {
              return DropdownMenuItem<TeamModel>(
                value: team,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(team.logo, width: SizeConfig.widthMultiplier*7, height: SizeConfig.heightMultiplier*5),
                         SizedBox(width: SizeConfig.widthMultiplier*3),
                        Text(team.name, style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                    if (team != dummyTeams.last)
                      const Divider( color: Colors.grey),
                  ],
                ),
              );
            }).toList(),

        selectedItemBuilder: (context) {
          return dummyTeams.map((team) {
            return Row(
              children: [
                Image.asset(team.logo, width: SizeConfig.widthMultiplier*5, height: SizeConfig.heightMultiplier*4),
                 SizedBox(width: SizeConfig.widthMultiplier*3),
                Text(team.name, style: const TextStyle(color: Colors.white)),
              ],
            );
          }).toList();
        },

        onChanged: (value) {
          setState(() {
            selectedTeam = value;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(SizeConfig.imageSizeMultiplier*0.5)),
          contentPadding:  EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier*5,
            vertical: SizeConfig.heightMultiplier*1.6,
          ),
          fillColor: Colors.black38,
          filled: true,
        ),
      ),
    );
  }
}
