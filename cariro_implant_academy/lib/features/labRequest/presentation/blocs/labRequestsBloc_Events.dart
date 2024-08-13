import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/addOrUpdateRequestReceiptUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/assignTaskToTechnicianUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/consumeLabItemUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/finishTaskUseCase.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/usecases/markRequestAsDoneUseCase.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/searchUsersByWorkPlaceUseCase.dart';

import '../../domain/usecases/getAllRequestsUseCase.dart';
import '../../domain/usecases/searchLabPatientsByTypeUseCase.dart';

abstract class LabRequestsBloc_Events {}

class LabRequestsBloc_GetTodaysRequestsEvent extends LabRequestsBloc_Events {
  final GetAllRequestsParams getAllRequestsParams;
  LabRequestsBloc_GetTodaysRequestsEvent({required this.getAllRequestsParams});
}

class LabRequestsBloc_CreateLabCustomerEvent extends LabRequestsBloc_Events {
  final UserEntity customer;
  LabRequestsBloc_CreateLabCustomerEvent({required this.customer});
}

class LabRequestsBloc_SearchLabPatientsByTypeEvent extends LabRequestsBloc_Events {
  final SearchLabPatientsByTypeParams params;
  LabRequestsBloc_SearchLabPatientsByTypeEvent({required this.params});
}

class LabRequestsBloc_CreateLabRequestEvent extends LabRequestsBloc_Events {
  final LabRequestEntity request;
  LabRequestsBloc_CreateLabRequestEvent({required this.request});
}

class LabRequestsBloc_UpdateLabRequestEvent extends LabRequestsBloc_Events {
  final LabRequestEntity request;
  LabRequestsBloc_UpdateLabRequestEvent({required this.request});
}

class LabRequestsBloc_GetPatientsRequestsEvent extends LabRequestsBloc_Events {
  final int patientId;
  LabRequestsBloc_GetPatientsRequestsEvent({required this.patientId});
}

class LabRequestsBloc_GetRequestEvent extends LabRequestsBloc_Events {
  final int id;
  LabRequestsBloc_GetRequestEvent({required this.id});
}

class LabRequestsBloc_DeleteRequestEvent extends LabRequestsBloc_Events {
  final int id;
  LabRequestsBloc_DeleteRequestEvent({required this.id});
}

class LabRequestsBloc_FinishTaskEvent extends LabRequestsBloc_Events {
  final FinishTaskParams params;
  LabRequestsBloc_FinishTaskEvent({required this.params});
}

class LabRequestsBloc_MarkRequestAsDoneEvent extends LabRequestsBloc_Events {
  final MarkRequestAsDoneParams params;
  LabRequestsBloc_MarkRequestAsDoneEvent({required this.params});
}

class LabRequestsBloc_AddToMyTasksEvent extends LabRequestsBloc_Events {
  final int id;
  LabRequestsBloc_AddToMyTasksEvent({required this.id});
}

class LabRequestsBloc_AssignTaskToATechnicianEvent extends LabRequestsBloc_Events {
  final AssignTaskToTechnicianParams params;
  LabRequestsBloc_AssignTaskToATechnicianEvent({required this.params});
}

class LabRequestsBloc_GetLabItemDetailsEvent extends LabRequestsBloc_Events {
  final int id;
  LabRequestsBloc_GetLabItemDetailsEvent({required this.id});
}

class LabRequestsBloc_ConsumeLabItemEvent extends LabRequestsBloc_Events {
  final ConsumeLabItemParams params;
  LabRequestsBloc_ConsumeLabItemEvent({required this.params});
}

class LabRequestsBloc_GetLabRequestReceiptEvent extends LabRequestsBloc_Events {
  final int id;
  LabRequestsBloc_GetLabRequestReceiptEvent({required this.id});
}

class LabRequestsBloc_PayRequestEvent extends LabRequestsBloc_Events {
  final int id;
  LabRequestsBloc_PayRequestEvent({required this.id});
}
