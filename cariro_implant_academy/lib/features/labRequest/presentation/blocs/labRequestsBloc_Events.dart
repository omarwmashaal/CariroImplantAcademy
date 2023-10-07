import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/usecases/searchUsersByWorkPlaceUseCase.dart';

import '../../domain/usecases/getAllRequestsUseCase.dart';
import '../../domain/usecases/searchLabPatientsByTypeUseCase.dart';

abstract class LabRequestsBloc_Events {}

class LabRequestsBloc_GetTodaysRequestsEvent extends LabRequestsBloc_Events{
  final GetAllRequestsParams getAllRequestsParams;
  LabRequestsBloc_GetTodaysRequestsEvent({required this.getAllRequestsParams});
}
class LabRequestsBloc_CreateLabCustomerEvent extends LabRequestsBloc_Events{
  final UserEntity customer;
  LabRequestsBloc_CreateLabCustomerEvent({required this.customer});
}
class LabRequestsBloc_SearchLabPatientsByTypeEvent extends LabRequestsBloc_Events{
  final SearchLabPatientsByTypeParams params;
  LabRequestsBloc_SearchLabPatientsByTypeEvent({required this.params});
}
class LabRequestsBloc_CreateLabRequestEvent extends LabRequestsBloc_Events{
  final LabRequestEntity request;
  LabRequestsBloc_CreateLabRequestEvent({required this.request});
}