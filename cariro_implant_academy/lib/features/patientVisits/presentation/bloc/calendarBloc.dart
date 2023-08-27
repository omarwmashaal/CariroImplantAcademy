import 'dart:ui';

import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/entity/visitEntity.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/usecases/getAvailableRoomsUsecase.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/usecases/getMySchedulesUseCase.dart';
import 'package:cariro_implant_academy/features/patientVisits/presentation/bloc/calendarBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientVisits/presentation/bloc/calendarBloc_States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../domain/usecases/getAllSchedulesUseCase.dart';
import '../../domain/usecases/getRoomsUsecase.dart';
import '../../domain/usecases/scheduleNewVisit.dart';

class CalendarBloc extends Bloc<CalendarBloc_Events, CalendarBloc_States> {
  final GetAllSchedulesUseCase getAllSchedulesUseCase;
  final GetMySchedulesUseCase getMySchedulesUseCase;
  final GetRoomsUseCase getRoomsUseCase;
  final GetAvailableRoomsUseCase getAvailableRoomsUseCase;
  final ScheduleNewVisitUseCase scheNewVisitUseCase;
  CalendarBloc({
    required this.getAllSchedulesUseCase,
    required this.getMySchedulesUseCase,
    required this.getRoomsUseCase,
    required this.getAvailableRoomsUseCase,
    required this.scheNewVisitUseCase,
  }) : super(CalendarBloc_InitialState()) {
    on<CalendarBloc_GetAllSchedules>(
      (event, emit) async {
        emit(CalendarBloc_LoadingSchedules());
        final result = await getAllSchedulesUseCase(event.month);
        result.fold(
          (l) => emit(CalendarBloc_LoadingSchedulesError(message: l.message ?? "")),
          (r) => emit(CalendarBloc_LoadedSuccessfully(visits: r, dataSource: VisitsCalendarDataSource(source: r))),
        );
      },
    );
    on<CalendarBloc_GetMySchedules>(
      (event, emit) async {
        emit(CalendarBloc_LoadingSchedules());
        final result = await getMySchedulesUseCase(event.month);
        result.fold(
          (l) => emit(CalendarBloc_LoadingSchedulesError(message: l.message ?? "")),
          (r) => emit(CalendarBloc_LoadedSuccessfully(visits: r, dataSource: VisitsCalendarDataSource(source: r))),
        );
      },
    );
    on<CalendarBloc_GetRooms>(
      (event, emit) async {
        emit(CalendarBloc_LoadingRooms());
        final result = await getRoomsUseCase(NoParams());
        result.fold(
          (l) => emit(CalendarBloc_LoadingRoomsError(message: l.message ?? "")),
          (r) => emit(CalendarBloc_LoadedRoomsSuccessfully(rooms: r)),
        );
      },
    );
    on<CalendarBloc_GetAvailableRooms>(
      (event, emit) async {
        emit(CalendarBloc_LoadingRooms());
        final result = await getAvailableRoomsUseCase(event.params);
        result.fold(
          (l) => emit(CalendarBloc_LoadingRoomsError(message: l.message ?? "")),
          (r) => emit(CalendarBloc_LoadedRoomsSuccessfully(rooms: r)),
        );
      },
    );
    on<CalendarBloc_ScheduleNewVisit>(
      (event, emit) async {
        emit(CalendarBloc_CreatingNewSchedule());
        final result = await scheNewVisitUseCase(event.newVisit);
        result.fold(
          (l) => emit(CalendarBloc_CreatingScheduleError(message: l.message ?? "")),
          (r) => emit(CalendarBloc_CreatedNewScheduleSuccessfully()),
        );
      },
    );
  }
}
