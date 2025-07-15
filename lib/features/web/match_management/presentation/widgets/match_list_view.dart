import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';
import 'package:sport_app_user/features/web/match_management/presentation/blocs/match_bloc.dart';
import 'package:sport_app_user/features/web/match_management/presentation/widgets/match_tile.dart';
import 'package:sport_app_user/features/web/team_management/presentation/blocs/team_bloc.dart';
import 'package:sport_app_user/features/web/champion_management/presentation/blocs/champion_bloc.dart';

class MatchListView extends StatelessWidget {
  final List<MatchEntity> matches;
  const MatchListView({super.key, required this.matches});

  @override
  Widget build(BuildContext context) {
    if (matches.isEmpty) {
      return const Center(child: Text('No matches found.'));
    }

    final teamList = context.read<TeamBloc>().teamsList;
    final championList = context.read<ChampionBloc>().championsList;

    return RefreshIndicator(
      onRefresh: () async => context.read<MatchBloc>().add(LoadMatches()),
      child: ListView.separated(
        itemCount: matches.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) => MatchTile(
          match: matches[index],
          teamList: teamList,
          championList: championList,
        ),
      ),
    );
  }
}