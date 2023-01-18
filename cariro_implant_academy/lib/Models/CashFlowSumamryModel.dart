import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CashFlowSummaryModel {
  int? ID;
  String? Category;
  int? Amount;

  CashFlowSummaryModel({this.Category, this.Amount});

  static List<CashFlowSummaryModel> models = <CashFlowSummaryModel>[];
  static List<String> columns = [
    "Category",
    "Amount",
  ];
//IncomeDataSource dataSource = IncomeDataSource();

}

class CashFlowSummaryDataSource extends DataGridSource {
  List<CashFlowSummaryModel> models = <CashFlowSummaryModel>[
    CashFlowSummaryModel(Category: "Category1", Amount: 950),
    CashFlowSummaryModel(Category: "Category2", Amount: 950),
    CashFlowSummaryModel(Category: "Category3", Amount: 950),
    CashFlowSummaryModel(Category: "Category4", Amount: 950),
    CashFlowSummaryModel(Category: "Category5", Amount: 950),
    CashFlowSummaryModel(Category: "Category6", Amount: 950),
    CashFlowSummaryModel(Category: "Category7", Amount: 950),
    CashFlowSummaryModel(Category: "Category8", Amount: 950),
    CashFlowSummaryModel(Category: "Category9", Amount: 950),
    CashFlowSummaryModel(Category: "Category10", Amount: 950),
    CashFlowSummaryModel(Category: "Category11", Amount: 950),
    CashFlowSummaryModel(Category: "Category12", Amount: 950),
    CashFlowSummaryModel(Category: "Category13", Amount: 950),
    CashFlowSummaryModel(Category: "Category14", Amount: 950),
    CashFlowSummaryModel(Category: "Category15", Amount: 950),
    CashFlowSummaryModel(Category: "Category16", Amount: 950),
    CashFlowSummaryModel(Category: "Category17", Amount: 950),
    CashFlowSummaryModel(Category: "Category18", Amount: 950),
    CashFlowSummaryModel(Category: "Category19", Amount: 950),
    CashFlowSummaryModel(Category: "Category20", Amount: 950),
    CashFlowSummaryModel(Category: "Category21", Amount: 950),
    CashFlowSummaryModel(Category: "Category22", Amount: 950),
    CashFlowSummaryModel(Category: "Category23", Amount: 950),
    CashFlowSummaryModel(Category: "Category24", Amount: 950),
  ];

  /// Creates the income data source class with required details.
  CashFlowSummaryDataSource() {
    _incomeData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Category', value: e.Category),
              DataGridCell<int>(columnName: 'Amount', value: e.Amount),
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
