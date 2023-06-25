import 'package:cariro_implant_academy/API/StockAPI.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/CashFlow.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:cariro_implant_academy/Widgets/CIA_FutureBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../API/CashFlowAPI.dart';
import '../API/SettingsAPI.dart';
import '../Widgets/CIA_DropDown.dart';
import '../Widgets/CIA_PopUp.dart';
import '../Widgets/CIA_TextFormField.dart';
import '../Widgets/MultiSelectChipWidget.dart';
import '../Widgets/SnackBar.dart';
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
    data['operator'] = this.operator == null ? null : this.operator!.toJson();
    return data;
  }
//IncomeDataSource dataSource = IncomeDataSource();
}

class StockDataSource extends DataGridSource {
  List<String> columns = ["ID", "Name", "Category", "Count", "Add More"];
  BuildContext context;
  List<StockModel> models = <StockModel>[];

  /// Creates the income data source class with required details.
  StockDataSource({required this.context}) {
    init();
  }

  init() {
    _stockData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(columnName: 'Category', value: e.category!.name),
              DataGridCell<int>(columnName: 'Count', value: e.count),
              DataGridCell<Widget>(
                  columnName: 'Add More',
                  value: IconButton(
                    onPressed: () {
                      var newExpense = CashFlowModel();
                      CIA_ShowPopUp(
                        context: context,
                        width: 1000,
                        height: 400,
                        title: "Add Item Number",
                        onSave: () async {
                          var res = await StockAPI.AddItemNumber(newExpense);
                          if (res.statusCode == 200) {
                            ShowSnackBar(context, isSuccess: true, title: "Success", message: "Entries Added!");
                          } else
                            ShowSnackBar(context, isSuccess: false, title: "Failed", message: res.errorMessage ?? "");
                          loadData(search: search);
                        },
                        child: CIA_FutureBuilder(
                          loadFunction: StockAPI.GetStockById(e.id!),
                          onSuccess: (data) {
                            var stockItem = (data as StockModel);
                            newExpense.id = stockItem.id;
                            newExpense.name = stockItem.name;
                            newExpense.count = 0;
                            newExpense.category = stockItem.category;
                            newExpense.categoryId = stockItem.categoryId;

                            bool newPaymentMethod = false;
                            bool newSupplier = false;
                            return StatefulBuilder(builder: (context, _setState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: 10),
                                  CIA_TextFormField(
                                    label: "Category",
                                    enabled: false,
                                    controller: TextEditingController(text: stockItem.category!.name ?? ""),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CIA_MultiSelectChipWidget(
                                          onChange: (item, isSelected) => _setState(() => newPaymentMethod = isSelected),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(label: "New Payment Method"),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: newPaymentMethod
                                            ? CIA_TextFormField(
                                                label: "Payment Method",
                                                onChange: (value) {
                                                  newExpense.paymentMethod = DropDownDTO(name: value);
                                                  newExpense.paymentMethodId = null;
                                                },
                                                controller: TextEditingController(text: newExpense.paymentMethod!.name ?? ""),
                                              )
                                            : CIA_DropDownSearch(
                                                label: "Payment Method",
                                                asyncItems: SettingsAPI.GetPaymentMethods,
                                                onSelect: (value) {
                                                  newExpense.paymentMethod = value;
                                                  newExpense.paymentMethodId = value.id;
                                                },
                                                selectedItem: newExpense.paymentMethod,
                                              ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CIA_MultiSelectChipWidget(
                                          onChange: (item, isSelected) => _setState(() => newSupplier = isSelected),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(label: "New Supplier"),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: newSupplier
                                            ? CIA_TextFormField(
                                                label: "Supplier",
                                                onChange: (value) {
                                                  newExpense.supplier = DropDownDTO(name: value);
                                                  newExpense.supplierId = null;
                                                },
                                                controller: TextEditingController(text: newExpense.supplier!.name ?? ""),
                                              )
                                            : CIA_DropDownSearch(
                                                label: "Supplier",
                                                asyncItems: SettingsAPI.GetSuppliers,
                                                onSelect: (value) {
                                                  newExpense.supplier = value;
                                                  newExpense.supplierId = value.id;
                                                },
                                                selectedItem: newExpense.supplier,
                                              ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CIA_TextFormField(label: "Name", enabled: false, controller: TextEditingController(text: newExpense.name ?? "")),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_TextFormField(
                                          isNumber: true,
                                          onChange: (value) {
                                            if (value == null || value == "") value = "0";
                                            newExpense.price = int.parse(value);
                                          },
                                          label: "Price",
                                          controller: TextEditingController(text: (newExpense.price ?? 0).toString()),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_TextFormField(
                                          isNumber: true,
                                          onChange: (value) {
                                            if (value == null || value == "") value = "0";
                                            newExpense.count = int.parse(value);
                                          },
                                          label: "Count",
                                          controller: TextEditingController(text: (newExpense.count ?? 0).toString()),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_TextFormField(
                                          onChange: (value) => newExpense.notes = value,
                                          label: "Notes",
                                          controller: TextEditingController(text: newExpense.notes ?? ""),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  )
                                ],
                              );
                            });
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.add),
                  )),DataGridCell<Widget>(
                  columnName: 'Add More',
                  value: IconButton(
                    onPressed: () {
                      var newExpense = CashFlowModel();
                      CIA_ShowPopUp(
                        context: context,
                        width: 1000,
                        height: 400,
                        title: "Add Item Number",
                        onSave: () async {
                          var res = await StockAPI.AddItemNumber(newExpense);
                          if (res.statusCode == 200) {
                            ShowSnackBar(context, isSuccess: true, title: "Success", message: "Entries Added!");
                          } else
                            ShowSnackBar(context, isSuccess: false, title: "Failed", message: res.errorMessage ?? "");
                          loadData(search: search);
                        },
                        child: CIA_FutureBuilder(
                          loadFunction: StockAPI.GetStockById(e.id!),
                          onSuccess: (data) {
                            var stockItem = (data as StockModel);
                            newExpense.id = stockItem.id;
                            newExpense.name = stockItem.name;
                            newExpense.count = 0;
                            newExpense.category = stockItem.category;
                            newExpense.categoryId = stockItem.categoryId;

                            bool newPaymentMethod = false;
                            bool newSupplier = false;
                            return StatefulBuilder(builder: (context, _setState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: 10),
                                  CIA_TextFormField(
                                    label: "Category",
                                    enabled: false,
                                    controller: TextEditingController(text: stockItem.category!.name ?? ""),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CIA_MultiSelectChipWidget(
                                          onChange: (item, isSelected) => _setState(() => newPaymentMethod = isSelected),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(label: "New Payment Method"),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: newPaymentMethod
                                            ? CIA_TextFormField(
                                                label: "Payment Method",
                                                onChange: (value) {
                                                  newExpense.paymentMethod = DropDownDTO(name: value);
                                                  newExpense.paymentMethodId = null;
                                                },
                                                controller: TextEditingController(text: newExpense.paymentMethod!.name ?? ""),
                                              )
                                            : CIA_DropDownSearch(
                                                label: "Payment Method",
                                                asyncItems: SettingsAPI.GetPaymentMethods,
                                                onSelect: (value) {
                                                  newExpense.paymentMethod = value;
                                                  newExpense.paymentMethodId = value.id;
                                                },
                                                selectedItem: newExpense.paymentMethod,
                                              ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CIA_MultiSelectChipWidget(
                                          onChange: (item, isSelected) => _setState(() => newSupplier = isSelected),
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(label: "New Supplier"),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: newSupplier
                                            ? CIA_TextFormField(
                                                label: "Supplier",
                                                onChange: (value) {
                                                  newExpense.supplier = DropDownDTO(name: value);
                                                  newExpense.supplierId = null;
                                                },
                                                controller: TextEditingController(text: newExpense.supplier!.name ?? ""),
                                              )
                                            : CIA_DropDownSearch(
                                                label: "Supplier",
                                                asyncItems: SettingsAPI.GetSuppliers,
                                                onSelect: (value) {
                                                  newExpense.supplier = value;
                                                  newExpense.supplierId = value.id;
                                                },
                                                selectedItem: newExpense.supplier,
                                              ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CIA_TextFormField(label: "Name", enabled: false, controller: TextEditingController(text: newExpense.name ?? "")),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_TextFormField(
                                          isNumber: true,
                                          onChange: (value) {
                                            if (value == null || value == "") value = "0";
                                            newExpense.price = int.parse(value);
                                          },
                                          label: "Price",
                                          controller: TextEditingController(text: (newExpense.price ?? 0).toString()),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_TextFormField(
                                          isNumber: true,
                                          onChange: (value) {
                                            if (value == null || value == "") value = "0";
                                            newExpense.count = int.parse(value);
                                          },
                                          label: "Count",
                                          controller: TextEditingController(text: (newExpense.count ?? 0).toString()),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_TextFormField(
                                          onChange: (value) => newExpense.notes = value,
                                          label: "Notes",
                                          controller: TextEditingController(text: newExpense.notes ?? ""),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  )
                                ],
                              );
                            });
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.add),
                  )),
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
        child: e.value is Widget? e.value: Text(
          e.value.toString(),
        ),
      );
    }).toList());
  }

  String? search;
  Future<bool> loadData({String? search}) async {
    this.search = search;
    late API_Response response;

    response = await StockAPI.GetAllStock(search: search);
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
              DataGridCell<String>(columnName: 'Date', value: e.date ?? ""),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(columnName: 'Operator', value: e.operator!.name),
              DataGridCell<int>(columnName: 'Count', value: e.count),
              DataGridCell<String>(columnName: 'Status', value: e.status ?? ""),
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
      if (e.columnName == "Status")
        return Container(
          alignment: Alignment.center,
          child: Text(
            e.value.toString(),
            style: TextStyle(
                color: e.value == "Added"
                    ? Colors.green
                    : e.value == "Removed"
                        ? Colors.red
                        : Colors.black),
          ),
        );
      return Container(
        alignment: Alignment.center,
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  Future<bool> loadData({String? search}) async {
    late API_Response response;

    response = await StockAPI.GetStockLogs(search: search);
    if (response.statusCode == 200) {
      models = response.result as List<StockLogModel>;
    }
    init();
    notifyListeners();

    return true;
  }
}
