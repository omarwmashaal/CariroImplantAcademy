import 'package:cariro_implant_academy/Models/ApplicationUserModel.dart';
import 'package:cariro_implant_academy/Models/PatientInfo.dart';
import 'package:cariro_implant_academy/Models/ReceiptModel.dart';

import '../Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/API/PatientAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../Widgets/SnackBar.dart';
import 'API_Response.dart';
import 'PatientInfo.dart';

class PaymentLogModel {
  int? id;
  int? patientId;
  PatientInfoModel? patient;
  int? operatorId;
  ApplicationUserModel? operator;
  String? date;
  int? receiptId;
  ReceiptModel? receipt;
  int? paidAmount;

  PaymentLogModel(
      {this.id,
        this.patientId,
        this.patient,
        this.operatorId,
        this.operator,
        this.date,
        this.receiptId,
        this.receipt,
        this.paidAmount});

  PaymentLogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    patient = PatientInfoModel.fromJson(json['patient']??Map<String,dynamic>());
    operatorId = json['operatorId'];
    operator = ApplicationUserModel.fromJson(json['operator']??Map<String,dynamic>());
    date = CIA_DateConverters.fromBackendToDateTime(json['date']);
    receiptId = json['receiptId'];
    //receipt = json['receipt'];
    paidAmount = json['paidAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    data['patient'] = this.patient;
    data['operatorId'] = this.operatorId;
    data['operator'] = this.operator;
    data['date'] = this.date;
    data['receiptId'] = this.receiptId;
    data['receipt'] = this.receipt;
    data['paidAmount'] = this.paidAmount;
    return data;
  }
}

class PaymentLogDataSrouce extends DataGridSource {
  List<String> columns = [
    "ID",
    "Date",
    "Patient Name",
    "Patient Id",
    "Operator",
    "Paid",
    "Remove Payment"
  ];

  List<PaymentLogModel> models = <PaymentLogModel>[];

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
      DataGridCell<int>(columnName: 'Paid', value: e.paidAmount),
      DataGridCell<Widget>(columnName: 'Remove Payment', value: IconButton(onPressed: ()async{
        await PatientAPI.RemovePayment(e.id!);
        loadData(id: _id, receiptId: _recId);
      },icon: Icon(Icons.remove),)),
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
            child: e.value is Widget? e.value: Text(
              e.value.toString(),

            ),
          );
        }).toList());
  }
  int _id = 0;
  int _recId = 0;
  Future<bool> loadData({required int id,required int receiptId}) async {
    _id = id;
    _recId = receiptId;
    late API_Response response;
    response = await PatientAPI.GetPaymentLogsForAReceipt(id,receiptId);
    if (response.statusCode == 200)
      models = response.result as List<PaymentLogModel>;
    init();
    notifyListeners();

    return true;
  }
}

