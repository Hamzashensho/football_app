part of 'match_event_bloc.dart';


abstract class MatchEventState extends Equatable {
  const MatchEventState();

  @override
  List<Object> get props => [];
}

class MatchEventInitial extends MatchEventState {}

class MatchEventLoading extends MatchEventState {}

class MatchEventLoaded extends MatchEventState {
  final List<MatchEventEntity> matchEvents;

  const MatchEventLoaded(this.matchEvents);

  @override
  List<Object> get props => [matchEvents];
}

class MatchEventError extends MatchEventState {
  final String message;

  const MatchEventError(this.message);

  @override
  List<Object> get props => [message];
}


class AddMatchEventSuccess extends MatchEventState{}
class AddMatchEventLoading extends MatchEventState{}
class AddMatchEventFailed extends MatchEventState{
  final String message;

  const AddMatchEventFailed(this.message);
}

class EditMatchEventSuccess extends MatchEventState{}
class EditMatchEventLoading extends MatchEventState{}
class EditMatchEventFailed extends MatchEventState{
  final String message;

  const EditMatchEventFailed(this.message);
}

class DeleteMatchEventSuccess extends MatchEventState{}
class DeleteMatchEventLoading extends MatchEventState{}
class DeleteMatchEventFailed extends MatchEventState{
  final String message;

  const DeleteMatchEventFailed(this.message);
}
