part of 'match_bloc.dart';

@immutable
sealed class MatchState extends Equatable {
  const MatchState();

  @override
  List<Object> get props => [];
}

//LoadMatches states
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

//AddMatch states
class AddMatchLoading extends MatchState{}
class AddMatchSuccess extends MatchState{}
class AddMatchFailed extends MatchState{
  final String message;
  const AddMatchFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

//EditMatch states
class EditMatchLoading extends MatchState{}
class EditMatchSuccess extends MatchState{}
class EditMatchFailed extends MatchState{
  final String message;
  const EditMatchFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

//DeleteMatch states
class DeleteMatchLoading extends MatchState{}
class DeleteMatchSuccess extends MatchState{}
class DeleteMatchFailed extends MatchState{
  final String message;
  const DeleteMatchFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}