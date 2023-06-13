import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Incom {
  String? Date;
  int? ID;
  String? Item;
  String? Category;
  String? CreatedBy;
  String? Amount;
  String? Method;
  String? Notes;

  Incom(
    this.Date,
    this.Item,
    this.Category,
    this.CreatedBy,
    this.Amount,
    this.Method,
    this.Notes,
  );

  static List<Incom> models = <Incom>[];
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

class IncomDataSource extends DataGridSource {
  List<Incom> models = <Incom>[
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
    Incom("22/12/2022", "myItem", "Category", "CreatedBy", "Amount", "Method",
        "Notes"),
  ];

  /// Creates the incom data source class with required details.
  IncomDataSource() {
    _incomData = models
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

  List<DataGridRow> _incomData = [];

  @override
  List<DataGridRow> get rows => _incomData;

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

    models.add(Incom("1/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"));
    models.add(Incom("2/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"));
    models.add(Incom("3/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"));
    models.add(Incom("4/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"));
    models.add(Incom("5/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"));
    models.add(Incom("6/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"));
    models.add(Incom("7/12/2022", "myItem", "Category", "CreatedBy", "Amount",
        "Method", "Notes"));

    _incomData = models
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
