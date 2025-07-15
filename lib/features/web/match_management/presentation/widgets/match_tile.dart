import 'package:flutter/material.dart';
import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';
import 'package:sport_app_user/features/web/champion_management/domain/entities/champion_entity.dart';
import 'package:sport_app_user/features/web/match_management/presentation/widgets/match_detail_row.dart';
import 'package:sport_app_user/features/web/match_management/presentation/widgets/match_dialog.dart';
import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/features/web/match_management/presentation/blocs/match_bloc.dart';

class MatchTile extends StatelessWidget {
  final MatchEntity match;
  final List<TeamEntity> teamList;
  final List<ChampionEntity> championList;

  const MatchTile({super.key, required this.match, required this.teamList, required this.championList});

  @override
  Widget build(BuildContext context) {
    final teamA = teamList.firstWhere((e) => e.teamId == match.teamAId).name;
    final teamB = teamList.firstWhere((e) => e.teamId == match.teamBId).name;
    final championTitle = championList.firstWhere((e) => e.championId == match.championId).title;
    final bloc = context.read<MatchBloc>();

    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(
        '$teamA (${match.teamAScore}) vs $teamB (${match.teamBScore})',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '${match.date.toIso8601String().split("T").first} • ${match.stadiumName}',
        style: const TextStyle(fontSize: 13),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => showMatchDialog(
              context: context,
              isEdit: true,
              match: match,
              teamList: teamList,
              championList: championList,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => bloc.add(DeleteMatch(matchId: match.matchId)),
          ),
          const Icon(Icons.expand_more),
        ],
      ),
      children: [
        MatchDetailRow(title: 'Time', value: match.time),
        MatchDetailRow(title: 'Type', value: match.type ?? ''),
        MatchDetailRow(title: 'Status', value: match.status ?? ''),
        MatchDetailRow(title: 'Group', value: match.group ?? ''),
        MatchDetailRow(title: 'Champion', value: championTitle),
      ],
    );
  }
}
