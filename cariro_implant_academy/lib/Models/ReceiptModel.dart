import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'API_Response.dart';
import 'PatientInfo.dart';

class ReceiptModel {
  int? id;
  String? date;
  int? patientId;
  PatientInfoModel? patient;
  int? operatorId;
  ApplicationUserModel? operator;
  List<ToothReceiptData>? toothReceiptData;
  int? total;
  int? paid;
  int? unpaid;

  ReceiptModel(
      {this.id,
      this.date,
      this.patientId,
      this.patient,
      this.operatorId,
      this.operator,
      this.toothReceiptData,
      this.total,
      this.paid,
      this.unpaid});

  ReceiptModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = CIA_DateConverters.fromBackendToDateTime(json['date']);
    patientId = json['patientId'];
    patient = PatientInfoModel.fromJson(json['patient'] ?? Map<String, dynamic>());
    operatorId = json['operatorId'];
    operator = ApplicationUserModel.fromJson(json['operator'] ?? Map<String, dynamic>());
    toothReceiptData = ((json['toothReceiptData']??[]) as List<dynamic> ).map((e) => ToothReceiptData.fromJson(e as Map<String,dynamic>)).toList();
    total = json['total'];
    paid = json['paid'];
    unpaid = json['unpaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['patientId'] = this.patientId;
    data['patient'] = this.patient == null ? null : this.patient!.toJson();
    data['operatorId'] = this.operatorId;
    data['operator'] = this.operator == null ? null : this.operator!.toJson();
    data['total'] = this.total;
    data['paid'] = this.paid;
    data['unpaid'] = this.unpaid;
    return data;
  }
}

class ToothReceiptData {
  int? tooth;
  int? crown;
  int? scaling;
  int? restoration;
  int? rootCanalTreatment;
  int? extraction;
  ToothReceiptData({
    this.extraction=0,
    this.restoration=0,
    this.rootCanalTreatment=0,
    this.scaling=0,
    this.crown=0,
    this.tooth,
  });

  ToothReceiptData.fromJson(Map<String, dynamic> json) {
    crown = json['crown'];
    scaling = json['scaling'];
    restoration = json['restoration'];
    rootCanalTreatment = json['rootCanalTreatment'];
    extraction = json['extraction'];
    tooth = json['tooth'];
  }


}

class ReceiptDataSource extends DataGridSource {
  List<String> columns = [
    "ID",
    "Date",
    "Patient Name",
    "Patient Id",
    "Operator",
    "Paid",
    "Unpaid",
    "Total",
  ];

  List<ReceiptModel> models = <ReceiptModel>[];

  ReceiptDataSource() {
    init();
  }

  init() {
    _data = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Date', value: e.date ?? ""),
              DataGridCell<String>(columnName: 'Patient Name', value: e.patient!.name),
              DataGridCell<int>(columnName: 'Patient Id', value: e.patientId!),
              DataGridCell<String>(columnName: 'Operator', value: e.operator!.name),
              DataGridCell<int>(columnName: 'Paid', value: e.paid),
              DataGridCell<int>(columnName: 'Unpaid', value: e.unpaid),
              DataGridCell<int>(columnName: 'Total', value: e.total),
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
      return Container(
        alignment: Alignment.center,
        child: Text(
          e.value.toString(),
          style: TextStyle(color: e.columnName.toLowerCase() == "unpaid" && e.value != 0 ? Colors.red : Colors.black),
        ),
      );
    }).toList());
  }

  Future<bool> loadData({required int id}) async {
    late API_Response response;
    response = await PatientAPI.GetReceipts(id);
    if (response.statusCode == 200) models = response.result as List<ReceiptModel>;
    init();
    notifyListeners();

    return true;
  }
}
