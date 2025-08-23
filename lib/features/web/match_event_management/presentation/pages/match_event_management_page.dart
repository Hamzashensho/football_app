import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/widget/dialogs/entity_dialog.dart';
import 'package:sport_app_user/core/widget/form/entity_form.dart';
import 'package:sport_app_user/core/widget/loader.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/usecases/get_match_events_usecase.dart';
import 'package:sport_app_user/features/web/match_event_management/presentation/blocs/match_event_bloc.dart';
import 'package:sport_app_user/features/web/match_event_management/domain/entities/match_event_entity.dart';
import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';
import 'package:sport_app_user/features/web/match_management/presentation/blocs/match_bloc.dart';
import 'package:sport_app_user/features/web/team_management/presentation/blocs/team_bloc.dart';

class MatchEventManagementPage extends StatefulWidget {
  final String matchId;

  const MatchEventManagementPage({super.key, required this.matchId});

  @override
  State<MatchEventManagementPage> createState() =>
      _MatchEventManagementPageState();
}

class _MatchEventManagementPageState extends State<MatchEventManagementPage> {
  List<MatchEntity> matches=[];
  @override
  void initState() {
    matches=context.read<MatchBloc>().matchesList;
    super.initState();
    context.read<MatchEventBloc>().add(LoadMatchEvents(widget.matchId));
  }

  void _showSnackBar(String message) {
    LoadingOverlay.of(context).hide();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  bool reload = false;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MatchEventBloc>();
    final teamAId=matches.firstWhere((e)=>e.matchId==widget.matchId).teamAId;
    final teamBId=matches.firstWhere((e)=>e.matchId==widget.matchId).teamBId;
    final teamA=context.read<TeamBloc>().teamsList.firstWhere((e)=>e.teamId==teamAId).name;
    final teamB=context.read<TeamBloc>().teamsList.firstWhere((e)=>e.teamId==teamBId).name;
    return Scaffold(
      appBar: AppBar(title: Text('Match Events - $teamA vs $teamB')),
      body: BlocBuilder<MatchEventBloc, MatchEventState>(
        builder: (context, state) {
          if (state is MatchEventLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MatchEventLoaded) {
            if (state.matchEvents.isEmpty) {
              return const Center(child: Text('No match events found.'));
            }
            return ListView.separated(
              itemCount: state.matchEvents.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final event = state.matchEvents[index];
                return ListTile(
                  title: Text('${event.eventType.name} at ${event.minute}"'),
                  subtitle: Text(
                    'Player: ${event.playerName ?? "N/A"} | Team: ${teamBId==event.teamId?teamB:teamA}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed:
                            () => _showMatchEventDialog(
                              context: context,
                              bloc: bloc,
                              matchId: widget.matchId,
                              existingEvent: event,
                              isEdit: true,
                            ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed:
                            () => context.read<MatchEventBloc>().add(
                              DeleteMatchEvent(
                                matchEventsParams: MatchEventsParams(
                                  matchEventId: event.matchEventId,
                                  matchId: widget.matchId,
                                ),
                              ),
                            ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          if (state is MatchEventError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No data to display.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => _showMatchEventDialog(
              context: context,
              bloc: bloc,
              matchId: widget.matchId,
            ),
        tooltip: 'Add Match Event',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showMatchEventDialog({
    required BuildContext context,
    required MatchEventBloc bloc,
    MatchEventEntity? existingEvent,
    required String matchId,
    bool isEdit = false,
  }) {
    final playerNameController = TextEditingController(
      text: existingEvent?.playerName ?? '',
    );
    final teamController = TextEditingController(
      text:
          isEdit
              ? context
                  .read<TeamBloc>()
                  .teamsList
                  .firstWhere((e) => e.teamId == existingEvent?.teamId)
                  .name
              : '',
    );
    final minuteController = TextEditingController(
      text: existingEvent?.minute.toString() ?? '',
    );
    final eventTypeController = TextEditingController(
      text: isEdit ? existingEvent?.eventType.name ?? '' : '',
    );

    final formKey = GlobalKey<FormState>();

    showEntityDialog(
      context: context,
      title: isEdit ? 'Edit Match Event' : 'Add Match Event',
      form: BlocProvider.value(
        value: bloc,
        child: BlocListener<MatchEventBloc, MatchEventState>(
          listener: (context, state) {
            if (state is AddMatchEventLoading ||
                state is EditMatchEventLoading) {
              LoadingOverlay.of(context).show();
            } else if (state is AddMatchEventSuccess ||
                state is EditMatchEventSuccess) {
              _showSnackBar('Success');
              Navigator.of(context).pop();
              bloc.add(LoadMatchEvents(matchId));
            } else if (state is EditMatchEventFailed) {
              _showSnackBar(state.message);
            } else if (state is EditMatchEventFailed) {
              _showSnackBar(state.message);
            }
          },
          child: EntityForm(
            formKey: formKey,
            fields: [
              FormFieldConfig(
                name: 'Player Name',
                label: 'Player Name',
                controller: playerNameController,
                validator: (val) => val?.isEmpty ?? true ? 'Required' : null,
              ),
              FormFieldConfig(
                name: 'Minute',
                label: 'Minute',
                controller: minuteController,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required';
                  final parsed = int.tryParse(val);
                  if (parsed == null || parsed < 0 || parsed > 120) {
                    return 'Enter valid minute';
                  }
                  return null;
                },
              ),
              FormFieldConfig(
                name: 'Team',
                label: 'Team',
                controller: teamController,
                dropdownItems:
                    context
                        .read<TeamBloc>()
                        .teamsList
                        .map((e) => e.name)
                        .toList(),
                validator: (val) => val?.isEmpty ?? true ? 'Required' : null,
              ),
              FormFieldConfig(
                name: 'Event Type',
                label: 'Event Type',
                controller: eventTypeController,
                dropdownItems:
                    MatchEventType.values.map((e) => e.name).toList(),
                validator: (val) => val?.isEmpty ?? true ? 'Required' : null,
              ),
            ],
          ),
        ),
      ),
      onSave: () {
        if (formKey.currentState?.validate() ?? false) {
          final newEvent = MatchEventEntity(
            matchEventId: isEdit ? existingEvent!.matchEventId : '',
            playerName: playerNameController.text,
            minute: int.parse(minuteController.text),
            teamId:
                context
                    .read<TeamBloc>()
                    .teamsList
                    .firstWhere((e) => e.name == teamController.text)
                    .teamId,
            matchId: matchId,
            eventType: MatchEventType.values.firstWhere(
              (e) => e.name == eventTypeController.text,
            ),
          );

          isEdit
              ? bloc.add(EditMatchEvent(matchEventEntity: newEvent))
              : bloc.add(AddMatchEvent(matchEventEntity: newEvent));

          setState(() {
            reload = true;
          });
        }
      },
    );
  }
}
