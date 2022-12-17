import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CashFlow {
  String? Date;
  int? ID;
  String? Item;
  String? Category;
  String? CreatedBy;
  String? Amount;
  String? Method;
  String? Notes;

  CashFlow(
    this.Date,
    this.Item,
    this.Category,
    this.CreatedBy,
    this.Amount,
    this.Method,
    this.Notes,
  );

  static List<CashFlow> models = <CashFlow>[];
  static List<String> columns = [
    "Date",
    "Item",
    "Category",
    "Created By",
    "Amount",
    "Method",
    "Notes",
  ];
//PatientDataSource dataSource = PatientDataSource();

}

class CashFlowDataSource extends DataGridSource {
  List<CashFlow> models = <CashFlow>[
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
    CashFlow("22/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"),
  ];

  /// Creates the cashFlow data source class with required details.
  CashFlowDataSource() {
    _cashFlowData = models
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'Date', value: e.Date),
              DataGridCell<String>(columnName: 'Item', value: e.Item),
              DataGridCell<String>(columnName: 'Category', value: e.Category),
              DataGridCell<String>(
                  columnName: 'Created By', value: e.CreatedBy),
              DataGridCell<String>(columnName: 'Amount', value: e.Amount),
              DataGridCell<String>(columnName: 'Method', value: e.Method),
              DataGridCell<String>(columnName: 'Notes', value: e.Notes),
            ],
          ),
        )
        .toList();
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
        padding: EdgeInsets.only(right: 50),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  Future<bool> addMoreRows() async {
    print("entered bunction");
    models.add(CashFlow("1/12/2022", "myItem", "Category", "CreatedBy",
        "Amount", "Method", "Notes"));
    models.add(CashFlow("2/12/2022", "myItem", "Category", "CreatedBy",
        "Amount", "Method", "Notes"));
    models.add(CashFlow("3/12/2022", "myItem", "Category", "CreatedBy",
        "Amount", "Method", "Notes"));
    models.add(CashFlow("4/12/2022", "myItem", "Category", "CreatedBy",
        "Amount", "Method", "Notes"));
    models.add(CashFlow("5/12/2022", "myItem", "Category", "CreatedBy",
        "Amount", "Method", "Notes"));
    models.add(CashFlow("6/12/2022", "myItem", "Category", "CreatedBy",
        "Amount", "Method", "Notes"));
    models.add(CashFlow("7/12/2022", "myItem", "Category", "CreatedBy",
        "Amount", "Method", "Notes"));

    _cashFlowData = models
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'Date', value: e.Date),
              DataGridCell<String>(columnName: 'Item', value: e.Item),
              DataGridCell<String>(columnName: 'Category', value: e.Category),
              DataGridCell<String>(
                  columnName: 'Created By', value: e.CreatedBy),
              DataGridCell<String>(columnName: 'Amount', value: e.Amount),
              DataGridCell<String>(columnName: 'Method', value: e.Method),
              DataGridCell<String>(columnName: 'Notes', value: e.Notes),
            ],
          ),
        )
        .toList();
    notifyListeners();
    return true;
  }
}
