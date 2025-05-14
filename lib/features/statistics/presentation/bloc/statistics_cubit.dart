import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit()
      : super(StatisticsState(selectedTab: 0, expandedGroups: {}));

  void changeTab(int index) {
    emit(state.copyWith(selectedTab: index));
  }

  void selectTeam(TeamModel? team) {
    emit(state.copyWith(selectedTeam: team, isSelectedTeamProvided: true));
  }

  void toggleGroup(String groupName) {
    final isExpanded = state.expandedGroups[groupName] ?? false;
    final updatedGroups = Map<String, bool>.from(state.expandedGroups);
    updatedGroups[groupName] = !isExpanded;
    emit(state.copyWith(expandedGroups: updatedGroups));
  }
}

class StatisticsState {
  final int selectedTab;
  final TeamModel? selectedTeam;
  final Map<String, bool> expandedGroups;

  StatisticsState({required this.selectedTab, this.selectedTeam, required this.expandedGroups});

  StatisticsState copyWith({
    int? selectedTab,
    TeamModel? selectedTeam,
    bool isSelectedTeamProvided = false,
    Map<String, bool>? expandedGroups,
  }) {
    return StatisticsState(
      selectedTab: selectedTab ?? this.selectedTab,
      selectedTeam: isSelectedTeamProvided ? selectedTeam : this.selectedTeam,
      expandedGroups: expandedGroups ?? this.expandedGroups,
    );
  }

}
