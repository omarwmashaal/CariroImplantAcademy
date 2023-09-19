import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../core/constants/enums/enums.dart';
import 'Enum.dart';

class ComplainsModel {
  int? id;
  String? comment;
  int? patientID;
  DropDownDTO? patient;
  int? lastDoctorId;
  DropDownDTO? lastDoctor;
  int? lastSupervisorId;
  DropDownDTO? lastSupervisor;
  int? lastCandidateId;
  DropDownDTO? lastCandidate;
  int? mentionedDoctorId;
  DropDownDTO? mentionedDoctor;
  int? entryById;
  DropDownDTO? entryBy;
  String? entryTime;
  EnumComplainStatus? status;
  int? resolvedById;
  DropDownDTO? resolvedBy;
  String? notes;

  ComplainsModel(
      {this.id,
      this.comment,
      this.patientID,
      this.patient,
      this.lastDoctorId,
      this.lastDoctor,
      this.lastSupervisorId,
      this.notes,
      this.lastSupervisor,
      this.lastCandidateId,
      this.lastCandidate,
      this.mentionedDoctorId,
      this.mentionedDoctor,
      this.entryById,
      this.entryBy,
      this.entryTime});

  ComplainsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    notes = json['queueNotes']??"";
    status = json['status'] ==null ? EnumComplainStatus.Untouched:EnumComplainStatus.values[json['status']];
    patientID = json['patientID'];
    patient = DropDownDTO.fromJson((json['patient'] ?? Map<String, dynamic>()) as Map<String, dynamic>);
    lastDoctorId = json['lastDoctorId'];
    lastDoctor = DropDownDTO.fromJson((json['lastDoctor'] ?? Map<String, dynamic>()) as Map<String, dynamic>);
    lastSupervisorId = json['lastSupervisorId'];
    lastSupervisor = DropDownDTO.fromJson((json['lastSupervisor'] ?? Map<String, dynamic>()) as Map<String, dynamic>);
    lastCandidateId = json['lastCandidateId'];
    lastCandidate = DropDownDTO.fromJson((json['lastCandidate'] ?? Map<String, dynamic>()) as Map<String, dynamic>);
    mentionedDoctorId = json['mentionedDoctorId'];
    mentionedDoctor = DropDownDTO.fromJson((json['mentionedDoctor'] ?? Map<String, dynamic>()) as Map<String, dynamic>);
    entryById = json['entryById'];
    entryBy = DropDownDTO.fromJson((json['entryBy'] ?? Map<String, dynamic>()) as Map<String, dynamic>);
    resolvedById = json['resolvedById'];
    resolvedBy = DropDownDTO.fromJson((json['resolvedBy'] ?? Map<String, dynamic>()) as Map<String, dynamic>);
    entryTime = CIA_DateConverters.fromBackendToDateTime(json['entryTime']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['patientID'] = this.patientID;
    data['mentionedDoctorId'] = this.mentionedDoctorId;
    return data;
  }
}

class ComplainsDataSource extends DataGridSource {
  List<ComplainsModel> models = <ComplainsModel>[];
  List<String> columns = [
    "Date",
    "Patient Name",
    "Complain",
    "Last Supervisor",
    "Last Doctor",
    "Mentioned Doctor",
    "Notes",
    "Status",
    "Operator",
  ];

  /// Creates the visit data source class with required details.
  ComplainsDataSource() {
    init();
  }

  init() {
    _data = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Date', value: e.entryTime),
              DataGridCell<String>(columnName: 'Patient Name', value: e.patient!.name??""),
              DataGridCell<String>(columnName: 'Complain', value: e.comment??""),
              DataGridCell<String>(columnName: 'Last Supervisor', value: e.lastSupervisor!.name??""),
              DataGridCell<String>(columnName: 'Last Doctor', value: e.lastDoctor!.name??""),
              DataGridCell<String>(columnName: 'Mentioned Doctor', value: e.mentionedDoctor!.name??""),
              DataGridCell<String>(columnName: 'Notes', value: e.notes),
              DataGridCell<String>(columnName: 'Status', value: e.status!.name),
              DataGridCell<String>(columnName: 'Operator', value: e.resolvedBy!.name??""),
            ]))
        .toList();
  }

  List<DataGridRow> _data = [];

  @override
  List<DataGridRow> get rows => _data;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          if(e.value is Widget)
            return e.value;
      return Container(
        alignment: Alignment.center,
        child: Text(
          e.value == null ? "" : e.value.toString(),
          style: TextStyle(fontSize: 12),
        ),
      );
    }).toList());
  }

  Future<bool> loadData({String? search,EnumComplainStatus? status}) async {
    var response = await PatientAPI.GetComplains(search: search,status: status);
    if (response.statusCode == 200) {
      models = response.result as List<ComplainsModel>;
    }
    init();
    notifyListeners();

    return true;
  }


}
