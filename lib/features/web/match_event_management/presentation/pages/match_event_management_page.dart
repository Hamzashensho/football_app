import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_user/features/web/match_event_management/presentation/blocs/match_event_bloc.dart';


class MatchEventManagementPage extends StatefulWidget {
  final String matchId; // Assuming this page is typically accessed in context of a match
  const MatchEventManagementPage({super.key, required this.matchId});

  @override
  State<MatchEventManagementPage> createState() => _MatchEventManagementPageState();
}

class _MatchEventManagementPageState extends State<MatchEventManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match Events for Match ${widget.matchId}'),
      ),
      body: BlocBuilder<MatchEventBloc, MatchEventState>(
        builder: (context, state) {
          if (state is MatchEventLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MatchEventLoaded) {
            if (state.matchEvents.isEmpty) {
              return const Center(child: Text('No match events found for this match.'));
            }
            return ListView.builder(
              itemCount: state.matchEvents.length,
              itemBuilder: (context, index) {
                final event = state.matchEvents[index];
                return ListTile(
                  title: Text('${event.eventType.toString().split(".").last} at ${event.minute}"'),
                  subtitle: Text('Player: ${event.playerName ?? "N/A"}, Team ID: ${event.teamId}'),
                  // Add more details and actions (edit, delete) here
                );
              },
            );
          }
          if (state is MatchEventError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Match Event Management Page - Initial State'),
                ElevatedButton(
                  onPressed: () {
                    context.read<MatchEventBloc>().add(LoadMatchEvents(widget.matchId));
                  },
                  child: const Text('Load Match Events (Test)')
                )
              ],
            )
          ); // Initial or unhandled state
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add match event page or show a dialog
        },
        tooltip: 'Add Match Event',
        child: const Icon(Icons.add),
      ),
    );
  }
}

