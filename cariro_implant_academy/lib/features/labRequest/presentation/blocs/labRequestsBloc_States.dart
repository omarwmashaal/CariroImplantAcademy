import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/labRequestEntityl.dart';

abstract class LabRequestsBloc_States extends Equatable {}

class LabRequestsBloc_InitState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_UpdateQueueNumberState extends LabRequestsBloc_States {
  final int number;

  LabRequestsBloc_UpdateQueueNumberState({required this.number});

  @override
  List<Object?> get props => [number];
}

class LabRequestsBloc_LoadingRequestsErrorState extends LabRequestsBloc_States {
  final String message;

  LabRequestsBloc_LoadingRequestsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LabRequestsBloc_LoadingSingleRequestErrorState extends LabRequestsBloc_States {
  final String message;

  LabRequestsBloc_LoadingSingleRequestErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LabRequestsBloc_LoadedMultiRequestsSuccessfullyState extends LabRequestsBloc_States {
  final List<LabRequestEntity> requests;

  LabRequestsBloc_LoadedMultiRequestsSuccessfullyState({required this.requests});

  @override
  List<Object?> get props => [requests];
}

class LabRequestsBloc_LoadedSingleRequestsSuccessfullyState extends LabRequestsBloc_States {
  final LabRequestEntity request;

  LabRequestsBloc_LoadedSingleRequestsSuccessfullyState({required this.request});

  @override
  List<Object?> get props => [request];
}

class LabRequestsBloc_LoadingRequestsState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_CreatingCustomerErrorState extends LabRequestsBloc_States {
  final String message;

  LabRequestsBloc_CreatingCustomerErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LabRequestsBloc_CreatedCustomerSuccessfullyState extends LabRequestsBloc_States {
  final UserEntity newCustomer;

  LabRequestsBloc_CreatedCustomerSuccessfullyState({required this.newCustomer});

  @override
  List<Object?> get props => [newCustomer];
}

class LabRequestsBloc_CreatingCustomerState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_ChangedDeliveryDateState extends LabRequestsBloc_States {
  final DateTime date;

  LabRequestsBloc_ChangedDeliveryDateState({required this.date});

  @override
  List<Object?> get props => [date];
}

class LabRequestsBloc_ChangedCustomerState extends LabRequestsBloc_States {
  final UserEntity customer;

  LabRequestsBloc_ChangedCustomerState({required this.customer});

  @override
  List<Object?> get props => [customer];
}

class LabRequestsBloc_ChangedPatientState extends LabRequestsBloc_States {
  final BasicNameIdObjectEntity patient;

  LabRequestsBloc_ChangedPatientState({required this.patient});

  @override
  List<Object?> get props => [patient];
}

class LabRequestsBloc_SearchingPatientsState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_LoadedPatientsState extends LabRequestsBloc_States {
  final List<PatientInfoEntity> patients;

  LabRequestsBloc_LoadedPatientsState({required this.patients});

  @override
  List<Object?> get props => [patients];
}

class LabRequestsBloc_SearchingPatientsErrorState extends LabRequestsBloc_States {
  final String message;

  LabRequestsBloc_SearchingPatientsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LabRequestsBloc_CreatingLabRequestState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_CreatedLabRequestSuccessfullyState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_CreatingLabRequestErrorState extends LabRequestsBloc_States {
  final String message;

  LabRequestsBloc_CreatingLabRequestErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
class LabRequestsBloc_UpdatingLabRequestState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_UpdatedLabRequestSuccessfullyState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_UpdatingLabRequestErrorState extends LabRequestsBloc_States {
  final String message;

  LabRequestsBloc_UpdatingLabRequestErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LabRequestsBloc_FinishingTaskState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_FinishedTaskSuccessfullyState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_FinishingTaskErrorState extends LabRequestsBloc_States {
  final String message;

  LabRequestsBloc_FinishingTaskErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LabRequestsBloc_MarkingRequestAsDoneState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_MarkedRequestAsDoneSuccessfullyState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_MarkingRequestAsDoneErrorState extends LabRequestsBloc_States {
  final String message;

  LabRequestsBloc_MarkingRequestAsDoneErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
class LabRequestsBloc_UpdatingRequestReceiptState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_UpdatedRequestReceiptSuccessfullyState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_UpdatingRequestErrorState extends LabRequestsBloc_States {
  final String message;

  LabRequestsBloc_UpdatingRequestErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
class LabRequestsBloc_AddingToMyTasksState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_AddedToMyTasksSuccessfullyState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_AddingToMyTasksErrorState extends LabRequestsBloc_States {
  final String message;

  LabRequestsBloc_AddingToMyTasksErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
class LabRequestsBloc_AssigningTaskToATechnicianState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_AssignedTaskToATechnicianSuccessfullyState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_AssigningTaskToATechnicianErrorState extends LabRequestsBloc_States {
  final String message;

  LabRequestsBloc_AssigningTaskToATechnicianErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LabRequestsBloc_SwitchEditViewReceiptModeState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
class LabRequestsBloc_UpdateReceiptTotalPriceState extends LabRequestsBloc_States {
  final int totalPrice;
  LabRequestsBloc_UpdateReceiptTotalPriceState({required this.totalPrice});
  @override
  List<Object?> get props => [totalPrice];
}



class LabRequestsBloc_ConsumingLabItemState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_ConsumedLabItemSuccessfullyState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LabRequestsBloc_ConsumingLabItemErrorState extends LabRequestsBloc_States {
  final String message;

  LabRequestsBloc_ConsumingLabItemErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
class LabRequestsBloc_LoadingLabItemState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_LoadedLabItemSuccessfullyState extends LabRequestsBloc_States {
  final LabItemEntity data;
  LabRequestsBloc_LoadedLabItemSuccessfullyState({required this.data});
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LabRequestsBloc_LoadingLabItemErrorState extends LabRequestsBloc_States {
  final String message;

  LabRequestsBloc_LoadingLabItemErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LabRequestsBloc_LoadingLabReceiptState extends LabRequestsBloc_States {
  @override
  List<Object?> get props => [];
}

class LabRequestsBloc_LoadedLabReceiptuccessfullyState extends LabRequestsBloc_States {
  final ReceiptEntity? data;
  LabRequestsBloc_LoadedLabReceiptuccessfullyState({required this.data});
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class LabRequestsBloc_LoadingLabReceiptErrorState extends LabRequestsBloc_States {
  final String message;

  LabRequestsBloc_LoadingLabReceiptErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
