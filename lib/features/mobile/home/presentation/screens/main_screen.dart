import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/core/widget/image/carousel_slider.dart';
import 'package:sport_app_user/core/widget/match/match_card.dart';
import 'package:sport_app_user/core/widget/match/match_group.dart';
import 'package:sport_app_user/features/web/champion_management/presentation/blocs/champion_bloc.dart';
import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';
import 'package:sport_app_user/features/web/match_management/presentation/blocs/match_bloc.dart';
import 'package:sport_app_user/features/web/team_management/presentation/blocs/team_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MatchBloc()..add(LoadMatches())),
        BlocProvider(create: (_) => TeamBloc()..add(LoadTeams())),
        BlocProvider(create: (_) => ChampionBloc()..add(LoadChampions())),
      ],
      child: const MainScreenBody(),
    );
  }
}

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchBloc, MatchState>(
      builder: (context, matchState) {
        return BlocBuilder<TeamBloc, TeamState>(
          builder: (context, teamState) {
            return BlocBuilder<ChampionBloc, ChampionState>(
              builder: (context, championState) {
                if (matchState is MatchLoading ||
                    teamState is TeamLoading ||
                    championState is ChampionLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (matchState is MatchLoaded &&
                    teamState is TeamLoaded &&
                    championState is ChampionLoaded) {
                  final matches = matchState.matches;
                  final teams = teamState.teams;
                  final champions = championState.champions;

                  MatchCard mapToMatchCard( match) {
                    final teamA = teams.firstWhere((t) => t.teamId == match.teamAId);
                    final teamB = teams.firstWhere((t) => t.teamId == match.teamBId);

                    return MatchCard(
                      date: match.date.toString(),
                      group: match.group ?? '',
                      score: '${match.teamAScore} - ${match.teamBScore}',
                      stadium: match.stadiumName,
                      status: match.status ?? '',
                      teamA: teamA,
                      teamB: teamB,
                      time: match.time,
                      matchId: match.matchId,
                    );
                  }

                  // Group matches by championId
                  final groupedByChampion = <String, List<dynamic>>{};
                  for (var match in matches) {
                    final chKey = match.championId;
                    if (!groupedByChampion.containsKey(chKey)) {
                      groupedByChampion[chKey??''] = [];
                    }
                    groupedByChampion[chKey]!.add(match);
                  }

                  return ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 5,
                    ),
                    children: [
                      CarouselWithDots(imageList: dummyImageList),
                      SizedBox(height: SizeConfig.heightMultiplier * 3),

                      // Build a MatchGroup for each champion group
                      ...groupedByChampion.entries.map((entry) {
                        final championId = entry.key;
                        final championMatches = entry.value;
                        final champion = champions.firstWhere(
                              (c) => c.championId == championId,

                        );

                        return Column(
                          children: [
                            MatchGroup(
                              title: champion.title ?? 'Unknown Championship',
                              isFromHomePage: true,
                              matches: championMatches.map(mapToMatchCard).toList(),
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 3),
                          ],
                        );
                      }),

                      SizedBox(height: SizeConfig.heightMultiplier * 5),
                    ],
                  );
                }

                return const Center(child: Text('Failed to load matches, teams, or champions'));
              },
            );
          },
        );
      },
    );
  }
}
