import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../API/PatientAPI.dart';

class VisitsModel {
  int? id;
  String? status;
  String? reservationTime;
  String? realVisitTime;
  String? entersClinicTime;
  String? leaveTime;
  String? doctorName;
  String? Treatment;
  String? patientName;

  VisitsModel(
      {this.id,
      this.status,
      this.reservationTime,
      this.realVisitTime,
      this.entersClinicTime,
      this.leaveTime,
      this.doctorName,
      this.patientName});

  VisitsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    reservationTime = json['reservationTime'] == null
        ? null
        : DateFormat("d MMM yyyy h:mm a")
            .format(DateTime.parse(json['reservationTime']));
    realVisitTime = json['realVisitTime'] == null
        ? null
        : DateFormat("d MMM yyyy h:mm a")
            .format(DateTime.parse(json['realVisitTime']));
    entersClinicTime = json['entersClinicTime'] == null
        ? null
        : DateFormat("d MMM yyyy h:mm a")
            .format(DateTime.parse(json['entersClinicTime']));
    leaveTime = json['leaveTime'] == null
        ? null
        : DateFormat("d MMM yyyy h:mm a")
            .format(DateTime.parse(json['leaveTime']));
    doctorName = json['doctorName'];
    patientName = json['patientName'];
    //doctorName = json['doctorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['status'] = status;
    data['reservationTime'] = reservationTime;
    data['realVisitTime'] = realVisitTime;
    data['entersClinicTime'] = entersClinicTime;
    data['leaveTime'] = leaveTime;
    data['doctorName'] = doctorName;
    data['patientName'] = patientName;
    return data;
  }

  static List<VisitsModel> models = <VisitsModel>[];
  static List<String> columns = [
    "id",
    "Status",
    "Reservation Time",
    "Real Visit Time",
    "Enters Clinic Time",
    "Leave Time",
    "Doctor Name",
    //"Treatment",
  ];
//VisitDataSource dataSource = VisitDataSource();

}

class VisitDataSource extends DataGridSource {
  List<VisitsModel> models = <VisitsModel>[];

  /// Creates the visit data source class with required details.
  VisitDataSource() {
    _visitData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'Status', value: e.status),
              DataGridCell<String>(
                  columnName: 'Reservation Time', value: e.reservationTime),
              DataGridCell<String>(
                  columnName: 'Real Visit Time', value: e.realVisitTime),
              DataGridCell<String>(
                  columnName: 'Enters Clinic Time', value: e.entersClinicTime),
              DataGridCell<String>(
                  columnName: 'Leave Time', value: e.leaveTime),
              DataGridCell<String>(
                  columnName: 'Doctor Name', value: e.doctorName),
            ]))
        .toList();
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

  Future<bool> loadData(int id) async {
    var response = await PatientAPI.GetVisitsLogs(id);
    if (response.statusCode == 200) {
      models = response.result as List<VisitsModel>;
    }
    _visitData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'Status', value: e.status),
              DataGridCell<String>(
                  columnName: 'Reservation Time', value: e.reservationTime),
              DataGridCell<String>(
                  columnName: 'Real Visit Time', value: e.realVisitTime),
              DataGridCell<String>(
                  columnName: 'Enters Clinic Time', value: e.entersClinicTime),
              DataGridCell<String>(
                  columnName: 'Leave Time', value: e.leaveTime),
              DataGridCell<String>(
                  columnName: 'Doctor Name', value: e.doctorName),
            ]))
        .toList();
    notifyListeners();

    return true;
  }

  Future<bool> setData(List<VisitsModel> model) async {
    models = model;
    _visitData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'Status', value: e.status),
              DataGridCell<String>(
                  columnName: 'Reservation Time', value: e.reservationTime),
              DataGridCell<String>(
                  columnName: 'Real Visit Time', value: e.realVisitTime),
              DataGridCell<String>(
                  columnName: 'Enters Clinic Time', value: e.entersClinicTime),
              DataGridCell<String>(
                  columnName: 'Leave Time', value: e.leaveTime),
              DataGridCell<String>(
                  columnName: 'Doctor Name', value: e.doctorName),
            ]))
        .toList();
    notifyListeners();

    return true;
  }
}
