import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/toothReceiptEntity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ReceiptEntity extends Equatable {
  int? id;
  DateTime? date;
  int? patientId;
  BasicNameIdObjectEntity? patient;
  int? operatorId;
  BasicNameIdObjectEntity? operator;
  List<ToothReceiptEntity>? toothReceiptData;
  int? total;
  int? paid;
  int? unpaid;
  List<BasicNameIdObjectEntity>? prices;
  bool? isPaid;

  ReceiptEntity({
    this.id,
    this.date,
    this.patientId,
    this.patient,
    this.operatorId,
    this.operator,
    this.toothReceiptData,
    this.total,
    this.paid,
    this.unpaid,
    this.prices,
    this.isPaid,
  });

  @override
  List<Object?> get props => [
        this.id,
        this.date,
        this.patientId,
        this.patient,
        this.operatorId,
        this.operator,
        this.toothReceiptData,
        this.total,
        this.paid,
        this.unpaid,
        this.prices,
        this.isPaid,
      ];
}
/*
class ReceiptDataSousrce extends DataGridSource {
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

  List<ReceiptEntity> models = <ReceiptEntity>[];

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
    if (response.statusCode == 200) models = response.result as List<ReceiptEntity>;
    init();
    notifyListeners();

    return true;
  }
}
*/