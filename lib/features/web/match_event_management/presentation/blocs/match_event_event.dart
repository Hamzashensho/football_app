part of 'match_event_bloc.dart';
abstract class MatchEventEvent extends Equatable {
  const MatchEventEvent();

  @override
  List<Object> get props => [];
}

class LoadMatchEvents extends MatchEventEvent {
  final String matchId;
  const LoadMatchEvents(this.matchId);

  @override
  List<Object> get props => [matchId];
}

class AddMatchEvent extends MatchEventEvent{
  final MatchEventEntity matchEventEntity;
  const AddMatchEvent({required this.matchEventEntity});
}

class EditMatchEvent extends MatchEventEvent{
  final MatchEventEntity matchEventEntity;
  const EditMatchEvent({required this.matchEventEntity});
}

class DeleteMatchEvent extends MatchEventEvent{
  final MatchEventsParams matchEventsParams;
  const DeleteMatchEvent({required this.matchEventsParams});

}