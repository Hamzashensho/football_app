part of 'match_event_bloc.dart';
abstract class MatchEventEvent extends Equatable {
  const MatchEventEvent();

  @override
  List<Object> get props => [];
}

class LoadMatchEvents extends MatchEventEvent {
  final String matchId; // To load events for a specific match
  const LoadMatchEvents(this.matchId);

  @override
  List<Object> get props => [matchId];
}
// Add other match event-related events here (e.g., AddMatchEvent)

