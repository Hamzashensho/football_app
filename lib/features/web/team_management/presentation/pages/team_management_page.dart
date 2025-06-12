import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/utils/utils.dart';
import 'package:sport_app_user/core/widget/dialogs/entity_dialog.dart';
import 'package:sport_app_user/core/widget/form/entity_form.dart';
import 'package:sport_app_user/features/web/team_management/presentation/blocs/team_bloc.dart';

class TeamManagementPage extends StatefulWidget {
  const TeamManagementPage({super.key});

  @override
  State<TeamManagementPage> createState() => _TeamManagementPageState();
}

class _TeamManagementPageState extends State<TeamManagementPage> {
  @override
  void initState() {
    super.initState();
    // Load teams when the page initializes
    context.read<TeamBloc>().add(LoadTeams());
  }

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<TeamBloc, TeamState>(
        builder: (context, state) {
          if (state is TeamLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TeamError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<TeamBloc>().add(LoadTeams()),
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
                            // Handle edit
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Handle delete
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

          // Initial state fallback
          return Center(
            child: ElevatedButton(
              onPressed: () => context.read<TeamBloc>().add(LoadTeams()),
              child: const Text('Load Teams'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTeamDialog(context);
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
}
void _showAddTeamDialog(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final  TextEditingController coachController = TextEditingController();
  final  formKey = GlobalKey<FormState>();


  showEntityDialog(
    context: context,
    title: 'Add New Team',
    form: EntityForm(
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
            controller: coachController
        ),
      ],

    ), onSave: () {

  },
  );
}