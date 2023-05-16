import 'package:cariro_implant_academy/API/StockAPI.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'API_Response.dart';

class StockModel {
  int? id;
  String? name;
  int? count;
  int? categoryId;
  DropDownDTO? category;

  StockModel({this.id, this.name, this.count, this.category});

  StockModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "";
    count = json['count'] ?? 0;
    categoryId = json['categoryId'];
    category = DropDownDTO.fromJson(json['category'] ?? Map<String, dynamic>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['count'] = this.count;
    data['categoryId'] = this.categoryId;
    data['category'] = this.category != null ? this.category!.toJson() : null;
    return data;
  }
//IncomeDataSource dataSource = IncomeDataSource();
}

class StockLogModel {
  int? id;
  String? name;
  int? count;
  int? categoryId;
  DropDownDTO? category;
  String? date;
  String? status;
  int? operatorID;
  DropDownDTO? operator;

  StockLogModel({this.id, this.name, this.count});

  StockLogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "";
    count = json['count'] ?? 0;
    categoryId = json['categoryId'];
    category = DropDownDTO.fromJson(json['category'] ?? Map<String, dynamic>());
    date = CIA_DateConverters.fromBackendToDateTime(json['date']);
    status = json['status'];
    operatorID = json['operatorID'];
    operator = DropDownDTO.fromJson(json['operator'] ?? Map<String, dynamic>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['count'] = this.count;
    data['categoryId'] = this.categoryId;
    data['category'] = this.category != null ? this.category!.toJson() : null;
    data['date'] = this.date;
    data['status'] = this.status;
    data['operatorID'] = this.operatorID;
    data['operator'] = this.operator==null?null:this.operator!.toJson();
    return data;
  }
//IncomeDataSource dataSource = IncomeDataSource();
}

class StockDataSource extends DataGridSource {
  List<String> columns = [
    "ID",
    "Name",
    "Category",
    "Count",
  ];

  List<StockModel> models = <StockModel>[];

  /// Creates the income data source class with required details.
  StockLogsDataSource() {
    init();
  }

  init() {
    _stockData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(columnName: 'Category', value: e.category!.name),
              DataGridCell<int>(columnName: 'Count', value: e.count),
            ]))
        .toList();
  }

  List<DataGridRow> _stockData = [];

  @override
  List<DataGridRow> get rows => _stockData;

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

  Future<bool> loadData() async {
    late API_Response response;

    response = await StockAPI.GetAllStock();
    if (response.statusCode == 200) {
      models = response.result as List<StockModel>;
    }
    init();
    notifyListeners();

    return true;
  }
}

class StockLogsDataSource extends DataGridSource {
  List<String> columns = [
    "ID",
    "Date",
    "Name",
    "Operator",
    "Count",
    "Status",
  ];

  List<StockLogModel> models = <StockLogModel>[];

  /// Creates the income data source class with required details.
  StockLogsDataSource() {
    init();
  }

  init() {
    _stockLogsData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'ID', value: e.id),
      DataGridCell<String>(columnName: 'Date', value: e.date??""),
      DataGridCell<String>(columnName: 'Name', value: e.name),
      DataGridCell<String>(columnName: 'Operator', value: e.operator!.name),
      DataGridCell<int>(columnName: 'Count', value: e.count),
      DataGridCell<String>(columnName: 'Status', value: e.status??""),
    ]))
        .toList();
  }

  List<DataGridRow> _stockLogsData = [];

  @override
  List<DataGridRow> get rows => _stockLogsData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          if(e.columnName == "Status")
            return Container(
              alignment: Alignment.center,
              child: Text(
                e.value.toString(),
                style: TextStyle(
                    color: e.value=="Added"?Colors.green:e.value=="Removed"?Colors.red:Colors.black
                ),
              ),
            );
          return Container(
            alignment: Alignment.center,
            child: Text(e.value.toString()),
          );
        }).toList());
  }

  Future<bool> loadData() async {
    late API_Response response;

    response = await StockAPI.GetStockLogs();
    if (response.statusCode == 200) {
      models = response.result as List<StockLogModel>;
    }
    init();
    notifyListeners();

    return true;
  }
}
