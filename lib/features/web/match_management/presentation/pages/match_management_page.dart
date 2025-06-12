import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/features/web/match_management/presentation/blocs/match_bloc.dart';


class MatchManagementPage extends StatefulWidget {
  const MatchManagementPage({super.key});

  @override
  State<MatchManagementPage> createState() => _MatchManagementPageState();
}

class _MatchManagementPageState extends State<MatchManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Management'),
      ),
      body: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, state) {
          if (state is MatchLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MatchLoaded) {
            if (state.matches.isEmpty) {
              return const Center(child: Text('No matches found.'));
            }
            return ListView.builder(
              itemCount: state.matches.length,
              itemBuilder: (context, index) {
                final match = state.matches[index];
                return ListTile(
                  title: Text('Match ID: ${match.matchId}'),
                  subtitle: Text('${match.teamAId} vs ${match.teamBId} on ${match.date.toIso8601String().substring(0,10)} at ${match.stadiumName}'),
                  // Add more details and actions (edit, delete) here
                );
              },
            );
          }
          if (state is MatchError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Match Management Page - Initial State'),
                ElevatedButton(
                  onPressed: () {
                    context.read<MatchBloc>().add(LoadMatches());
                  },
                  child: const Text('Load Matches (Test)')
                )
              ],
            )
          ); // Initial or unhandled state
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add match page or show a dialog
        },
        tooltip: 'Add Match',
        child: const Icon(Icons.add),
      ),
    );
  }
}

