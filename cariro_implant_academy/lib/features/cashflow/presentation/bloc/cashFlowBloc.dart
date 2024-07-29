import 'package:cariro_implant_academy/features/cashflow/domain/entities/installmentItemEntity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowItemSummaryEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowSummaryEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/addExpensesUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/addIncomeUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/addSettlementUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/createInstallmentPlanUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/getExpensesByCategoryUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/getInstallmentPlanForUserUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/getSummaryUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/listExpensesUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/payInstallmentUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc_Events.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc_States.dart';

import '../../../../Models/CashFlowSummaryModel.dart';
import '../../../../core/injection_contianer.dart';
import '../../domain/entities/cashFlowEntity.dart';
import '../../domain/useCases/getIncomeByCategoryUseCase.dart';
import '../../domain/useCases/listIncomeUseCase.dart';

class CashFlowBloc extends Bloc<CashFlowBloc_Events, CashFlowBloc_States> {
  final CreateInstallmentPlanUseCase createInstallmentPlanUseCase;
  final GetInstallmentPlanForUserUseCase getInstallmentPlanForUserUseCase;
  final PayInstallmentUseCase payInstallmentUseCase;
  final ListIncomeUseCase listIncomeUseCase;
  final ListExpensesUseCase listExpensesUseCase;
  final GetSummaryUseCase getSummaryUseCase;
  final GetIncomeByCategoryUseCase getIncomeByCategoryUseCase;
  final GetExpensesByCategoryUseCase getExpensesByCategoryUseCase;
  final AddIncomeUseCase addIncomeUseCase;
  final AddExpensesUseCase addExpensesUseCase;
  final AddSettlementUseCase addSettlementUseCase;

  CashFlowBloc({
    required this.createInstallmentPlanUseCase,
    required this.getInstallmentPlanForUserUseCase,
    required this.payInstallmentUseCase,
    required this.listIncomeUseCase,
    required this.listExpensesUseCase,
    required this.getSummaryUseCase,
    required this.getIncomeByCategoryUseCase,
    required this.getExpensesByCategoryUseCase,
    required this.addIncomeUseCase,
    required this.addExpensesUseCase,
    required this.addSettlementUseCase,
  }) : super(CashFlowBloC_LoadingCashFlowState()) {
    on<CashFlowBloc_GetInstallmentForUserEvent>(
      (event, emit) async {
        emit(CashFlowBloC_LoadingInstallmentState());
        final result = await getInstallmentPlanForUserUseCase(event.id);
        result.fold(
          (l) => emit(CashFlowBloC_LoadingInstallmentErrorState(message: l.message ?? "")),
          (r) => emit(CashFlowBloC_LoadedInstallmentSuccessfullyState(
            data: r,
            calculationsOnly: false,
          )),
        );
      },
    );
    on<CashFlowBloc_PayInstallmentEvent>(
      (event, emit) async {
        emit(CashFlowBloC_PayingInstallmentState());
        final result = await payInstallmentUseCase(event.params);
        result.fold(
          (l) => emit(CashFlowBloC_PayingInstallmentErrorState(message: l.message ?? "")),
          (r) => emit(CashFlowBloC_PayedInstallmentSuccessfullyState()),
        );
      },
    );
    on<CashFlowBloc_CreateInstallmentForUserEvent>(
      (event, emit) async {
        emit(CashFlowBloC_CreatingInstallmentState());
        final result = await createInstallmentPlanUseCase(event.params);
        result.fold(
          (l) => emit(CashFlowBloC_CreatingInstallmentErrorState(message: l.message ?? "")),
          (r) => emit(CashFlowBloC_CreatedInstallmentSuccessfullyState(
            data: r,
            calculationsOnly: event.params.id == null,
          )),
        );
      },
    );
    on<CashFlowBloc_ListIncomeEvent>(
      (event, emit) async {
        emit(CashFlowBloC_LoadingCashFlowState());
        final result = await listIncomeUseCase(event.params);
        result.fold(
          (l) => emit(CashFlowBloC_LoadingCashFlowErrorState(message: l.message ?? "")),
          (r) => emit(CashFlowBloC_LoadedCashFlowSuccessfullyState(data: r)),
        );
      },
    );
    on<CashFlowBloc_ListExpensesEvent>(
      (event, emit) async {
        emit(CashFlowBloC_LoadingCashFlowState());
        final result = await listExpensesUseCase(event.params);
        result.fold(
          (l) => emit(CashFlowBloC_LoadingCashFlowErrorState(message: l.message ?? "")),
          (r) => emit(CashFlowBloC_LoadedCashFlowSuccessfullyState(data: r)),
        );
      },
    );
    on<CashFlowBloc_GetSummaryEvent>(
      (event, emit) async {
        emit(CashFlowBloC_LoadingCashFlowState());
        final result = await getSummaryUseCase(event.filter);
        result.fold(
          (l) => emit(CashFlowBloC_LoadingCashFlowErrorState(message: l.message ?? "")),
          (r) => emit(CashFlowBloC_LoadedCashFlowSummarySuccessfullyState(data: r)),
        );
      },
    );
    on<CashFlowBloc_GetIncomeByCategoryEvent>(
      (event, emit) async {
        emit(CashFlowBloC_LoadingCashFlowState());
        final result = await getIncomeByCategoryUseCase(GetCashFlowByCategoryParams(
          categoryId: event.categoryID,
          filter: event.filter,
        ));
        result.fold(
          (l) => emit(CashFlowBloC_LoadingCashFlowErrorState(message: l.message ?? "")),
          (r) => emit(CashFlowBloC_LoadedCashFlowSummarySuccessfullyState(data: r)),
        );
      },
    );
    on<CashFlowBloc_GetExpensesByCategoryEvent>(
      (event, emit) async {
        emit(CashFlowBloC_LoadingCashFlowState());
        final result = await getExpensesByCategoryUseCase(GetCashFlowByCategoryParams(
          categoryId: event.categoryID,
          filter: event.filter,
        ));
        result.fold(
          (l) => emit(CashFlowBloC_LoadingCashFlowErrorState(message: l.message ?? "")),
          (r) => emit(CashFlowBloC_LoadedCashFlowSummarySuccessfullyState(data: r)),
        );
      },
    );
    on<CashFlowBloc_AddIncomeEvent>(
      (event, emit) async {
        emit(CashFlowBloC_ProcessingCashFlowState());
        final result = await addIncomeUseCase(event.model);
        result.fold(
          (l) => emit(CashFlowBloC_ProcessingCashFlowErrorState(message: l.message ?? "")),
          (r) => emit(CashFlowBloC_ProcessingCashFlowSuccessfullyState()),
        );
      },
    );
    on<CashFlowBloc_AddExpenseEvent>(
      (event, emit) async {
        emit(CashFlowBloC_ProcessingCashFlowState());
        final result = await addExpensesUseCase(AddExpensesParams(
          models: event.models,
          type: event.type,
          isStockItem: event.isStockItem,
          inventory: event.inventory,
          isLab: event.isLab,
        ));
        result.fold(
          (l) => emit(CashFlowBloC_ProcessingCashFlowErrorState(message: l.message ?? "")),
          (r) => emit(CashFlowBloC_ProcessingCashFlowSuccessfullyState()),
        );
      },
    );
    on<CashFlowBloc_AddSettlementEvent>(
      (event, emit) async {
        emit(CashFlowBloC_ProcessingCashFlowState());
        final result = await addSettlementUseCase(AddSettlementParams(
          value: event.value,
          filter: event.filter,
        ));
        result.fold(
          (l) => emit(CashFlowBloC_ProcessingCashFlowErrorState(message: l.message ?? "")),
          (r) => emit(CashFlowBloC_ProcessingCashFlowSuccessfullyState()),
        );
      },
    );
  }
}

class CashFlowDataGridSource extends DataGridSource {
  List<String> columns = [
    "ID",
    "Item",
    "Category",
    "Created by",
    "Amount",
    "Method",
    "Notes",
  ];

  List<CashFlowEntity> models = <CashFlowEntity>[];
  CashFlowType type;

  /// Creates the income data source class with required details.
  CashFlowDataGridSource({required this.type}) {
    init();
  }

  init() {
    if (type == CashFlowType.income) {
      columns = [
        "ID",
        "Date",
        "Category",
        "Created by",
        "Patient",
        "Receipt Id",
        "Payment Log Id",
        "Amount",
      ];
      if (Website.values[sl<SharedPreferences>().getInt("Website") ?? 0] == Website.CIA) {
        _cashFlowData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
                  DataGridCell<int>(columnName: 'ID', value: e.id),
                  DataGridCell<DateTime>(columnName: 'Date', value: e.date),
                  DataGridCell<String>(columnName: 'Category', value: e.category?.name ?? ""),
                  DataGridCell<String>(columnName: 'Name', value: e.patient?.name ?? e.candidate?.name ?? ""),
                  DataGridCell<String>(columnName: 'Created by', value: e.createdBy!.name),
                  DataGridCell<int>(columnName: 'Amount', value: e.price ?? 0),
                  DataGridCell<String>(columnName: 'Payment Method', value: e.paymentMethod?.name ?? "-"),
                ]))
            .toList();
      } else
        _cashFlowData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
                  DataGridCell<int>(columnName: 'ID', value: e.id),
                  DataGridCell<String>(columnName: 'Date', value: e.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.date!)),
                  DataGridCell<String>(columnName: 'Category', value: e.category!.name),
                  DataGridCell<String>(columnName: 'Created by', value: e.createdBy!.name),
                  DataGridCell<String>(columnName: 'Patient', value: e.patient!.name),
                  DataGridCell<int>(columnName: 'Receipt Id', value: e.receiptID),
                  DataGridCell<int>(columnName: 'Payment Log Id', value: e.paymentLogId),
                  DataGridCell<int>(columnName: 'Amount', value: e.price ?? 0),
                ]))
            .toList();
    } else if (type == CashFlowType.expenses) {
      columns = [
        "ID",
        "Item",
        "Date",
        "Category",
        "Supplier",
        "Created by",
        "Amount",
        "Method",
        "Notes",
      ];
      _cashFlowData = models
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<int>(columnName: 'ID', value: e.id),
                DataGridCell<String>(columnName: 'Item', value: e.name),
                DataGridCell<DateTime>(columnName: 'Date', value: e.date),
                DataGridCell<String>(columnName: 'Category', value: e.category!.name),
                DataGridCell<String>(columnName: 'Supplier', value: e.supplier!.name),
                DataGridCell<String>(columnName: 'Created by', value: e.createdBy!.name),
                DataGridCell<int>(columnName: 'Price', value: e.price ?? 0),
                DataGridCell<int>(columnName: 'Count', value: e.count ?? 0),
                DataGridCell<String>(columnName: 'Method', value: e.paymentMethod!.name),
                DataGridCell<String>(columnName: 'Notes', value: e.notes ?? ""),
              ]))
          .toList();
    }
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
        child: Text(
          e.value == null
              ? "-"
              : e.value is DateTime
                  ? DateFormat("dd-MM-yyyy hh:mm a").format(e.value)
                  : e.value.toString(),
        ),
      );
    }).toList());
  }

  Future<bool> updateData(List<CashFlowEntity> newData) async {
    models = newData;
    init();
    notifyListeners();

    return true;
  }
}

class CashFlowSummaryDataGridSource extends DataGridSource {
  List<String> columns = [
    "Category",
    "Amount",
  ];

  List<CashFlowItemSummaryEntity> models = <CashFlowItemSummaryEntity>[];

  /// Creates the income data source class with required details.
  CashFlowSummaryDataGridSource() {
    init();
  }

  init() {
    _cashFlowSummaryData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Category', value: e.category!.name ?? ""),
              DataGridCell<int>(columnName: 'Amount', value: e.total ?? 0),
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

  void updateData(List<CashFlowItemSummaryEntity> newData) {
    models = newData;
    init();
    notifyListeners();
    notifyDataSourceListeners();
  }
}

class CashFlowInstallmentDataGridSource extends DataGridSource {
  List<InstallmentItemEntity> models = <InstallmentItemEntity>[];

  CashFlowInstallmentDataGridSource({required this.models}) {
    init();
  }

  init() {
    _cashFlowSummaryData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: '#', value: e.index == null ? null : e.index! + 1),
              DataGridCell<DateTime>(columnName: 'Due Date', value: e.dueDate),
              DataGridCell<DateTime>(columnName: 'Last Payment Date', value: e.lastDateOfPayment),
              DataGridCell<int>(columnName: 'Amount', value: e.amount),
              DataGridCell<int>(columnName: 'Paid Amount', value: e.paidAmount),
              DataGridCell<bool>(
                columnName: 'Paid',
                value: e.paid,
              ),
            ]))
        .toList();
  }

  List<DataGridRow> _cashFlowSummaryData = [];

  @override
  List<DataGridRow> get rows => _cashFlowSummaryData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: row.getCells().any((element) => (element.columnName == "Paid" && (element.value as bool?) != true)) &&
                row.getCells().any((element) => ((element.columnName == "Due Date" && (element.value as DateTime).isBefore(DateTime.now()))))
            ? Colors.red
            : null,
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            child: e.value is bool
                ? Icon(
                    (e.value ?? false) ? Icons.check : Icons.clear,
                    color: (e.value ?? false) ? Colors.green : Colors.red,
                  )
                : Text(
                    e.value == null
                        ? "-"
                        : e.value is DateTime
                            ? DateFormat("dd/MM/yyyy").format(e.value)
                            : e.value.toString(),
                  ),
          );
        }).toList());
  }
}
