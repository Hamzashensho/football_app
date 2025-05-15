import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/core/widget/buttons/custom_tab_button.dart';
import 'package:sport_app_user/features/mobile/statistics/presentation/bloc/statistics_cubit.dart';
import 'package:sport_app_user/features/mobile/statistics/presentation/widgets/expandable_group_container.dart';
import 'package:sport_app_user/features/mobile/statistics/presentation/widgets/player_ranking_card.dart';
import 'package:sport_app_user/features/mobile/statistics/presentation/widgets/team_logos_row.dart';
import 'package:sport_app_user/features/mobile/statistics/presentation/widgets/team_ranking_card.dart';
import '../../../../../core/utils/size_config.dart';


class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => StatisticsCubit(),
      child: BlocBuilder<StatisticsCubit, StatisticsState>(
        builder: (context, state) {
          final cubit = context.read<StatisticsCubit>();
          return Column(
            children: [
              // Tabs
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTabButton(
                    title: 'Team Statistics',
                    isSelected: state.selectedTab == 0,
                    onTap: () => cubit.changeTab(0),
                  ),
                  SizedBox(width: SizeConfig.widthMultiplier * 5),
                  CustomTabButton(
                    title: 'Player Statistics',
                    isSelected: state.selectedTab == 1,
                    onTap: () => cubit.changeTab(1),
                  ),
                ],
              ),

              SizedBox(height: SizeConfig.heightMultiplier * 2),

              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
                  child: state.selectedTab == 0
                      ? _TeamStatisticsScreen()
                      : _PlayerStatisticsScreen(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}



// ----------------------------------------
// Team Statistics Screen
class _TeamStatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StatisticsCubit>();
    final state = context.watch<StatisticsCubit>().state;

    final List<TeamModel> teams = dummyTeams;

    return Column(
      children: [
        TeamLogosRow(teams: teams),
        SizedBox(height: SizeConfig.heightMultiplier * 2),
        Expanded(
          child: ListView(
            children: [
              ExpandableGroupContainer(
                groupName: 'Group A',
                isExpanded: state.expandedGroups['Group A'] ?? false,
                onTap: () => cubit.toggleGroup('Group A'),
                title: 'Junior Championship 8-10 Years',
                children: _buildTeamList(context, teams.sublist(0, 3)),
              ),
              ExpandableGroupContainer(
                groupName: 'Group B',
                isExpanded: state.expandedGroups['Group B'] ?? false,
                onTap: () => cubit.toggleGroup('Group B'),
                title: 'Junior Championship 12-14 Years',
                children: _buildTeamList(context, teams.sublist(3)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTeamList(BuildContext context, List<TeamModel> teams) {
    final selectedTeam = context.watch<StatisticsCubit>().state.selectedTeam;
    final filteredTeams = selectedTeam == null
        ? teams
        : teams.where((team) => team.name == selectedTeam.name).toList();

    return filteredTeams
        .map((team) => TeamRankingCard(team: team, goals: (team.name.hashCode % 10) + 1))
        .toList();
  }
}

// ----------------------------------------
// Player Statistics Screen
class _PlayerStatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StatisticsCubit>();
    final state = context.watch<StatisticsCubit>().state;
    final List<PlayerModel> players = dummyPlayers;


    return Column(
      children: [
        TeamLogosRow(teams: dummyTeams),
        SizedBox(height: SizeConfig.heightMultiplier * 2),
        Expanded(
          child: ListView(
            children: [
              ExpandableGroupContainer(
                groupName: 'Group A',
                isExpanded: state.expandedGroups['Group A'] ?? false,
                onTap: () => cubit.toggleGroup('Group A'),
                title: 'Junior Championship 8-10 Years',
                children: _buildPlayerList(context, players.sublist(0, 3)),
              ),
              ExpandableGroupContainer(
                groupName: 'Group B',
                isExpanded: state.expandedGroups['Group B'] ?? false,
                onTap: () => cubit.toggleGroup('Group B'),
                title: 'Junior Championship 12-14 Years',
                children: _buildPlayerList(context, players.sublist(3)),
              ),
            ],
          ),
        ),
      ],
    );
  }
  List<Widget> _buildPlayerList(BuildContext context, List<PlayerModel> players) {
    final selectedTeam = context.watch<StatisticsCubit>().state.selectedTeam;
    final filteredTeams = selectedTeam == null
        ? players
        : players.where((player) => player.team.name == selectedTeam.name).toList();

    return filteredTeams
        .map((player) => PlayerRankingCard(player:player ,))
        .toList();
  }
}
