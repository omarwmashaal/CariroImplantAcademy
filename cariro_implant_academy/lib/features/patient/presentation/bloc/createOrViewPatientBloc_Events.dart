import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc_States.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/setPatientOutUseCase.dart';

abstract class CreateOrViewPatientBloc_Events extends Equatable {}

class CheckDuplicateNumberEvent extends CreateOrViewPatientBloc_Events {
  final String number;
  CheckDuplicateNumberEvent(this.number);
  @override
  // TODO: implement props
  List<Object?> get props => [number];
}

class SetPatientOutEvent extends CreateOrViewPatientBloc_Events {
  final SetPatientOutParams params;
  SetPatientOutEvent(this.params);
  @override
  // TODO: implement props
  List<Object?> get props => [params];
}

class CheckAvailableIdEvent extends CreateOrViewPatientBloc_Events {
  final String id;
  CheckAvailableIdEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class CreatePatientEvent extends CreateOrViewPatientBloc_Events {
  final PatientInfoEntity patient;
  CreatePatientEvent({required this.patient});
  @override
  // TODO: implement props
  List<Object?> get props => [patient];
}

class GetNextAvailableIdEvent extends CreateOrViewPatientBloc_Events {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchPatientsEvent extends CreateOrViewPatientBloc_Events {
  final String query;
  SearchPatientsEvent({required this.query});
  @override
  // TODO: implement props
  List<Object?> get props => [query];
}

class GetPatientInfoEvent extends CreateOrViewPatientBloc_Events {
  final int id;
  GetPatientInfoEvent({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class ChangePageStateEvent extends CreateOrViewPatientBloc_Events {
  final PageState pageState;
  final bool listed;
  ChangePageStateEvent({required this.pageState,required this.listed});
  @override
  // TODO: implement props
  List<Object?> get props => [pageState, this.listed];
}

class UpdatePatientDataEvent extends CreateOrViewPatientBloc_Events {
  final PatientInfoEntity patient;
  UpdatePatientDataEvent({required this.patient});

  @override
  // TODO: implement props
  List<Object?> get props => [patient];
}
