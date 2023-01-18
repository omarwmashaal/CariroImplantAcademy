import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CashFlowCategorySummaryModel {
  int? ID;
  DateTime? Date;
  String? Item;
  int? Count;
  String? Supplier;
  int? Total;
  String? HandledBy;
  String? Category;

  CashFlowCategorySummaryModel({
    this.Date,
    this.Item,
    this.Count,
    this.Supplier,
    this.Total,
    this.HandledBy,
    this.Category,
  });

  static List<CashFlowCategorySummaryModel> models =
      <CashFlowCategorySummaryModel>[];
  static List<String> columns = [
    "Date",
    "Item",
    "Count",
    "Supplier",
    "Total",
    "Handled By",
  ];
//IncomeDataSource dataSource = IncomeDataSource();

}

class CashFlowCategorySummaryDataSource extends DataGridSource {
  List<CashFlowCategorySummaryModel> models = <CashFlowCategorySummaryModel>[
    CashFlowCategorySummaryModel(
        Category: "Category",
        Count: 8,
        Date: DateTime.now(),
        HandledBy: "Omar",
        Item: "Item Name",
        Supplier: "Supplier Name",
        Total: 90),
    CashFlowCategorySummaryModel(
        Category: "Category",
        Count: 8,
        Date: DateTime.now(),
        HandledBy: "Omar",
        Item: "Item Name",
        Supplier: "Supplier Name",
        Total: 90),
    CashFlowCategorySummaryModel(
        Category: "Category",
        Count: 8,
        Date: DateTime.now(),
        HandledBy: "Omar",
        Item: "Item Name",
        Supplier: "Supplier Name",
        Total: 90),
    CashFlowCategorySummaryModel(
        Category: "Category",
        Count: 8,
        Date: DateTime.now(),
        HandledBy: "Omar",
        Item: "Item Name",
        Supplier: "Supplier Name",
        Total: 90),
    CashFlowCategorySummaryModel(
        Category: "Category",
        Count: 8,
        Date: DateTime.now(),
        HandledBy: "Omar",
        Item: "Item Name",
        Supplier: "Supplier Name",
        Total: 90),
    CashFlowCategorySummaryModel(
        Category: "Category",
        Count: 8,
        Date: DateTime.now(),
        HandledBy: "Omar",
        Item: "Item Name",
        Supplier: "Supplier Name",
        Total: 90),
    CashFlowCategorySummaryModel(
        Category: "Category",
        Count: 8,
        Date: DateTime.now(),
        HandledBy: "Omar",
        Item: "Item Name",
        Supplier: "Supplier Name",
        Total: 90),
    CashFlowCategorySummaryModel(
        Category: "Category",
        Count: 8,
        Date: DateTime.now(),
        HandledBy: "Omar",
        Item: "Item Name",
        Supplier: "Supplier Name",
        Total: 90),
    CashFlowCategorySummaryModel(
        Category: "Category",
        Count: 8,
        Date: DateTime.now(),
        HandledBy: "Omar",
        Item: "Item Name",
        Supplier: "Supplier Name",
        Total: 90),
    CashFlowCategorySummaryModel(
        Category: "Category",
        Count: 8,
        Date: DateTime.now(),
        HandledBy: "Omar",
        Item: "Item Name",
        Supplier: "Supplier Name",
        Total: 90),
    CashFlowCategorySummaryModel(
        Category: "Category",
        Count: 8,
        Date: DateTime.now(),
        HandledBy: "Omar",
        Item: "Item Name",
        Supplier: "Supplier Name",
        Total: 90),
    CashFlowCategorySummaryModel(
        Category: "Category",
        Count: 8,
        Date: DateTime.now(),
        HandledBy: "Omar",
        Item: "Item Name",
        Supplier: "Supplier Name",
        Total: 90),
  ];

  /// Creates the income data source class with required details.
  CashFlowCategorySummaryDataSource() {
    _incomeData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<DateTime>(columnName: 'Date', value: e.Date),
              DataGridCell<String>(columnName: 'Item', value: e.Item),
              DataGridCell<int>(columnName: 'Count', value: e.Count),
              DataGridCell<String>(columnName: 'Supplier', value: e.Supplier),
              DataGridCell<int>(columnName: 'Total', value: e.Total),
              DataGridCell<String>(
                  columnName: 'Handled By', value: e.HandledBy),
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
        //padding: EdgeInsets.only(right: 50),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return Expanded(
      child: Container(
        color: Colors.yellow,
        child: Row(
          children: [
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Total",
                  )),
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    summaryValue,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
