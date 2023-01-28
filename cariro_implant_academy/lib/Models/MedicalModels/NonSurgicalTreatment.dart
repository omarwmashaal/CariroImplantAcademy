import 'package:cariro_implant_academy/API/TempPatientAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class NonSurgicalTreatmentModel {
  String? treatment;
  String? supervisorID;
  String? supervisorName;
  String? operatorID;
  String? operatorName;
  String? date;
  String? nextVisit;

  NonSurgicalTreatmentModel(
      {this.treatment,
      this.supervisorID,
      this.supervisorName,
      this.operatorName,
      this.operatorID,
      this.date,
      this.nextVisit});

  NonSurgicalTreatmentModel.fromJson(Map<String, dynamic> json) {
    treatment = json['treatment'];
    supervisorID = json['supervisorID'];
    supervisorName = json['supervisorName'] ?? "";
    operatorID = json['supervisorID'];
    operatorName = json['operatorName'] ?? "";
    date = json['date'] == null
        ? ""
        : DateFormat("d MMM yyyy h:mm a")
            .format(DateTime.parse(json['date']))
            .toString();
    nextVisit = json['nextVisit'] == null
        ? ""
        : DateFormat("d MMM yyyy h:mm a")
            .format(DateTime.parse(json['nextVisit']))
            .toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['treatment'] = this.treatment;
    data['supervisorID'] = this.supervisorID;
    data['supervisorName'] = this.supervisorName;
    data['operatorID'] = this.operatorID;
    data['operatorName'] = this.operatorName;
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
                  columnName: 'Operator', value: e.operatorName),
              DataGridCell<String>(
                  columnName: 'Supervisor', value: e.supervisorName),
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
    var response = await TempPatientAPI.GetPatientAllNonSurgicalTreatments(id);
    if (response.statusCode == 200) {
      models = response.result as List<NonSurgicalTreatmentModel>;
    }
    _nonSurgicalTreatmentData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Date', value: e.date),
              DataGridCell<String>(columnName: 'Treatment', value: e.treatment),
              DataGridCell<String>(
                  columnName: 'Operator', value: e.operatorName),
              DataGridCell<String>(
                  columnName: 'Supervisor', value: e.supervisorName),
              DataGridCell<String>(
                  columnName: 'Next Visit', value: e.nextVisit),
            ]))
        .toList();
    notifyListeners();

    return true;
  }
}
