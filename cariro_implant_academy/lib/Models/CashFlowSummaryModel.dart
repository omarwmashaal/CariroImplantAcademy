import 'package:cariro_implant_academy/API/CashFlowAPI.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'API_Response.dart';

class CashFlowItemSummaryModel{
  DropDownDTO? category;
  int? total;

  CashFlowItemSummaryModel.fromJson(Map<String, dynamic> json) {
    category = DropDownDTO.fromJson((json['category']??Map<String,dynamic>()));
    total = json['total'];

  }
  CashFlowItemSummaryModel({this.category,this.total});



}

class CashFlowSummaryModel{
  String? from;
  String? to;
  DropDownDTO? category;
  List<CashFlowItemSummaryModel>? income;
  List<CashFlowItemSummaryModel>? expenses;
  CashFlowSummaryModel.fromJson(Map<String, dynamic> json) {
    from = CIA_DateConverters.fromBackendToDateOnly(json['from']);
    to = CIA_DateConverters.fromBackendToDateOnly(json['to']);
    category = DropDownDTO.fromJson((json['category']??Map<String,dynamic>()) as Map<String,dynamic>);
    income = ((json['income']??[]) as List<dynamic>).map((e) => CashFlowItemSummaryModel.fromJson(e as Map<String,dynamic>)).toList();
    expenses = ((json['expenses']??[]) as List<dynamic>).map((e) => CashFlowItemSummaryModel.fromJson(e as Map<String,dynamic>)).toList();

  }



}

enum CashFlowType{
  income,expenses
}
class CashFlowSummaryDataSource extends DataGridSource {
  List<String> columns = [
    "Category",
    "Amount",
  ];

  CashFlowType type;
  List<CashFlowItemSummaryModel> models = <CashFlowItemSummaryModel>[];
  /// Creates the income data source class with required details.
  CashFlowSummaryDataSource({required this.type}) {
    init();
  }

  init() {
    _cashFlowSummaryData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'Category', value: e.category!.name??""),
      DataGridCell<int>(columnName: 'Amount', value: e.total??0),

    ]))
        .toList();
  }

  List<DataGridRow> _cashFlowSummaryData = [];

  @override
  List<DataGridRow> get rows => _cashFlowSummaryData;

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

  Future<API_Response> loadData(String filter) async {
    late API_Response response;

    response = await CashFlowAPI.GetSummary(filter);
    if (response.statusCode == 200) {
      var result = response.result as CashFlowSummaryModel;
      if(type==CashFlowType.income)
        models = result.income!;
      else if(type==CashFlowType.expenses)
        models = result.expenses!;
    }

    init();
    notifyListeners();
    notifyDataSourceListeners();


    return response;
  }


}
