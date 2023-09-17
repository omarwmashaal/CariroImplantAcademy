import 'package:cariro_implant_academy/features/patient/domain/entities/roomEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getAvailableRoomsUsecase.dart';
import 'package:equatable/equatable.dart';

abstract class CalendarBloc_Events extends Equatable{}

class CalendarBloc_GetAllSchedules extends CalendarBloc_Events{
  final int month;
  CalendarBloc_GetAllSchedules({required this.month});
  @override
  // TODO: implement props
  List<Object?> get props => [month];

}
class CalendarBloc_GetMySchedules extends CalendarBloc_Events{
  final int month;
  CalendarBloc_GetMySchedules({required this.month});
  @override
  // TODO: implement props
  List<Object?> get props => [month];

}
class CalendarBloc_GetAllVisits extends CalendarBloc_Events{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class CalendarBloc_GetPatientVisits extends CalendarBloc_Events{
  final int id;
  CalendarBloc_GetPatientVisits({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [id];

}


class CalendarBloc_GetRooms extends CalendarBloc_Events{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class CalendarBloc_GetAvailableRooms extends CalendarBloc_Events{
  final GetAvailableRoomsParams params;
  CalendarBloc_GetAvailableRooms({required this.params});
  @override
  // TODO: implement props
  List<Object?> get props => [params];

}
class CalendarBloc_ScheduleNewVisit extends CalendarBloc_Events{
  final VisitEntity newVisit;
  CalendarBloc_ScheduleNewVisit({required this.newVisit});
  @override
  List<Object?> get props => [newVisit];

}