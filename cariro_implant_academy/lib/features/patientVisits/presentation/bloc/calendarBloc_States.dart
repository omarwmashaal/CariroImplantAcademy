import 'dart:ui';

import 'package:cariro_implant_academy/features/patientVisits/domain/entity/roomEntity.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/entity/visitEntity.dart';
import 'package:equatable/equatable.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

abstract class CalendarBloc_States extends Equatable {}

class CalendarBloc_InitialState extends CalendarBloc_States {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CalendarBloc_CreatingNewSchedule extends CalendarBloc_States {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CalendarBloc_LoadingSchedules extends CalendarBloc_States {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CalendarBloc_LoadingRooms extends CalendarBloc_States {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CalendarBloc_LoadingSchedulesError extends CalendarBloc_States {
  final String message;

  CalendarBloc_LoadingSchedulesError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class CalendarBloc_LoadingRoomsError extends CalendarBloc_States {
  final String message;

  CalendarBloc_LoadingRoomsError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class CalendarBloc_CreatingScheduleError extends CalendarBloc_States {
  final String message;

  CalendarBloc_CreatingScheduleError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class CalendarBloc_LoadedSuccessfully extends CalendarBloc_States {
  final List<VisitEntity> visits;
  final VisitsCalendarDataSource dataSource;

  CalendarBloc_LoadedSuccessfully({
    required this.visits,
    required this.dataSource,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        visits,
        dataSource,
      ];
}

class CalendarBloc_LoadedRoomsSuccessfully extends CalendarBloc_States {
  final List<RoomEntity> rooms;

  CalendarBloc_LoadedRoomsSuccessfully({
    required this.rooms,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        rooms,
      ];
}

class CalendarBloc_CreatedNewScheduleSuccessfully extends CalendarBloc_States {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VisitsCalendarDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  VisitsCalendarDataSource({List<VisitEntity>? source}) {
    appointments = (source ?? []) as List<VisitEntity>;

  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(appointments![index].from!).toLocal();
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.parse(appointments![index].to!).toLocal();
  }

  @override
  String getSubject(int index) {
    return appointments![index].title ?? "";
  }

  @override
  Color getColor(int index) {
    return (appointments![index] as VisitEntity).room!.color!;
  }
}
