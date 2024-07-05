import 'package:equatable/equatable.dart';

import '../../domain/entities/patientInfoEntity.dart';

abstract class CreateOrViewPatientBloc_State extends Equatable {}

class LoadingPatientInfoState extends CreateOrViewPatientBloc_State {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CreatingPatientState extends CreateOrViewPatientBloc_State {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedPatientInfoState extends CreateOrViewPatientBloc_State {
  final PatientInfoEntity patient;
  LoadedPatientInfoState({required this.patient});
  @override
  // TODO: implement props
  List<Object?> get props => [patient, identityHashCode(this)];
}

class LoadingId extends CreateOrViewPatientBloc_State {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingDuplicateNumber extends CreateOrViewPatientBloc_State {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedDuplicateNumber extends CreateOrViewPatientBloc_State {
  final String? name;
  LoadedDuplicateNumber(this.name);
  @override
  // TODO: implement props
  List<Object?> get props => [name];
}

class LoadedAvailableId extends CreateOrViewPatientBloc_State {
  final String? message;
  LoadedAvailableId({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class LoadedGetNextId extends CreateOrViewPatientBloc_State {
  final String? message;
  LoadedGetNextId({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ChangedDateOfBirthState extends CreateOrViewPatientBloc_State {
  final DateTime? date;
  ChangedDateOfBirthState({this.date});
  @override
  // TODO: implement props
  List<Object?> get props => [date];
}

class LoadingPatients extends CreateOrViewPatientBloc_State {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedPatients extends CreateOrViewPatientBloc_State {
  final List<PatientInfoEntity> patients;
  LoadedPatients({required this.patients});
  @override
  // TODO: implement props
  List<Object?> get props => [patients];
}

class ChangedPatientRelative extends CreateOrViewPatientBloc_State {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CreatedPatientState extends CreateOrViewPatientBloc_State {
  final PatientInfoEntity patient;
  CreatedPatientState({required this.patient});
  @override
  // TODO: implement props
  List<Object?> get props => [patient];
}

class Error extends CreateOrViewPatientBloc_State {
  final String message;
  Error(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ChangePageState extends CreateOrViewPatientBloc_State {
  final String message;
  final bool listed;
  ChangePageState(this.message, this.listed);
  @override
  // TODO: implement props
  List<Object?> get props => [message, identityHashCode(this), this.listed];
}

class UpdatingPatientState extends CreateOrViewPatientBloc_State {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PatientOutSuccessfullyState extends CreateOrViewPatientBloc_State {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdatingPatientErrorState extends CreateOrViewPatientBloc_State {
  final String message;
  UpdatingPatientErrorState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class UpdatedPatientSuccessfully extends CreateOrViewPatientBloc_State {
  final PatientInfoEntity patient;
  UpdatedPatientSuccessfully({required this.patient});
  @override
  // TODO: implement props
  List<Object?> get props => [patient];
}

enum PageState { addNew, edit, view }
