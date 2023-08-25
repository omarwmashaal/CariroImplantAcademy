import 'package:equatable/equatable.dart';

abstract class AddToMyPatientsRangeBloc_States extends Equatable{}
class InitialState extends AddToMyPatientsRangeBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}class LoadingState extends AddToMyPatientsRangeBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class DoneState extends AddToMyPatientsRangeBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ErrorState extends AddToMyPatientsRangeBloc_States{
  final String message;
  ErrorState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}