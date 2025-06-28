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

