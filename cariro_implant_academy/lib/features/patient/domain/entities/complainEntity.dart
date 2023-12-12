import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/constants/enums/enums.dart';

class ComplainsEntity extends Equatable {
  int? id;
  String? secondaryId;
  String? comment;
  int? patientID;
  BasicNameIdObjectEntity? patient;
  int? lastDoctorId;
  BasicNameIdObjectEntity? lastDoctor;
  int? lastSupervisorId;
  BasicNameIdObjectEntity? lastSupervisor;
  int? lastCandidateId;
  BasicNameIdObjectEntity? lastCandidate;
  int? mentionedDoctorId;
  BasicNameIdObjectEntity? mentionedDoctor;
  int? entryById;
  BasicNameIdObjectEntity? entryBy;
  DateTime? entryTime;
  EnumComplainStatus? status;
  int? resolvedById;
  BasicNameIdObjectEntity? resolvedBy;
  String? notes;

  ComplainsEntity(
      {this.id,
      this.comment,
      this.secondaryId,
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

  @override
  List<Object?> get props => [
        this.id,
        this.secondaryId,
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
        this.entryTime,
      ];
}

/*
class ComplainsDataSource extends DataGridSource {
  List<ComplainsEntity> models = <ComplainsEntity>[];
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
              DataGridCell<String>(columnName: 'Patient Name', value: e.patient!.name ?? ""),
              DataGridCell<String>(columnName: 'Complain', value: e.comment ?? ""),
              DataGridCell<String>(columnName: 'Last Supervisor', value: e.lastSupervisor!.name ?? ""),
              DataGridCell<String>(columnName: 'Last Doctor', value: e.lastDoctor!.name ?? ""),
              DataGridCell<String>(columnName: 'Mentioned Doctor', value: e.mentionedDoctor!.name ?? ""),
              DataGridCell<String>(columnName: 'Notes', value: e.notes),
              DataGridCell<String>(columnName: 'Status', value: e.status!.name),
              DataGridCell<String>(columnName: 'Operator', value: e.resolvedBy!.name ?? ""),
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
      if (e.value is Widget) return e.value;
      return Container(
        alignment: Alignment.center,
        child: Text(
          e.value == null ? "" : e.value.toString(),
          style: TextStyle(fontSize: 12),
        ),
      );
    }).toList());
  }

  Future<bool> loadData({String? search, EnumComplainStatus? status}) async {
    var response = await PatientAPI.GetComplains(search: search, status: status);
    if (response.statusCode == 200) {
      models = response.result as List<ComplainsEntity>;
    }
    init();
    notifyListeners();

    return true;
  }
}
*/