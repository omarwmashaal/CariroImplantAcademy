import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class IncomeInfoModel {
  int? ID;
  String? Item;
  String? Category;
  String? CreatedBy;
  String? Amount;
  String? Method;
  String? Notes;

  IncomeInfoModel(
    this.ID,
    this.Item,
    this.Category,
    this.CreatedBy,
    this.Amount,
    this.Method,
    this.Notes,
  );

  static List<IncomeInfoModel> models = <IncomeInfoModel>[];
  static List<String> columns = [
    "ID",
    "Item",
    "Category",
    "Created By",
    "Amount",
    "Method",
    "Notes"
  ];
//IncomeDataSource dataSource = IncomeDataSource();

}

class IncomeDataSource extends DataGridSource {
  List<IncomeInfoModel> models = <IncomeInfoModel>[
    IncomeInfoModel(1, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(2, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(3, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(4, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(5, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(6, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(7, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(8, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(9, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(10, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(12, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(13, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(14, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(15, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(16, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(17, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(18, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
    IncomeInfoModel(19, "Item Name", "Cartgy", "Omar", "230", "Credit Card",
        "aslkjdasdkjlasdkjkl;jasfkjsafl;jl;jasfl;jksafl;j"),
  ];

  /// Creates the income data source class with required details.
  IncomeDataSource() {
    _incomeData = models
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
