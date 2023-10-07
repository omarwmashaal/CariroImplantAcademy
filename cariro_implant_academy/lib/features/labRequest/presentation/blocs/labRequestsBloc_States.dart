import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/labRequestEntityl.dart';

abstract class LabRequestsBloc_States extends Equatable{}

class LabRequestsBloc_InitState extends LabRequestsBloc_States{

  @override
  List<Object?> get props => [];
}class LabRequestsBloc_UpdateQueueNumberState extends LabRequestsBloc_States{
  final int number;
  LabRequestsBloc_UpdateQueueNumberState({required this.number});

  @override
  List<Object?> get props => [number];
}

class LabRequestsBloc_LoadingRequestsErrorState extends LabRequestsBloc_States{
  final String message;
  LabRequestsBloc_LoadingRequestsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
class LabRequestsBloc_LoadedRequestsSuccessfullyState extends LabRequestsBloc_States{
  final List<LabRequestEntity> requests;
  LabRequestsBloc_LoadedRequestsSuccessfullyState({required this.requests});

  @override
  List<Object?> get props => [requests];
}
class LabRequestsBloc_LoadingRequestsState extends LabRequestsBloc_States{

  @override
  List<Object?> get props => [];
}
class LabRequestsBloc_CreatingCustomerErrorState extends LabRequestsBloc_States{
  final String message;
  LabRequestsBloc_CreatingCustomerErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
class LabRequestsBloc_CreatedCustomerSuccessfullyState extends LabRequestsBloc_States{
  final UserEntity newCustomer;
  LabRequestsBloc_CreatedCustomerSuccessfullyState({required this.newCustomer});

  @override
  List<Object?> get props => [newCustomer];
}
class LabRequestsBloc_CreatingCustomerState extends LabRequestsBloc_States{

  @override
  List<Object?> get props => [];
}
class LabRequestsBloc_ChangedDeliveryDateState extends LabRequestsBloc_States{
  final DateTime date;
  LabRequestsBloc_ChangedDeliveryDateState({required this.date});
  @override
  List<Object?> get props => [date];
}
class LabRequestsBloc_ChangedCustomerState extends LabRequestsBloc_States{
  final UserEntity customer;
  LabRequestsBloc_ChangedCustomerState({required this.customer});
  @override
  List<Object?> get props => [customer];
}
class LabRequestsBloc_ChangedPatientState extends LabRequestsBloc_States{
  final BasicNameIdObjectEntity patient;
  LabRequestsBloc_ChangedPatientState({required this.patient});
  @override
  List<Object?> get props => [patient];
}

class LabRequestsBloc_SearchingPatientsState extends LabRequestsBloc_States{

  @override
  List<Object?> get props => [];
}
class LabRequestsBloc_LoadedPatientsState extends LabRequestsBloc_States{
  final List<PatientInfoEntity> patients;
  LabRequestsBloc_LoadedPatientsState({required this.patients});
  @override
  List<Object?> get props => [patients];
}
class LabRequestsBloc_SearchingPatientsErrorState extends LabRequestsBloc_States{
  final String message;
  LabRequestsBloc_SearchingPatientsErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}
class LabRequestsBloc_CreatingLabRequestState extends LabRequestsBloc_States{

  @override
  List<Object?> get props => [];
}
class LabRequestsBloc_CreatedLabRequestSuccessfullyState extends LabRequestsBloc_States{
   @override
  List<Object?> get props => [];
}
class LabRequestsBloc_CreatingLabRequestErrorState extends LabRequestsBloc_States{
  final String message;
  LabRequestsBloc_CreatingLabRequestErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}