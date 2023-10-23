import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc_States.dart';
import 'package:equatable/equatable.dart';

abstract class CreateOrViewPatientBloc_Events extends Equatable{}

class CheckDuplicateNumberEvent extends CreateOrViewPatientBloc_Events{
  final String number;
  CheckDuplicateNumberEvent(this.number);
  @override
  // TODO: implement props
  List<Object?> get props => [number];
}
class SetPatientOutEvent extends CreateOrViewPatientBloc_Events{
  final int id;
  SetPatientOutEvent(this.id);
   @override
  // TODO: implement props
  List<Object?> get props => [id];
}
class CheckAvailableIdEvent extends CreateOrViewPatientBloc_Events{
  final int id;
  CheckAvailableIdEvent(this.id);
   @override
  // TODO: implement props
  List<Object?> get props => [id];
}
class CreatePatientEvent extends CreateOrViewPatientBloc_Events{
  final PatientInfoEntity patient;
  CreatePatientEvent({required this.patient});
   @override
  // TODO: implement props
  List<Object?> get props => [patient];
}
class InitialEvent extends CreateOrViewPatientBloc_Events{
    @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SearchPatientsEvent extends CreateOrViewPatientBloc_Events{
  final String query;
  SearchPatientsEvent({required this.query});
    @override
  // TODO: implement props
  List<Object?> get props => [query];
}

class GetPatientInfoEvent extends CreateOrViewPatientBloc_Events{
  final int id;
  GetPatientInfoEvent({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
class ChangePageStateEvent extends CreateOrViewPatientBloc_Events{
  final PageState pageState;
  ChangePageStateEvent({required this.pageState});
  @override
  // TODO: implement props
  List<Object?> get props => [pageState];
}

class UpdatePatientDataEvent extends CreateOrViewPatientBloc_Events{
  final PatientInfoEntity patient;
  UpdatePatientDataEvent({required this.patient});

  @override
  // TODO: implement props
  List<Object?> get props => [patient];
}