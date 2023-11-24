import 'package:cariro_implant_academy/API/SettingsAPI.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/roomEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getAvailableRoomsUsecase.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/calendarBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/calendarBloc_Events.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/calendarBloc_States.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc.dart';
import 'package:cariro_implant_academy/features/patient/presentation/bloc/createOrViewPatientBloc_Events.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../Constants/Controllers.dart';
import '../../../../Controllers/SiteController.dart';
import '../../../../Helpers/CIA_DateConverters.dart';
import '../../../../Widgets/CIA_DropDown.dart';
import '../../../../Widgets/CIA_PopUp.dart';
import '../../../../Widgets/CIA_TextFormField.dart';
import '../../../../Widgets/SnackBar.dart';
import '../../../../core/injection_contianer.dart';
import '../bloc/createOrViewPatientBloc_States.dart';

class _getx extends GetxController {
  static RxBool showAddButton = false.obs;
}

class CalendarWidget extends StatefulWidget {
  CalendarWidget({
    Key? key,
    this.patientID,
    this.onNewVisit,
    this.getForDoctor = false,
    this.getAllSchedules = false,
  }) : super(key: key);

  int? patientID;
  bool getForDoctor;
  bool getAllSchedules;

  Function(VisitEntity newVisit)? onNewVisit;

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarController controller = CalendarController();
  PatientInfoEntity patient = PatientInfoEntity();
  int currentMonth = 0;
  List<RoomEntity> rooms = [];
  bool loadAll = false;
  CalendarTapDetails? globalElement;
  late CalendarBloc bloc;
  late CreateOrViewPatientBloc patientBloc;
  late Function(CalendarTapDetails element, bool buttonClicked) onTapFunction;
  late VisitEntity newVisit;

  @override
  void initState() {
    currentMonth = DateTime.now().month;
    bloc = BlocProvider.of<CalendarBloc>(context);
    patientBloc = BlocProvider.of<CreateOrViewPatientBloc>(context);

    if (widget.patientID != null) patientBloc.add(GetPatientInfoEvent(id: widget.patientID!));

    if (widget.getAllSchedules) {
      loadAll = true;
      bloc.add(CalendarBloc_GetAllSchedules(month: DateTime.now().month));
    } else
      bloc.add(CalendarBloc_GetMySchedules(month: DateTime.now().month));
    bloc.add(CalendarBloc_GetRooms());

    onTapFunction = (element, buttonClicked) {
      globalElement = element;
      _getx.showAddButton.value = true;
      if (buttonClicked || element.targetElement == CalendarElement.calendarCell && controller.view != CalendarView.month) {
        newVisit = VisitEntity(
            title: "(No Subject)",
            from: element.date,
            to: element.date!.add(Duration(minutes: 15)),
            patientId: patient.id,
            reservationTime: element.date,
            doctorName: !widget.getForDoctor ? null : siteController.getUserName(),
            doctorId: !widget.getForDoctor ? null : sl<SharedPreferences>().getInt("userid"),
            patientName: patient.name);

        CIA_ShowPopUp(
          context: context,
          onSave: () async {
            bloc.add(CalendarBloc_ScheduleNewVisit(newVisit: newVisit));
            return false;
          },
          child: StatefulBuilder(
            builder: (context, setState) {
              newVisit.reservationTime = newVisit.from;
              return Column(
                children: [
                  CIA_TextFormField(
                    label: "Title",
                    controller: TextEditingController(text: "(No Subject)"),
                    onChange: (value) {
                      newVisit.title = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CIA_TextFormField(
                      label: "Date",
                      enabled: widget.patientID == null,
                      controller: TextEditingController(text: CIA_DateConverters.simpleFormatDateOnly(newVisit.from))),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {},
                        child: CIA_TextFormField(
                            onTap: () async {
                              var time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                              if (time != null)
                                newVisit.from = DateTime(
                                  newVisit.from!.year,
                                  newVisit.from!.month,
                                  newVisit.from!.day,
                                  time!.hour,
                                  time!.minute,
                                );
                              setState(() {});
                            },
                            enabled: false,
                            label: "From",
                            controller: TextEditingController(text: CIA_DateConverters.simpleFormatTimeOnly(newVisit.from))),
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                var d = newVisit.from!;
                                d = d.add(Duration(minutes: 15));
                                if (!d.isBefore(newVisit.to!)) {
                                  ShowSnackBar(context, isSuccess: false, title: "Failed", message: "End time must be after start time");
                                  return;
                                }

                                newVisit.from = d;
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.add,
                                size: 20,
                              )),
                          IconButton(
                              onPressed: () {
                                var d = newVisit.from!;
                                d = d.subtract(Duration(minutes: 15));
                                newVisit.from = d;
                                setState(() {});
                              },
                              icon: Icon(Icons.remove, size: 20)),
                        ],
                      )),
                      Expanded(
                        child: CIA_TextFormField(
                          enabled: false,
                          onTap: () async {
                            var time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                            if (time != null)
                              newVisit.to = DateTime(
                                newVisit.to!.year,
                                newVisit.to!.month,
                                newVisit.to!.day,
                                time!.hour,
                                time!.minute,
                              );
                            setState(() {});
                          },
                          label: "To",
                          controller: TextEditingController(
                            text: CIA_DateConverters.simpleFormatTimeOnly(newVisit.to),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                var d = newVisit.to!;
                                d = d.add(Duration(minutes: 15));
                                newVisit.to = d;
                                setState(() {});
                              },
                              icon: Icon(Icons.add, size: 20)),
                          IconButton(
                              onPressed: () {
                                var d = newVisit.to!;
                                d = d.subtract(Duration(minutes: 15));
                                if (!d.isAfter(newVisit.from!)) {
                                  ShowSnackBar(context, isSuccess: false, title: "Failed", message: "End time must be after start time");
                                  return;
                                }

                                newVisit.to = d;
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.remove,
                                size: 20,
                              )),
                        ],
                      )),
                    ],
                  ),
                  BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(builder: (context, state) {
                    if (state is LoadedPatientInfoState) {
                      newVisit.patientName = state.patient.name;
                      newVisit.patientId = state.patient.id;
                    }
                    return CIA_TextFormField(
                      onTap: () {
                        if (widget.patientID == null)
                          CIA_ShowPopUp(
                              context: context,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CIA_TextFormField(
                                    label: "Search Patients",
                                    controller: TextEditingController(),
                                    onChange: (value) async {
                                      patientBloc.add(SearchPatientsEvent(query: value));
                                    },
                                  ),
                                  SizedBox(
                                    height: 400,
                                    child: BlocBuilder<CreateOrViewPatientBloc, CreateOrViewPatientBloc_State>(
                                      buildWhen: (previous, current) => current is LoadedPatients,
                                      builder: (context, state) {
                                        return ListView.builder(
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              onTap: () {
                                                if (state is LoadedPatients) {
                                                  newVisit.patientName = state.patients[index].name;
                                                  newVisit.patientId = state.patients[index].id;
                                                  dialogHelper.dismissSingle(context);
                                                  setState(() {});
                                                }
                                              },
                                              title: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state is LoadedPatients ? (state as LoadedPatients).patients[index].name ?? "" : "",
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Divider()
                                                ],
                                              ),
                                            );
                                          },
                                          itemCount: state is LoadedPatients ? (state as LoadedPatients).patients.length : 0,
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ));
                      },
                      enabled: widget.patientID == null,
                      label: "Patient Name",
                      controller: TextEditingController(text: newVisit.patientName),
                    );
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                    searchParams: LoadUsersEnum.assistants,
                    asyncUseCase: sl<LoadUsersUseCase>(),
                    selectedItem: !widget.getForDoctor
                        ? null
                        : BasicNameIdObjectEntity(
                            name: siteController.getUserName() ?? "",
                            id: sl<SharedPreferences>().getInt("userid") ?? 0,
                          ),
                    //asyncItems: !widget.getForDoctor ? LoadinAPI.LoadInstructorsAndAssistants : null,
                    label: "Doctor",
                    onSelect: (value) => newVisit.doctorId = value.id,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CIA_DropDownSearchClean(
                    asyncItems: () async {
                      var result = await sl<GetAvailableRoomsUseCase>()(GetAvailableRoomsParams(
                        from: newVisit.from!,
                        to: newVisit.to!,
                      ));
                      return result.fold(
                          (l) => [],
                          (r) => r
                              .map((e) => DropDownDTO(
                                    id: e.id,
                                    name: e.name,
                                  ))
                              .toList());
                    },
                    label: "Room",
                    onSelect: (value) {
                      newVisit.roomId = value.id;
                    },
                    emptyString: "No room available at this time slot",
                  ),
                  BlocBuilder<CalendarBloc, CalendarBloc_States>(
                    builder: (context, state) {
                      String error = "";
                      if (state is CalendarBloc_CreatingScheduleError) error = state.message;
                      return Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      );
                    },
                  )
                ],
              );
            },
          ),
        );
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarBloc, CalendarBloc_States>(
      listener: (context, state) {
        if (state is CalendarBloc_LoadedRoomsSuccessfully)
          rooms = state.rooms;
        else if (state is CalendarBloc_CreatedNewScheduleSuccessfully) {
          dialogHelper.dismissSingle(context);
          if (loadAll)
            bloc.add(CalendarBloc_GetAllSchedules(month: currentMonth));
          else
            bloc.add(CalendarBloc_GetMySchedules(month: currentMonth));

          if (widget.onNewVisit != null) widget.onNewVisit!(newVisit);
        }
      },
      buildWhen: (previous, current) =>
          current is CalendarBloc_LoadingSchedules || current is CalendarBloc_LoadingSchedulesError || current is CalendarBloc_LoadedSuccessfully,
      builder: (context, state) {
        if (state is CalendarBloc_LoadingSchedules)
          return LoadingWidget();
        else if (state is CalendarBloc_LoadingSchedulesError)
          return BigErrorPageWidget(message: state.message);
        else if (state is CalendarBloc_LoadedSuccessfully) {
          VisitsCalendarDataSource dataSource = state.dataSource;
          return Column(
            children: [
              BlocBuilder<CalendarBloc, CalendarBloc_States>(
                  buildWhen: (previous, current) => current is CalendarBloc_LoadedRoomsSuccessfully,
                  builder: (context, state) {
                    return Row(
                      children: () {
                        List<Widget> r = [];
                        if (!widget.getAllSchedules)
                          r.add(
                            CIA_MultiSelectChipWidget(
                              onChange: (item, isSelected) {
                                loadAll = isSelected;
                                if (isSelected)
                                  bloc.add(CalendarBloc_GetAllSchedules(month: DateTime.now().month));
                                else
                                  bloc.add(CalendarBloc_GetMySchedules(month: DateTime.now().month));
                              },
                              labels: [
                                CIA_MultiSelectChipWidgeModel(label: "Get All Schedules", isSelected: loadAll),
                              ],
                            ),
                          );
                        r.add(SizedBox(width: 10));
                        r.addAll(rooms
                            .map((e) => Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        color: e.color!,
                                      ),
                                      SizedBox(width: 5),
                                      FormTextValueWidget(
                                        text: e.name ?? "",
                                      ),
                                      SizedBox(width: 5),
                                      VerticalDivider(),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                ))
                            .toList());
                        r.add(Container(
                          height: 40,
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 5),
                              FormTextValueWidget(
                                text: "Unspecified",
                              ),
                              SizedBox(width: 5),
                              VerticalDivider(),
                              SizedBox(width: 5),
                            ],
                          ),
                        ));
                        r.add(Obx(() => Visibility(
                              visible: _getx.showAddButton.value,
                              child: CIA_SecondaryButton(
                                  label: "New",
                                  onTab: () {
                                    if (globalElement != null) onTapFunction(globalElement!, true);
                                  }),
                            )));
                        return r;
                      }(),
                    );
                  }),
              FormTextKeyWidget(text: loadAll ? "All Schedules" : "Your Schedules only"),
              Expanded(
                child: SfCalendar(
                  key: GlobalKey(),
                  controller: controller,
                  view: CalendarView.month,
                  allowViewNavigation: true,
                  showNavigationArrow: true,
                  dataSource: dataSource,
                  onViewChanged: (viewChangedDetails) {
                    Map<int, int> monthsOccurance = Map<int, int>();
                    viewChangedDetails.visibleDates.forEach((element) {
                      if (monthsOccurance.containsKey(element.month)) {
                        monthsOccurance[element.month] = monthsOccurance[element.month]! + 1;
                      } else {
                        monthsOccurance[element.month] = 1;
                      }
                    });
                    int tempcurrentMonth = 0;
                    int occurance = 0;
                    for (var m in monthsOccurance.keys) {
                      if ((monthsOccurance[m]!) > occurance) {
                        occurance = monthsOccurance[m]!;
                        tempcurrentMonth = m!;
                      }
                      ;
                    }

                    if (tempcurrentMonth != currentMonth) {
                      currentMonth = tempcurrentMonth;
                      if (loadAll) {
                        bloc.add(CalendarBloc_GetAllSchedules(month: currentMonth));
                      } else
                        bloc.add(CalendarBloc_GetMySchedules(month: currentMonth));
                    }
                  },
                  allowedViews: [CalendarView.schedule, CalendarView.day, CalendarView.week, CalendarView.month],
                  onTap: (element) => onTapFunction(element, false),
                  showCurrentTimeIndicator: true,
                  monthViewSettings: const MonthViewSettings(
                      showAgenda: true,
                      appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                      showTrailingAndLeadingDates: true,
                      appointmentDisplayCount: 5),
                ),
              ),
            ],
          );
        } else
          return Container();
      },
    );
  }
}
