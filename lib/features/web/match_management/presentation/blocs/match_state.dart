part of 'match_bloc.dart';
abstract class MatchState extends Equatable {
  const MatchState();

  @override
  List<Object> get props => [];
}

class MatchInitial extends MatchState {}

class MatchLoading extends MatchState {}

class MatchLoaded extends MatchState {
  final List<MatchEntity> matches;

  const MatchLoaded(this.matches);

  @override
  List<Object> get props => [matches];
}

class MatchError extends MatchState {
  final String message;

  const MatchError(this.message);

  @override
  List<Object> get props => [message];
}

