import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StockModel {
  int? ID;
  String? Name;
  String? Count;

  StockModel(
    this.ID,
    this.Name,
    this.Count,
  );

  static List<StockModel> models = <StockModel>[];
  static List<String> columns = [
    "ID",
    "Name",
    "Count",
  ];
//IncomeDataSource dataSource = IncomeDataSource();

}

class StockDataSource extends DataGridSource {
  List<StockModel> models = <StockModel>[
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
    StockModel(1, "Item Name", "Count"),
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
