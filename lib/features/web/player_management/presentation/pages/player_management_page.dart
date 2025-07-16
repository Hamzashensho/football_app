import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/core/widget/dialogs/entity_dialog.dart';
import 'package:sport_app_user/core/widget/form/entity_form.dart';
import 'package:sport_app_user/core/widget/loader.dart';
import 'package:sport_app_user/features/web/player_management/domain/entities/player_entity.dart';
import 'package:sport_app_user/features/web/player_management/presentation/blocs/player_bloc.dart';
import 'package:sport_app_user/features/web/team_management/presentation/blocs/team_bloc.dart';

class PlayerManagementPage extends StatefulWidget {
  const PlayerManagementPage({super.key});

  @override
  State<PlayerManagementPage> createState() => _PlayerManagementPageState();
}

class _PlayerManagementPageState extends State<PlayerManagementPage> {
  List<PlayerEntity> players = [];
  late bool reload = false;

  @override
  void initState() {
    super.initState();
    context.read<PlayerBloc>().add(LoadPlayers());
  }

  void _showSnackBar(String message) {
    LoadingOverlay.of(context).hide();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PlayerBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text('Player Management')),
      body: BlocConsumer<PlayerBloc, PlayerState>(
        buildWhen: (previous, current) => current is PlayerLoaded,
        listener: (context, state) {
          if (state is PlayerLoading || state is DeletePlayerLoading) {
            LoadingOverlay.of(context).show();
          } else if (state is PlayerLoaded) {
            LoadingOverlay.of(context).hide();
          } else if (state is DeletePlayerSuccess) {
            bloc.add(LoadPlayers());
            LoadingOverlay.of(context).hide();
          } else if (state is PlayerError) {
            _showSnackBar(state.message);
          } else if (state is DeletePlayerFailed) {
            _showSnackBar(state.message);
          }
        },
        builder: (context, state) {
          if (state is PlayerLoaded) {
            if (state.players.isEmpty) {
              return const Center(child: Text('No players found.'));
            }
            players = state.players;
            return ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                return ListTile(
                  title: Text(player.name),
                  subtitle: Text(
                    'Team: ${context
                        .read<TeamBloc>()
                        .teamsList
                        .firstWhere((e) => e.teamId == player.teamId)
                        .name}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed:
                            () =>
                            _showAddPlayerDialog(
                              context: context,
                              bloc: bloc,
                              player: player,
                              isEdit: true,
                            ),
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed:
                            () =>
                            bloc.add(
                              DeletePlayer(playerId: player.playerId),
                            ),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPlayerDialog(context: context, bloc: bloc);
          if (reload) bloc.add(LoadPlayers());
        },
        tooltip: 'Add Player',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddPlayerDialog({
    required BuildContext context,
    required PlayerBloc bloc,
    PlayerEntity? player,
    bool isEdit = false,
  }) {
    final nameController = TextEditingController(text: player?.name);

    final teamIdController = TextEditingController(text: isEdit ? context
        .read<TeamBloc>()
        .teamsList
        .firstWhere((e) => e.teamId == player?.teamId)
        .name:'');
    final formKey = GlobalKey<FormState>();

    showEntityDialog(
      context: context,
      title: isEdit ? 'Edit Player' : 'Add Player',
      form: BlocProvider.value(
        value: bloc,
        child: BlocListener<PlayerBloc, PlayerState>(
          listener: (context, state) {
            if (state is AddPlayerLoading || state is EditPlayerLoading) {
              LoadingOverlay.of(context).show();
            } else if (state is AddPlayerSuccess ||
                state is EditPlayerSuccess) {
              _showSnackBar('Success');
              Navigator.of(context).pop();
              bloc.add(LoadPlayers());
            } else if (state is AddPlayerFailed) {
              _showSnackBar(state.message);
            } else if (state is EditPlayerFailed) {
              _showSnackBar(state.message);
            }
          },
          child: EntityForm(
            formKey: formKey,
            fields: [
              FormFieldConfig(
                name: 'Name',
                label: 'Player Name',
                controller: nameController,
                validator: (val) => val?.isEmpty ?? true ? 'Required' : null,
              ),
              FormFieldConfig(
                name: 'Team',
                label: 'Team',
                controller: teamIdController,
                dropdownItems: context
                    .read<TeamBloc>()
                    .teamsList
                    .map((e) => e.name)
                    .toList(),
                validator: (val) => val?.isEmpty ?? true ? 'Required' : null,
              ),
            ],
          ),
        ),
      ),
      onSave: () {
        if (formKey.currentState?.validate() ?? false) {
          final newPlayer = PlayerEntity(
            playerId: isEdit ? player!.playerId : '',
            name: nameController.text,
            teamId: context
                .read<TeamBloc>()
                .teamsList
                .firstWhere((e) => e.name == teamIdController.text)
                .teamId,
          );

          isEdit
              ? bloc.add(EditPlayer(playerEntity: newPlayer))
              : bloc.add(AddPlayer(playerEntity: newPlayer));

          setState(() {
            reload = true;
          });
        }
      },
    );
  }
}
