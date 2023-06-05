import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/CashFlowSummaryModel.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Models/ReceiptModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../API/CashFlowAPI.dart';
import 'API_Response.dart';

class CashFlowModel {
  int? id;
  int? receiptID;
  ReceiptModel? receipt;
  String? date;
  String? name;
  int? categoryId;
  DropDownDTO? category;
  int? supplierId;
  DropDownDTO? supplier;
  int? createdById;
  DropDownDTO? createdBy;
  int? patientId;
  DropDownDTO? patient;
  int? price;
  int? count;
  int? paymentMethodId;
  DropDownDTO? paymentMethod;
  int? paymentLogId;
  DropDownDTO? paymentLog;
  String? notes;
  String? type;
  DropDownDTO? membraneCompany;
  DropDownDTO? membrane;
  DropDownDTO? tac;
  DropDownDTO? implantCompany;
  DropDownDTO? implantLine;
  DropDownDTO? implant;

  CashFlowModel({
    this.id,
    this.receiptID,
    this.receipt,
    this.date,
    this.name,
    this.categoryId,
    this.category,
    this.supplierId,
    this.supplier,
    this.createdById,
    this.createdBy,
    this.price,
    this.count,
    this.paymentMethodId,
    this.paymentMethod,
    this.notes,
    this.type,
    this.membraneCompany,
    this.membrane,
    this.tac,
    this.implantCompany,
    this.implantLine,
    this.implant,
  });

  CashFlowModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiptID = json['receiptID'];
    receipt = ReceiptModel.fromJson(json['receipt'] ?? Map<String, dynamic>());
    date = CIA_DateConverters.fromBackendToDateTime(json['date']);
    name = json['name'];
    categoryId = json['categoryId'];
    category = json['category'] != null ? new DropDownDTO.fromJson(json['category']) : DropDownDTO();
    patientId = json['patientId'];
    patient = json['patient'] != null ? new DropDownDTO.fromJson(json['patient']) : DropDownDTO();
    supplierId = json['supplierId'];
    supplier = json['supplier'] != null ? new DropDownDTO.fromJson(json['supplier']) : DropDownDTO();
    createdById = json['createdById'];
    createdBy = json['createdBy'] != null ? new DropDownDTO.fromJson(json['createdBy']) : DropDownDTO();
    price = json['price'];
    count = json['count'];
    paymentMethodId = json['paymentMethodId'];
    paymentMethod = json['paymentMethod'] != null ? new DropDownDTO.fromJson(json['paymentMethod']) : DropDownDTO();
    paymentLogId = json['paymentLogId'];
    paymentLog = json['paymentLog'] != null ? new DropDownDTO.fromJson(json['paymentLog']) : DropDownDTO();
    notes = json['notes'];
    type = json['type'];
    receiptID = json['receiptID'];
    receipt = ReceiptModel.fromJson(json['receipt'] ?? Map<String, dynamic>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receiptID'] = this.receiptID;
    data['receipt'] = this.receipt;
    data['date'] = CIA_DateConverters.fromBackendToDateTime(this.date);
    data['name'] = this.name;
    data['categoryId'] = this.categoryId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['supplierId'] = this.supplierId;
    if (this.supplier != null) {
      data['supplier'] = this.supplier!.toJson();
    }
    data['createdById'] = this.createdById;
    data['createdBy'] = this.createdBy;
    data['price'] = this.price;
    data['count'] = this.count;
    data['paymentMethodId'] = this.paymentMethodId;
    if (this.paymentMethod != null) {
      data['paymentMethod'] = this.paymentMethod!.toJson();
    }
    data['notes'] = this.notes;
    data['type'] = this.type;
    return data;
  }
}

class CashFlowDataSource extends DataGridSource {
  List<String> columns = [
    "ID",
    "Item",
    "Category",
    "Created by",
    "Amount",
    "Method",
    "Notes",
  ];

  List<CashFlowModel> models = <CashFlowModel>[];
  CashFlowType type;

  /// Creates the income data source class with required details.
  CashFlowDataSource({required this.type}) {
    init();
  }

  init() {
    if (type == CashFlowType.income) {
      columns = [
        "ID",
        "Date",
        "Category",
        "Created by",
        "Patient",
        "Receipt Id",
        "Payment Log Id",
        "Amount",
      ];
      _cashFlowData = models
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<int>(columnName: 'ID', value: e.id),
                DataGridCell<String>(columnName: 'Date', value: e.date),
                DataGridCell<String>(columnName: 'Category', value: e.category!.name),
                DataGridCell<String>(columnName: 'Created by', value: e.createdBy!.name),
                DataGridCell<String>(columnName: 'Patient', value: e.patient!.name),
                DataGridCell<int>(columnName: 'Receipt Id', value: e.receiptID),
                DataGridCell<int>(columnName: 'Payment Log Id', value: e.paymentLogId),
                DataGridCell<int>(columnName: 'Amount', value: e.price ?? 0),
              ]))
          .toList();
    } else if (type == CashFlowType.expenses) {
      columns = [
        "ID",
        "Item",
        "Date",
        "Category",
        "Supplier",
        "Created by",
        "Amount",
        "Method",
        "Notes",
      ];
      _cashFlowData = models
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<int>(columnName: 'ID', value: e.id),
                DataGridCell<String>(columnName: 'Item', value: e.name),
                DataGridCell<String>(columnName: 'Date', value: e.date),
                DataGridCell<String>(columnName: 'Category', value: e.category!.name),
                DataGridCell<String>(columnName: 'Supplier', value: e.supplier!.name),
                DataGridCell<String>(columnName: 'Created by', value: e.createdBy!.name),
                DataGridCell<int>(columnName: 'Amount', value: e.price??0),
                DataGridCell<String>(columnName: 'Method', value: e.paymentMethod!.name),
                DataGridCell<String>(columnName: 'Notes', value: e.notes ?? ""),
              ]))
          .toList();
    }
  }

  List<DataGridRow> _cashFlowData = [];

  @override
  List<DataGridRow> get rows => _cashFlowData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          e.value.toString(),
        ),
      );
    }).toList());
  }

  Future<bool> loadData({
    String? from,
    String? to,
    int? catId,
    int? paymentMethodId,
  }) async {
    late API_Response response;

    if (type == CashFlowType.income)
      response = await CashFlowAPI.ListIncome(from: from, to: to, catId: catId, paymentMethodId: paymentMethodId);
    else if (type == CashFlowType.expenses) response = await CashFlowAPI.ListExpenses(from: from, to: to, catId: catId, paymentMethodId: paymentMethodId);
    if (response.statusCode == 200) models = response.result as List<CashFlowModel>;
    init();
    notifyListeners();

    return true;
  }
}
