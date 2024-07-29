import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/features/coreStock/domain/usecases/consumeItemById.dart';
import 'package:cariro_implant_academy/features/stock/data/models/stockModel.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockEntity.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockLogEntity.dart';
import 'package:cariro_implant_academy/features/stock/domain/usecases/getLabStockUseCase.dart';
import 'package:cariro_implant_academy/features/stock/domain/usecases/getStockLogUseCase.dart';
import 'package:cariro_implant_academy/features/stock/presentation/bloc/stockBloc_Events.dart';
import 'package:cariro_implant_academy/features/stock/presentation/bloc/stockBloc_States.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/constants/enums/enums.dart';
import '../../domain/usecases/getStockUseCase.dart';

class StockBloc extends Bloc<StockBloc_Events, StockBloc_States> {
  final GetStockUseCase getStockUseCase;
  final GetLabStockUseCase getLabStockUseCase;
  final GetStockLogUseCase getStockLogUseCase;
  final ConsumeItemByIdUseCase consumeItemByIdUseCase;

  StockBloc({
    required this.getStockLogUseCase,
    required this.getStockUseCase,
    required this.getLabStockUseCase,
    required this.consumeItemByIdUseCase,
  }) : super(StockBloc_LoadingState()) {
    on<StockBloc_GetStockEvent>(
      (event, emit) async {
        emit(StockBloc_LoadingState());
        if (siteController.getSite() != Website.Lab) {
          final result = await getStockUseCase(event.search);
          result.fold(
            (l) => emit(StockBloc_LoadingErrorState(message: l.message ?? "")),
            (r) => emit(StockBloc_LoadedStockSuccessfullyState(data: r)),
          );
        } else {
          final result = await getLabStockUseCase(event.getLabStockParams ?? GetLabStockParams());
          result.fold(
            (l) => emit(StockBloc_LoadingErrorState(message: l.message ?? "")),
            (r) => emit(StockBloc_LoadedStockSuccessfullyState(data: r)),
          );
        }
      },
    );
    on<StockBloc_GetStockLogEvent>(
      (event, emit) async {
        emit(StockBloc_LoadingState());
        final result = await getStockLogUseCase(event.params);
        result.fold(
          (l) => emit(StockBloc_LoadingErrorState(message: l.message ?? "")),
          (r) => emit(StockBloc_LoadedStockLogSuccessfullyState(data: r)),
        );
      },
    );
    on<StockBloc_ConsumeItemevent>(
      (event, emit) async {
        emit(StockBloc_ConsumingItemsState());
        final result = await consumeItemByIdUseCase(event.params);
        result.fold(
          (l) => emit(StockBloc_ConsumingItemsErrorState(message: l.message ?? "")),
          (r) => emit(StockBloc_ConsumedItemSuccssefullyState()),
        );
      },
    );
  }
}

class StockDataGridSource extends DataGridSource {
  List<String> columns = ["ID", "Name", "Category", "Count", "Add More"];
  BuildContext context;
  List<dynamic> models = <dynamic>[];
  StockBloc bloc;

  /// Creates the income data source class with required details.
  StockDataGridSource({required this.context, required this.bloc}) {
    init();
  }

  init() {
    if (siteController.getSite() == Website.Lab) {
      _stockData = models
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<int>(columnName: 'Id', value: e.id),
                DataGridCell<String>(columnName: 'Type', value: e.labItemType ?? "-"),
                DataGridCell<String>(columnName: 'Company', value: e.companyName ?? "-"),
                DataGridCell<String>(columnName: 'Shade', value: e.shadeName ?? "-"),
                DataGridCell<String>(columnName: 'Code', value: e.code ?? "-"),
                DataGridCell<String>(columnName: 'Category', value: e.category?.name ?? "-"),
                DataGridCell<String>(columnName: 'Consumed', value: e.consumed == true ? "Yes" : "No"),
                DataGridCell<int>(columnName: 'Count', value: e.count),
                DataGridCell<int>(columnName: 'Consume Count', value: e.consumeCount),
              ]))
          .toList();
    } else
      _stockData = models
          .map<DataGridRow>((e) => DataGridRow(cells: [
                ...[
                  DataGridCell<int>(columnName: 'ID', value: e.id),
                  DataGridCell<String>(columnName: 'Name', value: e.name),
                  DataGridCell<String>(columnName: 'Category', value: e.category!.name),
                  DataGridCell<int>(columnName: 'Count', value: e.count),

                  /* DataGridCell<Widget>(
                  columnName: 'Add More',
                  value: IconButton(
                    onPressed: () {
                      /*
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
              );*/
                    },
                    icon: Icon(Icons.add),
                  )),
              ,*/
                ],
                ...((siteController.getRole()?.contains("admin") ?? false) ||
                        (siteController.getRole()?.contains("instructor") ?? false) ||
                        (siteController.getRole()?.contains("assistant") ?? false)
                    ? [
                        DataGridCell<Widget>(
                            columnName: 'Consume Item',
                            value: IconButton(
                              onPressed: () {
                                int number = 0;
                                CIA_ShowPopUp(
                                  title: "Consume ${e.name}",
                                  onSave: () async {
                                    bloc.add(StockBloc_ConsumeItemevent(params: ConsumeItemByIdParams(count: number, id: e.id)));
                                    return false;
                                  },
                                  context: context,
                                  child: BlocConsumer(
                                    listener: (context, state) {
                                      if (state is StockBloc_ConsumingItemsState)
                                        CustomLoader.show(context);
                                      else {
                                        CustomLoader.hide();
                                        if (state is StockBloc_ConsumingItemsErrorState)
                                          ShowSnackBar(context, isSuccess: false, message: state.message);
                                        else if (state is StockBloc_ConsumedItemSuccssefullyState) {
                                          ShowSnackBar(context, isSuccess: true);
                                          dialogHelper.dismissSingle(context);
                                          bloc.add(StockBloc_GetStockEvent());
                                        }
                                      }
                                    },
                                    bloc: bloc,
                                    builder: (context, state) {
                                      return CIA_TextFormField(
                                        label: "Number",
                                        controller: TextEditingController(),
                                        isNumber: true,
                                        onChange: (v) => number = int.parse(v),
                                      );
                                    },
                                  ),
                                );
                              },
                              icon: Icon(Icons.remove),
                            ))
                      ]
                    : [])
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
        child: e.value is Widget
            ? e.value
            : Text(
                e.value.toString(),
              ),
      );
    }).toList());
  }

  String? search;

  Future<bool> updateData(List<dynamic> newData) async {
    models = newData;
    init();
    notifyListeners();

    return true;
  }
}

class StockLogsDataGridSource extends DataGridSource {
  List<String> columns = [
    "ID",
    "Date",
    "Name",
    "Operator",
    "Count",
    "Status",
  ];

  List<StockLogEntity> models = <StockLogEntity>[];

  /// Creates the income data source class with required details.
  StockLogsDataGridSource() {
    init();
  }

  init() {
    if (siteController.getSite() == Website.Lab)
      _stockLogsData = models
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<int>(columnName: 'ID', value: e.id),
                DataGridCell<DateTime>(columnName: 'Date', value: e.date),
                DataGridCell<String>(columnName: 'Name', value: e.name),
                DataGridCell<String>(columnName: 'Operator', value: e.operator!.name),
                DataGridCell<int>(columnName: 'Count', value: e.count),
                DataGridCell<String>(columnName: 'Status', value: e.status ?? ""),
              ]))
          .toList();
    else
      _stockLogsData = models
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<int>(columnName: 'ID', value: e.id),
                DataGridCell<DateTime>(columnName: 'Date', value: e.date),
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
      /*if (e.columnName == "Status")
        return Container(
          alignment: Alignment.center,
          child: Text(
            e.value is DateTime ? DateFormat("dd-MM-yyyy hh:mm a").format(e.value) : e.value.toString(),
            style: TextStyle(
                color: e.value == "Added"
                    ? Colors.green
                    : e.value == "Removed"
                        ? Colors.red
                        : Colors.black),
          ),
        );*/
      return Container(
        alignment: Alignment.center,
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  Future<bool> updateData(List<StockLogEntity> newData) async {
    models = newData;
    init();
    notifyListeners();

    return true;
  }
}
