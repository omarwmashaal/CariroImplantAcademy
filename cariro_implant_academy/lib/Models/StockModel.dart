import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StockModel {
  int? ID;
  String? Name;
  String? Count;
  String? Status;
  String? Price;

  StockModel({this.ID, this.Name, this.Count, this.Status, this.Price});

  static List<String> columns = [
    "ID",
    "Name",
    "Count",
  ];
  static List<String> logsColumns = ["ID", "Name", "Count", "Status"];
//IncomeDataSource dataSource = IncomeDataSource();

}

class StockDataSource extends DataGridSource {
  List<StockModel> models = <StockModel>[
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count"),
  ];

  /// Creates the income data source class with required details.
  StockDataSource() {
    _incomeData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.ID),
              DataGridCell<String>(columnName: 'Name', value: e.Name),
              DataGridCell<String>(columnName: 'Count', value: e.Count),
            ]))
        .toList();
  }

  List<DataGridRow> _incomeData = [];

  @override
  List<DataGridRow> get rows => _incomeData;

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
}

class StockLogsDataSource extends DataGridSource {
  List<StockModel> models = <StockModel>[
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Added"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Removed"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Added"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Removed"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Added"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Removed"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Removed"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Removed"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Added"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Removed"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Added"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Removed"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Added"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Removed"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Added"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Added"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Added"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Added"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Added"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Added"),
    StockModel(ID: 1, Name: "Item Name", Count: "Count", Status: "Added"),
  ];

  /// Creates the income data source class with required details.
  StockLogsDataSource() {
    _incomeData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.ID),
              DataGridCell<String>(columnName: 'Name', value: e.Name),
              DataGridCell<String>(columnName: 'Count', value: e.Count),
              DataGridCell<String>(columnName: 'Status', value: e.Status),
            ]))
        .toList();
  }

  List<DataGridRow> _incomeData = [];

  @override
  List<DataGridRow> get rows => _incomeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 50),
        child: Text(
          e.value.toString(),
          style: TextStyle(
              color: e.value.toString().toLowerCase() == "added"
                  ? Colors.green
                  : (e.value.toString().toLowerCase() == "removed"
                      ? Colors.red
                      : Colors.black)),
        ),
      );
    }).toList());
  }
}
