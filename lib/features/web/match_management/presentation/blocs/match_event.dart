part of 'match_bloc.dart';

@immutable
sealed class MatchEvent extends Equatable {
  const MatchEvent();

  @override
  List<Object> get props => [];
}

class LoadMatches extends MatchEvent {}

class AddMatch extends MatchEvent{
  final MatchEntity matchEntity;
  const AddMatch({required this.matchEntity});
  @override
  List<Object> get props => [matchEntity];
}

class EditMatch extends MatchEvent{
  final MatchEntity matchEntity;
  const EditMatch({required this.matchEntity});
  @override
  List<Object> get props => [matchEntity];
}

class DeleteMatch extends MatchEvent{
  final String matchId;
  const DeleteMatch({required this.matchId});
  @override
  List<Object> get props => [matchId];
}