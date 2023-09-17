import 'package:equatable/equatable.dart';

import '../../domain/entities/patientInfoEntity.dart';

abstract class CreateOrViewPatientBloc_State extends Equatable{}

class LoadingPatientInfoState extends CreateOrViewPatientBloc_State{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CreatingPatientState extends CreateOrViewPatientBloc_State{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoadedPatientInfoState extends CreateOrViewPatientBloc_State{
  final PatientInfoEntity patient;
  LoadedPatientInfoState({required this.patient});
  @override
  // TODO: implement props
  List<Object?> get props => [patient];
}
class LoadingId extends CreateOrViewPatientBloc_State{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoadingDuplicateNumber extends CreateOrViewPatientBloc_State{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoadedDuplicateNumber extends CreateOrViewPatientBloc_State{
  final String? name;
  LoadedDuplicateNumber(this.name);
  @override
  // TODO: implement props
  List<Object?> get props => [name];
}
class LoadedAvailableId extends CreateOrViewPatientBloc_State{
  final String? message;
  LoadedAvailableId({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class LoadedGetNextId extends CreateOrViewPatientBloc_State{
  final String? message;
  LoadedGetNextId({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class ChangedDateOfBirthState extends CreateOrViewPatientBloc_State{
  final String? date;
  ChangedDateOfBirthState({this.date});
  @override
  // TODO: implement props
  List<Object?> get props => [date];
}
class LoadingPatients extends CreateOrViewPatientBloc_State{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoadedPatients extends CreateOrViewPatientBloc_State{
  final List<PatientInfoEntity> patients;
  LoadedPatients({required this.patients});
  @override
  // TODO: implement props
  List<Object?> get props => [patients];
}
class ChangedPatientRelative extends CreateOrViewPatientBloc_State{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CreatedPatientState extends CreateOrViewPatientBloc_State{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class Error extends CreateOrViewPatientBloc_State{
  final String message;
  Error(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class ChangePageState extends CreateOrViewPatientBloc_State{
  final String message;
  ChangePageState(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
enum PageState{addNew,edit,view}