// match_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/constants/assets.dart';
import 'package:sport_app_user/core/utils/size_config.dart';
import 'package:sport_app_user/features/mobile/match_detai/presentation/widgets/match_event_item.dart';
import 'package:sport_app_user/features/mobile/match_detai/presentation/widgets/match_header.dart';
import 'package:sport_app_user/features/mobile/match_detai/presentation/widgets/match_time_line_section.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/entities/match_event_entity.dart';
import 'package:sport_app_user/features/web/match_event_management/presentation/blocs/match_event_bloc.dart';
import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';


class MatchDetailScreen extends StatelessWidget {
  final TeamEntity teamA;
  final TeamEntity teamB;
  final String stadium;
  final String group;
  final String score;
  final String matchId;

  const MatchDetailScreen({
    super.key,
    required this.teamA,
    required this.teamB,
    required this.stadium,
    required this.group,
    required this.score,
    required this.matchId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MatchHeader(
              teamA: teamA,
              teamB: teamB,
              stadium: stadium,
              score: score,
              group: group,
            ),
            Expanded(
              child: BlocProvider(
                create: (context) => MatchEventBloc()..add(LoadMatchEvents(matchId)),
                child: BlocBuilder<MatchEventBloc, MatchEventState>(
                  builder: (context, state) {
                    if (state is MatchEventLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MatchEventLoaded) {
                      final firstHalfEvents = state.matchEvents.where((event) => event.minute <= 45).toList();
                      final secondHalfEvents = state.matchEvents.where((event) => event.minute > 45).toList();

                      List<MatchEventItem> buildMatchEventItems(List<MatchEventEntity> events) {
                        return events.map((event) {
                          String iconAsset;
                          switch (event.eventType) {
                            case MatchEventType.goal:
                              iconAsset = Assets.goalIcon;
                              break;
                            case MatchEventType.yellowCard:
                              iconAsset = Assets.yellowCardIcon;
                              break;
                            case MatchEventType.redCard:
                              iconAsset = Assets.redCardIcon;
                              break;
                            default:
                              iconAsset = Assets.goalIcon;
                          }

                          bool isLeftSide = event.teamId == teamA.teamId;
                          return MatchEventItem(
                            playerName: event.playerName??'',
                            minute: "${event.minute}'",
                            iconAsset: iconAsset,
                            isLeftSide: isLeftSide,
                          );
                        }).toList();
                      }

                      return ListView(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 4,
                          vertical: SizeConfig.heightMultiplier * 1.2,
                        ),
                        children: [
                          MatchTimelineSection(
                            title: 'First Half',
                            events: buildMatchEventItems(firstHalfEvents),
                          ),
                          MatchTimelineSection(
                            title: 'Second Half',
                            events: buildMatchEventItems(secondHalfEvents),
                          ),
                        ],
                      );
                    } else if (state is MatchEventError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}