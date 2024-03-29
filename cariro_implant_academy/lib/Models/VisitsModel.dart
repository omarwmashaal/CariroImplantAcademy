import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../API/PatientAPI.dart';
import '../API/UserAPI.dart';
import 'API_Response.dart';
import 'CIA_RoomModel.dart';
import 'PatientInfo.dart';

class VisitsModel {
  int? id;
  String? status;
  String? reservationTime;
  String? realVisitTime;
  String? entersClinicTime;
  String? leaveTime;
  String? from;
  String? to;
  String? title;
  CIA_RoomModel? room;
  int? roomId;
  String? doctorName;
  int? doctorId;
  String? treatment;
  int? patientId;
  String? patientName;
  String? duration;

  VisitsModel(
      {this.id,
      this.from,
      this.title,
      this.to,
      this.roomId,
      this.status,
      this.reservationTime,
      this.realVisitTime,
      this.entersClinicTime,
      this.leaveTime,
      this.doctorName,
      this.doctorId,
      this.patientId,
      this.room,
      this.patientName});

  VisitsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];

    treatment = json['treatment'];
    reservationTime = CIA_DateConverters.fromBackendToDateTime(json['reservationTime']);
    realVisitTime = CIA_DateConverters.fromBackendToDateTime(json['realVisitTime']);
    entersClinicTime = CIA_DateConverters.fromBackendToDateTime(json['entersClinicTime']);
    leaveTime = CIA_DateConverters.fromBackendToDateTime(json['leaveTime']);
    doctorName = json['doctorName'];
    doctorId = json['doctorId'];
    from = json['from'];
    to = json['to'];
    title = json['title'];
    roomId = json['roomId'] ?? 0;
    patientId = json['patientId'] ?? 0;
    patientName = json['patientName'] ?? "";
    duration = CIA_DateConverters.fromBackendToTimeSpan(json['duration']) ?? "";
    room = json['room'] != null ? CIA_RoomModel.fromJson(json['room'] as Map<String, dynamic>) : CIA_RoomModel();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['status'] = status;
    data['reservationTime'] = CIA_DateConverters.fromDateTimeToBackend(reservationTime);
    data['realVisitTime'] = CIA_DateConverters.fromDateTimeToBackend(realVisitTime);
    data['entersClinicTime'] = CIA_DateConverters.fromDateTimeToBackend(entersClinicTime);
    data['leaveTime'] = CIA_DateConverters.fromDateTimeToBackend(leaveTime);
    data['doctorName'] = doctorName;
    data['doctorId'] = doctorId;
    data['roomId'] = roomId;
    data['from'] = CIA_DateConverters.fromDateTimeToBackend(from);
    data['to'] = CIA_DateConverters.fromDateTimeToBackend(to);
    data['title'] = title;
    data['patientId'] = patientId;
    return data;
  }
}
/*
class VisitDataSource extends DataGridSource {
  List<VisitsModel> models = <VisitsModel>[];
  bool sessions;
  List<String> columns = [
    "Patient",
    "Status",
    "Reservation Time",
    "Real Visit Time",
    "Enters Clinic Time",
    "Leave Time",
    "Duration",
    "Doctor Name",
    "Treatment",
  ];

  /// Creates the visit data source class with required details.
  VisitDataSource({this.sessions=false}) {
    init();
  }

  init() {
    if(sessions)
      {
       columns = [
          "Patient",
       //   "Status",
        //  "Reservation Time",
          "Real Visit Time",
          "Enters Clinic Time",
          "Leave Time",
          "Duration",
          "Doctor Name",
          "Treatment",
        ];
        _visitData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
          DataGridCell<String>(columnName: 'Patient', value: e.patientName??""),
         // DataGridCell<String>(columnName: 'Status', value: e.status??""),
         // DataGridCell<String>(columnName: 'Reservation Time', value: e.reservationTime??""),
          DataGridCell<String>(columnName: 'Real Visit Time', value: e.realVisitTime??""),
          DataGridCell<String>(columnName: 'Enters Clinic Time', value: e.entersClinicTime??""),
          DataGridCell<String>(columnName: 'Leave Time', value: e.leaveTime??""),
          DataGridCell<String>(columnName: 'Duration', value: e.duration??""),
          DataGridCell<String>(columnName: 'Doctor Name', value: e.doctorName??""),
          DataGridCell<String>(columnName: 'Treatment', value: e.treatment??""),
        ]))
            .toList();
      }
    else
      { columns = [
        "Patient",
        "Status",
        "Reservation Time",
        "Real Visit Time",
        "Enters Clinic Time",
        "Leave Time",
        "Duration",
        "Doctor Name",
        "Treatment",
      ];
        _visitData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
          DataGridCell<String>(columnName: 'Patient', value: e.patientName??""),
          DataGridCell<String>(columnName: 'Status', value: e.status??""),
          DataGridCell<String>(columnName: 'Reservation Time', value: e.reservationTime??""),
          DataGridCell<String>(columnName: 'Real Visit Time', value: e.realVisitTime??""),
          DataGridCell<String>(columnName: 'Enters Clinic Time', value: e.entersClinicTime??""),
          DataGridCell<String>(columnName: 'Leave Time', value: e.leaveTime??""),
          DataGridCell<String>(columnName: 'Duration', value: e.duration??""),
          DataGridCell<String>(columnName: 'Doctor Name', value: e.doctorName??""),
          DataGridCell<String>(columnName: 'Treatment', value: e.treatment??""),
        ]))
            .toList();
      }

  }

  List<DataGridRow> _visitData = [];

  @override
  List<DataGridRow> get rows => _visitData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          e.value == null ? "" : e.value.toString(),
          style: TextStyle(fontSize: 12),
        ),
      );
    }).toList());
  }

  Future<bool> loadData({int? id}) async {
    late API_Response response;
    if (id != null)
      response = await PatientAPI.GetVisitsLogs(id!);
    else
      response = await PatientAPI.GetAllSchedules();
    if (response.statusCode == 200) {
      models = response.result as List<VisitsModel>;
    }
    init();
    notifyListeners();

    return true;
  }

  Future<Duration> loadSessions({required int id, String? from, String? to}) async {
    late API_Response response;

      response = await UserAPI.GetSessionsDurations(id: id, from: from, to: to);

    if (response.statusCode == 200) {
      models = response.result as List<VisitsModel>;
    }
    var duration = Duration(seconds: 0);
    for(var m in models)
      {
        var temp = CIA_DateConverters.parseDuration(m.duration??"00:00:00");
        duration+= temp;
      }
    init();
    notifyListeners();

    return duration;
  }

  Future<bool> setData(List<VisitsModel> model) async {
    models = model;
    init();
    notifyListeners();
    return true;
  }
}
*/
class VisitsCalendarDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  VisitsCalendarDataSource({List<VisitsModel>? source}) {
    appointments = (source ?? []) as List<VisitsModel>;
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
    return (appointments![index] as VisitsModel).room!.color!;
  }

  loadData({bool forDoctor = false}) async {
    API_Response res = API_Response();
    if (forDoctor)
      res = await PatientAPI.GetScheduleForDoctor();
    else
      res = await PatientAPI.GetAllSchedules();
    //notifyListeners(CalendarDataSourceAction.resetResource, res.result as List<VisitsModel>);
    //appointments = <VisitsModel>[];
    appointments = res.result as List<VisitsModel>;
    // notifyListeners(CalendarDataSourceAction.resetResource, res.result as List<VisitsModel>);
    //notifyListeners(CalendarDataSourceAction.removeResource, []);
    //notifyListeners(CalendarDataSourceAction.add, res.result as List<VisitsModel>);
    notifyListeners(CalendarDataSourceAction.reset, appointments!);
    return true;
  }
}
