import 'package:cariro_implant_academy/API/MedicalAPI.dart';
import 'package:cariro_implant_academy/API/TempPatientAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../Helpers/CIA_DateConverters.dart';
import '../DTOs/DropDownDTO.dart';

class NonSurgicalTreatmentModel {
  String? treatment;
  int? supervisorID;
  DropDownDTO? supervisor;
  int? operatorID;
  DropDownDTO? operator;
  String? date;
  String? nextVisit;

  NonSurgicalTreatmentModel(
      {this.treatment,
      this.supervisorID,
      this.supervisor,
      this.operator,
      this.operatorID,
      this.date,
      this.nextVisit});

  NonSurgicalTreatmentModel.fromJson(Map<String, dynamic> json) {
    treatment = json['treatment'];
    supervisorID = json['supervisorID'];
    supervisor = DropDownDTO.fromJson(json['supervisor']??Map<String,dynamic>());
    operatorID = json['operatorID'];
    operator = DropDownDTO.fromJson(json['operator']??Map<String,dynamic>());
    date = CIA_DateConverters.fromBackendToDateTime(json['date'] );
    nextVisit = CIA_DateConverters.fromBackendToDateTime(json['nextVisit'] );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['treatment'] = this.treatment;
    data['supervisorID'] = this.supervisorID;
    data['operatorID'] = this.operatorID;
    data['nextVisit'] = CIA_DateConverters.fromDateTimeToBackend(nextVisit);
    return data;
  }

  static List<String> columns = [
    "Date",
    "Treatment",
    "Operator",
    "Supervisor",
    "Next Visit",
  ];
}

class NonSurgicalTreatmentDataSource extends DataGridSource {
  List<NonSurgicalTreatmentModel> models = [];

  NonSurgicalTreatmentDataSource() {
    _nonSurgicalTreatmentData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Date', value: e.date),
              DataGridCell<String>(columnName: 'Treatment', value: e.treatment),
              DataGridCell<String>(
                  columnName: 'Operator', value: e.operator!.name!),
              DataGridCell<String>(
                  columnName: 'Supervisor', value: e.supervisor!.name!),
              DataGridCell<String>(
                  columnName: 'Next Visit', value: e.nextVisit),
            ]))
        .toList();
  }

  List<DataGridRow> _nonSurgicalTreatmentData = [];

  @override
  List<DataGridRow> get rows => _nonSurgicalTreatmentData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 50),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  Future<bool> loadData(int id) async {
    var response = await MedicalAPI.GetPatientAllNonSurgicalTreatments(id);
    if (response.statusCode == 200) {
      models = response.result as List<NonSurgicalTreatmentModel>;
    }
    _nonSurgicalTreatmentData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Date', value: e.date),
              DataGridCell<String>(columnName: 'Treatment', value: e.treatment),
              DataGridCell<String>(
                  columnName: 'Operator', value: e.operator!.name!),
              DataGridCell<String>(
                  columnName: 'Supervisor', value: e.supervisor!.name!),
              DataGridCell<String>(
                  columnName: 'Next Visit', value: e.nextVisit),
            ]))
        .toList();
    notifyListeners();

    return true;
  }
}
