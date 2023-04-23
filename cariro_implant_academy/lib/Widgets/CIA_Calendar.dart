import 'package:cariro_implant_academy/Models/VisitsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../API/LoadinAPI.dart';
import '../API/PatientAPI.dart';
import '../Constants/Controllers.dart';
import '../Helpers/CIA_DateConverters.dart';
import '../Models/API_Response.dart';
import '../Models/DTOs/DropDownDTO.dart';
import '../Models/PatientInfo.dart';
import 'CIA_DropDown.dart';
import 'CIA_FutureBuilder.dart';
import 'CIA_PopUp.dart';
import 'CIA_TextFormField.dart';
import 'SnackBar.dart';

class CIA_Calendar extends StatefulWidget {
  CIA_Calendar({
    Key? key,
    this.patientID,
    this.onNewVisit,
    required this.dataSource,
    this.getForDoctor = false,
  }) : super(key: key);

  VisitsCalendarDataSource dataSource;
  int? patientID;
  bool getForDoctor;
  Function(VisitsModel newVisit)? onNewVisit;

  @override
  State<CIA_Calendar> createState() => _CIA_CalendarState();
}

class _CIA_CalendarState extends State<CIA_Calendar> {
  CalendarController controller = CalendarController();
  PatientInfoModel patient = PatientInfoModel();

  @override
  Widget build(BuildContext context) {
    return CIA_FutureBuilder(
      loadFunction: () async {
        if (widget.patientID != null)
          await PatientAPI.GetPatientData(widget.patientID!).then((value) {
            if (value.statusCode == 200)
              patient = value.result as PatientInfoModel;
          });
        await widget.dataSource.loadData(forDoctor: widget.getForDoctor);
        widget.dataSource = VisitsCalendarDataSource(source: widget.dataSource.appointments as List<VisitsModel>);
        return API_Response(statusCode: 200);
      }(),
      onSuccess: (data) {
        return SfCalendar(
          controller: controller,
          view: CalendarView.month,
          dataSource: widget.dataSource,
          allowedViews: [
            CalendarView.schedule,
            CalendarView.day,
            CalendarView.week,
            CalendarView.month
          ],
          onTap: (element) {
            if (element.targetElement == CalendarElement.calendarCell &&
                controller.view != CalendarView.month) {
              VisitsModel newVisit = VisitsModel(
                  from: element.date.toString(),
                  to: element.date!.add(Duration(minutes: 15)).toString(),
                  patientId: patient.id,
                  reservationTime: element.date.toString(),
                  doctorName: !widget.getForDoctor
                      ? null
                      : siteController.getUser().name,
                  doctorId: !widget.getForDoctor
                      ? null
                      : siteController.getUser().idInt,
                  patientName: patient.name);

              CIA_ShowPopUp(
                context: context,
                onSave: () async {
                  var res = await PatientAPI.ScheduleVisit(newVisit);
                  if (res.statusCode == 200) {
                    if(widget.onNewVisit!=null) widget.onNewVisit!(newVisit);
                     await widget.dataSource.loadData(forDoctor: widget.getForDoctor);
                     SchedulerBinding.instance
                         .addPostFrameCallback((Duration duration) {
                       widget.dataSource.notifyListeners(
                           CalendarDataSourceAction.add, widget.dataSource.appointments!);
                     });
                  }
                },
                child: StatefulBuilder(
                  builder: (context, setState) {
                    newVisit.reservationTime = newVisit.from;
                    return Column(
                      children: [
                        CIA_TextFormField(
                            label: "Title",
                            controller: TextEditingController(
                                text: "(No Subject)"),
                          onChange: (value) {
                            newVisit.title = value;
                          },

                        ),
                        CIA_TextFormField(
                            label: "Date",
                            enabled: widget.patientID == null,
                            controller: TextEditingController(
                                text: CIA_DateConverters.simpleFormatDateOnly(
                                    newVisit.from))),
                        Row(
                          children: [
                            Expanded(
                                child: CIA_TextFormField(
                                    label: "From",
                                    controller: TextEditingController(
                                        text: CIA_DateConverters
                                            .simpleFormatTimeOnly(
                                                newVisit.from)))),
                            Expanded(
                                child: Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      var d = DateFormat("yyyy-MM-dd H:mm:SS")
                                          .parse(newVisit.from!);
                                      d = d.add(Duration(minutes: 15));
                                      if (!d.isBefore(
                                          DateFormat("yyyy-MM-dd H:mm:SS")
                                              .parse(newVisit.to!))) {
                                        ShowSnackBar(
                                            isSuccess: false,
                                            title: "Failed",
                                            message:
                                                "End time must be after start time");
                                        return;
                                      }

                                      newVisit.from = d.toString();
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      size: 20,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      var d = DateFormat("yyyy-MM-dd H:mm:SS")
                                          .parse(newVisit.from!);
                                      d = d.subtract(Duration(minutes: 15));
                                      newVisit.from = d.toString();
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.remove, size: 20)),
                              ],
                            )),
                            Expanded(
                                child: CIA_TextFormField(
                                    label: "To",
                                    controller: TextEditingController(
                                        text: CIA_DateConverters
                                            .simpleFormatTimeOnly(
                                                newVisit.to)))),
                            Expanded(
                                child: Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      var d = DateFormat("yyyy-MM-dd H:mm:SS")
                                          .parse(newVisit.to!);
                                      d = d.add(Duration(minutes: 15));
                                      newVisit.to = d.toString();
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.add, size: 20)),
                                IconButton(
                                    onPressed: () {
                                      var d = DateFormat("yyyy-MM-dd H:mm:SS")
                                          .parse(newVisit.to!);
                                      d = d.subtract(Duration(minutes: 15));
                                      if (!d.isAfter(
                                          DateFormat("yyyy-MM-dd H:mm:SS")
                                              .parse(newVisit.from!))) {
                                        ShowSnackBar(
                                            isSuccess: false,
                                            title: "Failed",
                                            message:
                                                "End time must be after start time");
                                        return;
                                      }

                                      newVisit.to = d.toString();
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
                        CIA_TextFormField(
                          onTap: () {
                            if (widget.patientID == null) {
                              CIA_PopUpSearch(
                                searchFunction: (String) async {
                                  return await PatientAPI.QuickSearch(String);
                                },
                                title: "Search Patients",
                                context: context,
                                onChoose: (selected) {
                                  newVisit.patientName = selected.name!;
                                  newVisit.patientId = selected.id;
                                  setState(() {});
                                },
                              );
                            }
                          },
                          enabled: widget.patientID == null,
                          label: "Patient Name",
                          controller:
                              TextEditingController(text: newVisit.patientName),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CIA_DropDownSearch(
                          selectedItem: !widget.getForDoctor
                              ? null
                              : DropDownDTO(
                                  name: siteController.getUser().name,
                                  id: siteController.getUser().idInt),
                          asyncItems: !widget.getForDoctor
                              ? LoadinAPI.LoadInstructorsAndAssistants
                              : null,
                          enabled: !widget.getForDoctor,
                          label: "Doctor",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CIA_DropDownSearch(
                          asyncItems: () async {
                            return await LoadinAPI.GetAvailableRooms(
                                CIA_DateConverters.fromDateTimeToBackend(
                                    newVisit.from!),
                                CIA_DateConverters.fromDateTimeToBackend(
                                    newVisit.to!));
                          },
                          label: "Room",
                          emptyString: "No room available at this time slot",
                        ),
                      ],
                    );
                  },
                ),
              );
            }
          },
          showCurrentTimeIndicator: true,
          monthViewSettings: const MonthViewSettings(
              showAgenda: true,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              showTrailingAndLeadingDates: true,
              appointmentDisplayCount: 5),
        );
      },
    );
  }
}
