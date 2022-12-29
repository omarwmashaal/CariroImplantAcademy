import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ExpensesInfoModel {
  int? ID;
  String? Item;
  String? Category;
  String? CreatedBy;
  String? Amount;
  String? Method;
  String? Notes;

  ExpensesInfoModel(
    this.ID,
    this.Item,
    this.Category,
    this.CreatedBy,
    this.Amount,
    this.Method,
    this.Notes,
  );

  static List<ExpensesInfoModel> models = <ExpensesInfoModel>[];
  static List<String> columns = [
    "ID",
    "Item",
    "Category",
    "Created By",
    "Amount",
    "Method",
    "Notes"
  ];
//ExpensesDataSource dataSource = ExpensesDataSource();

}

class ExpensesDataSource extends DataGridSource {
  List<ExpensesInfoModel> models = <ExpensesInfoModel>[
    ExpensesInfoModel(1, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(2, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(3, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(4, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(5, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(6, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(7, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(8, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(9, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(10, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(12, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(13, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(14, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(15, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(16, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(17, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(18, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    ExpensesInfoModel(19, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
  ];

  /// Creates the expenses data source class with required details.
  ExpensesDataSource() {
    _expensesData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.ID),
              DataGridCell<String>(columnName: 'Item', value: e.Item),
              DataGridCell<String>(columnName: 'Category', value: e.Category),
              DataGridCell<String>(
                  columnName: 'Created By', value: e.CreatedBy),
              DataGridCell<String>(columnName: 'Amount', value: e.Amount),
              DataGridCell<String>(columnName: 'Method', value: e.Method),
              DataGridCell<String>(columnName: 'Notes', value: e.Notes),
            ]))
        .toList();
  }

  List<DataGridRow> _expensesData = [];

  @override
  List<DataGridRow> get rows => _expensesData;

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
