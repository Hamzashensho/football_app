import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/utils/utils.dart';
import 'package:sport_app_user/core/widget/dialogs/entity_dialog.dart';
import 'package:sport_app_user/core/widget/form/entity_form.dart';
import 'package:sport_app_user/core/widget/loader.dart';
import 'package:sport_app_user/features/web/match_management/domain/entities/match_entity.dart';
import 'package:sport_app_user/features/web/match_management/presentation/blocs/match_bloc.dart';
import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';
import 'package:sport_app_user/features/web/champion_management/domain/entities/champion_entity.dart';

void showMatchDialog({
  required BuildContext context,
  bool isEdit = false,
  MatchEntity? match,
  required List<TeamEntity> teamList,
  required List<ChampionEntity> championList,
}) {
  final formKey = GlobalKey<FormState>();
  final bloc = context.read<MatchBloc>();

  final teamAController = TextEditingController(
    text: match != null ? teamList.firstWhere((e) => e.teamId == match.teamAId).name : '',
  );
  final teamBController = TextEditingController(
    text: match != null ? teamList.firstWhere((e) => e.teamId == match.teamBId).name : '',
  );
  final teamAScoreController = TextEditingController(text: match?.teamAScore.toString() ?? '0');
  final teamBScoreController = TextEditingController(text: match?.teamBScore.toString() ?? '0');
  final stadiumController = TextEditingController(text: match?.stadiumName ?? '');
  final dateController = TextEditingController(text: match?.date.toIso8601String().split('T').first ?? '');
  final timeController = TextEditingController(text: match?.time ?? '');
  final typeController = TextEditingController(text: match?.type ?? '');
  final statusController = TextEditingController(text: match?.status ?? '');
  final groupController = TextEditingController(text: match?.group ?? '');
  final championController = TextEditingController(
    text: match != null ? championList.firstWhere((e) => e.championId == match.championId).title : '',
  );

  final teamNames = teamList.map((e) => e.name).toList();
  final championTitles = championList.map((e) => e.title).toList();

  showEntityDialog(
    context: context,
    title: isEdit ? 'Edit Match' : 'Add Match',
    form: BlocListener<MatchBloc, MatchState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is AddMatchLoading || state is EditMatchLoading) {
          LoadingOverlay.of(context).show();
        } else if (state is AddMatchSuccess || state is EditMatchSuccess) {
          LoadingOverlay.of(context).hide();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Success')));
          bloc.add(LoadMatches());
        } else if (state is AddMatchFailed) {
          LoadingOverlay.of(context).hide();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }else if(state is EditMatchFailed){
          LoadingOverlay.of(context).hide();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));

        }
      },
      child: EntityForm(
        formKey: formKey,
        fields: [
          FormFieldConfig(name: 'teamA', label: 'Team A', controller: teamAController, dropdownItems: teamNames),
          FormFieldConfig(
            name: 'teamB',
            label: 'Team B',
            controller: teamBController,
            dropdownItems: teamNames.where((name) => name != teamAController.text).toList(),
          ),
          FormFieldConfig(
            name: 'teamAScore',
            label: 'Team A Score',
            controller: teamAScoreController,
            validator: (value) => value == null || value.isEmpty
                ? 'Required'
                : !Utils.isInt(value)
                ? 'Must be a number'
                : null,
          ),
          FormFieldConfig(
            name: 'teamBScore',
            label: 'Team B Score',
            controller: teamBScoreController,
            validator: (value) => value == null || value.isEmpty
                ? 'Required'
                : !Utils.isInt(value)
                ? 'Must be a number'
                : null,
          ),
          FormFieldConfig(name: 'stadium', label: 'Stadium', controller: stadiumController),
          FormFieldConfig(name: 'date', label: 'Date (YYYY-MM-DD)', controller: dateController, isDatePicker: true),
          FormFieldConfig(name: 'time', label: 'Time', controller: timeController, isTimePicker: true),
          FormFieldConfig(
            name: 'type',
            label: 'Match Type',
            controller: typeController,
            dropdownItems: MatchType.values.map((e) => e.displayTypeName).toList(),
          ),
          FormFieldConfig(
            name: 'status',
            label: 'Status',
            controller: statusController,
            dropdownItems: MatchStatus.values.map((e) => e.displayStatusName).toList(),
          ),
          FormFieldConfig(name: 'group', label: 'Group', controller: groupController, dropdownItems: championTitles),
          FormFieldConfig(name: 'champion', label: 'Champion', controller: championController, dropdownItems: championTitles),
        ],
      ),
    ),
    onSave: () {
      if (formKey.currentState?.validate() ?? false) {
        final newMatch = MatchEntity(
          matchId: isEdit ? match!.matchId : '',
          teamAId: teamList.firstWhere((e) => e.name == teamAController.text).teamId,
          teamBId: teamList.firstWhere((e) => e.name == teamBController.text).teamId,
          stadiumName: stadiumController.text,
          date: DateTime.parse(dateController.text),
          time: timeController.text,
          type: MatchType.values.firstWhere((e) => e.displayTypeName == typeController.text).displayTypeName,
          status: MatchStatus.values.firstWhere((e) => e.displayStatusName == statusController.text).displayStatusName,
          group: groupController.text,
          championId: championList.firstWhere((e) => e.title == championController.text).championId,
          teamAScore: int.parse(teamAScoreController.text),
          teamBScore: int.parse(teamBScoreController.text),
        );
        isEdit ? bloc.add(EditMatch(matchEntity: newMatch)) : bloc.add(AddMatch(matchEntity: newMatch));
      }
    },
  );
}