import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/features/web/player_management/presentation/blocs/player_bloc.dart';


class PlayerManagementPage extends StatefulWidget {
  const PlayerManagementPage({super.key});

  @override
  State<PlayerManagementPage> createState() => _PlayerManagementPageState();
}

class _PlayerManagementPageState extends State<PlayerManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Management'),
      ),
      body: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, state) {
          if (state is PlayerLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PlayerLoaded) {
            if (state.players.isEmpty) {
              return const Center(child: Text('No players found.'));
            }
            return ListView.builder(
              itemCount: state.players.length,
              itemBuilder: (context, index) {
                final player = state.players[index];
                return ListTile(
                  title: Text(player.name),
                  subtitle: Text('Team ID: ${player.teamId}'),
                  // Add more details and actions (edit, delete) here
                );
              },
            );
          }
          if (state is PlayerError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Player Management Page - Initial State'),
                ElevatedButton(
                  onPressed: () {
                    context.read<PlayerBloc>().add(LoadPlayers());
                  },
                  child: const Text('Load Players (Test)')
                )
              ],
            )
          ); // Initial or unhandled state
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add player page or show a dialog
        },
        tooltip: 'Add Player',
        child: const Icon(Icons.add),
      ),
    );
  }
}

