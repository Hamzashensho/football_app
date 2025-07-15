import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/utils/utils.dart';
import 'package:sport_app_user/core/widget/dialogs/entity_dialog.dart';
import 'package:sport_app_user/core/widget/form/entity_form.dart';
import 'package:sport_app_user/core/widget/loader.dart';
import 'package:sport_app_user/features/web/team_management/domain/entities/team_entity.dart';
import 'package:sport_app_user/features/web/team_management/domain/usecases/add_team_usecase.dart';
import 'package:sport_app_user/features/web/team_management/presentation/blocs/team_bloc.dart';

class TeamManagementPage extends StatefulWidget {
  const TeamManagementPage({super.key});

  @override
  State<TeamManagementPage> createState() => _TeamManagementPageState();
}

class _TeamManagementPageState extends State<TeamManagementPage> {
  List<TeamEntity> teams = [];
  bool isReload = false;

  @override
  void initState() {
    super.initState();
    context.read<TeamBloc>().add(LoadTeams());
  }

  void _showSnackBar(String message) {
    LoadingOverlay.of(context).hide();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TeamBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<TeamBloc>().add(LoadTeams()),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocConsumer<TeamBloc, TeamState>(
        listener: (context, state) {
          if (state is TeamLoading||state is DeleteTeamLoading) {
            LoadingOverlay.of(context).show();
          } else if (state is TeamLoaded) {
            LoadingOverlay.of(context).hide();
          }else if(state is DeleteTeamSuccess){
            LoadingOverlay.of(context).hide();
            bloc.add(LoadTeams());
          } else if (state is TeamError) {
            _showSnackBar(state.message);
          }else if(state is DeleteTeamFailed){
            _showSnackBar(state.message);
          }
        },
        buildWhen: (previous, current) => current is TeamLoaded,
        builder: (context, state) {
          if (state is TeamError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => bloc.add(LoadTeams()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is TeamLoaded) {
            if (state.teams.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No teams found.'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to add team page
                      },
                      child: const Text('Add New Team'),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<TeamBloc>().add(LoadTeams());
              },
              child: ListView.separated(
                itemCount: state.teams.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final team = state.teams[index];
                  return ListTile(
                    title: Text(team.name),
                    subtitle: Text('Goals: ${team.goalCount ?? 'N/A'}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showAddTeamDialog(context: context, bloc: bloc,isEdit: true,teamEntity: team);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            bloc.add(DeleteTeam(teamId: team.teamId));
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigate to team details
                    },
                  );
                },
              ),
            );
          }

          return Center(
            child: ElevatedButton(
              onPressed: () => bloc.add(LoadTeams()),
              child: const Text('Load Teams'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTeamDialog(context: context,bloc:  bloc);
        },
        tooltip: 'Add Team',
        elevation: 6,
        hoverElevation: 12,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showAddTeamDialog({
    required BuildContext context,
    required TeamBloc bloc,
    bool isEdit = false,
    TeamEntity? teamEntity,
  }) {
    final TextEditingController nameController = TextEditingController(text: teamEntity?.name);
    final TextEditingController goalsController = TextEditingController(text: teamEntity?.goalCount.toString());
    final formKey = GlobalKey<FormState>();

    showEntityDialog(
      context: context,
      title: 'Add New Team',
      form: BlocListener<TeamBloc, TeamState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is AddTeamLoading||state is EditTeamLoading) {
            LoadingOverlay.of(context).show();
          } else if (state is AddTeamSuccess||state is EditTeamSuccess) {
            _showSnackBar('Success');
            Navigator.of(context).pop();
            bloc.add(LoadTeams());
          } else if (state is AddTeamFailed) {
            _showSnackBar(state.message);
          }else if(state is EditTeamFailed){
            _showSnackBar(state.message);
          }
        },
        child: EntityForm(
          formKey: formKey,

          fields: [
            FormFieldConfig(
              name: 'name',
              label: 'Team Name',
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              controller: nameController,
            ),
            FormFieldConfig(
              name: 'goals',
              label: 'Goals Number',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                if (!Utils.isInt(value)) {
                  return 'Must be a number';
                }
                return null;
              },
              controller: goalsController,
            ),

          ],
        ),
      ),
      onSave: () {
        if (formKey.currentState?.validate() ?? false) {
          if(isEdit){
            bloc.add(EditTeam(teamParams: TeamParams(
              teamId: teamEntity?.teamId,
              goalCount: int.parse(goalsController.text),
              name: nameController.text,
            )));
          }else {
            bloc.add(
              AddTeam(
                teamParams: TeamParams(
                  name: nameController.text,
                  goalCount: int.parse(goalsController.text),
                ),
              ),
            );
          }
          setState(() {});
        }
      },
    );
  }
}
