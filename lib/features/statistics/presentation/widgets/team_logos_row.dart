import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/features/statistics/presentation/bloc/statistics_cubit.dart';
import 'package:sport_app_user/features/statistics/presentation/widgets/team_logo_tile.dart';
import '../../../../core/utils/size_config.dart';


class TeamLogosRow extends StatelessWidget {
  final List<TeamModel> teams;

  const TeamLogosRow({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StatisticsCubit>();
    final selectedTeam = context.watch<StatisticsCubit>().state.selectedTeam;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // ---- ALL TILE ----
          TeamLogoTile(
            isFromTeamLogosRow: true,
            imagePath: Assets.mailBoxIcon, // Add an "All" icon in assets
            isSelected: selectedTeam == null,
            onTap: () => cubit.selectTeam(null), // Set selectedTeam to NULL
          ),
          SizedBox(width: SizeConfig.widthMultiplier * 2),
          // ---- TEAMS ----
          ...teams.map((team) {
            return Padding(
              padding: EdgeInsets.only(right: SizeConfig.widthMultiplier * 2),
              child: TeamLogoTile(
                isFromTeamLogosRow: true,
                imagePath: team.logo,
                isSelected: selectedTeam?.name == team.name,
                onTap: () => cubit.selectTeam(team),
              ),
            );
          }),
        ],
      ),
    );
  }
}

