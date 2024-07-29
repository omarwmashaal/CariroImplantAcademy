import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/roomEntity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class VisitEntity extends Equatable {
  int? id;
  String? secondaryId;
  String? status;
  DateTime? reservationTime;
  DateTime? realVisitTime;
  DateTime? entersClinicTime;
  DateTime? leaveTime;
  DateTime? from;
  DateTime? to;
  String? title;
  RoomEntity? room;
  int? roomId;
  String? doctorName;
  int? doctorId;
  int? changeRequestId;
  String? treatment;
  int? patientId;
  String? patientName;
  String? duration;
  String? notes;
  VisitEntity? changeRequest;

  VisitEntity({
    this.id,
    this.secondaryId,
    this.from,
    this.title,
    this.to,
    this.roomId,
    this.changeRequestId,
    this.status,
    this.reservationTime,
    this.realVisitTime,
    this.entersClinicTime,
    this.leaveTime,
    this.doctorName,
    this.doctorId,
    this.patientId,
    this.room,
    this.patientName,
    this.notes = "",
    this.changeRequest,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        secondaryId,
        from,
        title,
        to,
        roomId,
        status,
        reservationTime,
        realVisitTime,
        entersClinicTime,
        leaveTime,
        doctorName,
        doctorId,
        patientId,
        room,
        patientName,
      ];
}

/*
class VisitDataSource extends DataGridSource {
  List<VisitEntity> models = <VisitEntity>[];
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
  VisitDataSource({this.sessions = false}) {
    init();
  }

  init() {
    if (sessions) {
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
                DataGridCell<String>(columnName: 'Patient', value: e.patientName ?? ""),
                // DataGridCell<String>(columnName: 'Status', value: e.status??""),
                // DataGridCell<String>(columnName: 'Reservation Time', value: e.reservationTime??""),
                DataGridCell<String>(columnName: 'Real Visit Time', value: e.realVisitTime ?? ""),
                DataGridCell<String>(columnName: 'Enters Clinic Time', value: e.entersClinicTime ?? ""),
                DataGridCell<String>(columnName: 'Leave Time', value: e.leaveTime ?? ""),
                DataGridCell<String>(columnName: 'Duration', value: e.duration ?? ""),
                DataGridCell<String>(columnName: 'Doctor Name', value: e.doctorName ?? ""),
                DataGridCell<String>(columnName: 'Treatment', value: e.treatment ?? ""),
              ]))
          .toList();
    } else {
      columns = [
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
                DataGridCell<String>(columnName: 'Patient', value: e.patientName ?? ""),
                DataGridCell<String>(columnName: 'Status', value: e.status ?? ""),
                DataGridCell<String>(columnName: 'Reservation Time', value: e.reservationTime ?? ""),
                DataGridCell<String>(columnName: 'Real Visit Time', value: e.realVisitTime ?? ""),
                DataGridCell<String>(columnName: 'Enters Clinic Time', value: e.entersClinicTime ?? ""),
                DataGridCell<String>(columnName: 'Leave Time', value: e.leaveTime ?? ""),
                DataGridCell<String>(columnName: 'Duration', value: e.duration ?? ""),
                DataGridCell<String>(columnName: 'Doctor Name', value: e.doctorName ?? ""),
                DataGridCell<String>(columnName: 'Treatment', value: e.treatment ?? ""),
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
      models = response.result as List<VisitEntity>;
    }
    init();
    notifyListeners();

    return true;
  }

  Future<Duration> loadSessions({required int id, String? from, String? to}) async {
    late API_Response response;

    response = await UserAPI.GetSessionsDurations(id: id, from: from, to: to);

    if (response.statusCode == 200) {
      models = response.result as List<VisitEntity>;
    }
    var duration = Duration(seconds: 0);
    for (var m in models) {
      var temp = CIA_DateConverters.parseDuration(m.duration ?? "00:00:00");
      duration += temp;
    }
    init();
    notifyListeners();

    return duration;
  }

  Future<bool> setData(List<VisitEntity> model) async {
    models = model;
    init();
    notifyListeners();
    return true;
  }
}*/