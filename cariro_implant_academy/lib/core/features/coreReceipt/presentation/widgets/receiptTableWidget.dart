import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/blocs/receiptBloc.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/blocs/receiptBloc_States.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/widgets/paymentLogTableWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../Widgets/FormTextWidget.dart';

class ReceiptTableWidget {
  final BuildContext context;
  final int patientId;

  ReceiptTableWidget({
    required this.context,
    required this.patientId,
  });

  void call() {
    ReceiptTableDataSource dataSource = ReceiptTableDataSource();
    ReceiptBloc bloc = context.read<ReceiptBloc>();
    bloc.getPatientReceipts(patientId);
    CIA_ShowPopUp(
      width: 900,
      context: context,
      child: BlocConsumer<ReceiptBloc, ReceiptBloc_States>(
        buildWhen: (previous, current) => current is ReceiptBloc_LoadedReceiptsSuccessfullyState || current is ReceiptBloc_LoadingReceiptsErrorState,
        builder: (context, state) {
          if (state is ReceiptBloc_LoadingReceiptsErrorState) return BigErrorPageWidget(message: state.message);
          return Column(
            children: [
              FormTextKeyWidget(text: "Click on receipt to view payment log"),
              Expanded(
                child: TableWidget(
                  dataSource: dataSource,
                  onCellClick: (id) {
                    PaymentLogTableWidget(
                    context: context,
                    receiptId: id,
                    patientId: patientId,
                  )();
                  },
                ),
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state is ReceiptBloc_LoadedReceiptsSuccessfullyState) dataSource.updateData(state.data);
        },
      ),
    );
  }
}

class ReceiptTableDataSource extends DataGridSource {
  List<String> columns = [
    "ID",
    "Date",
    "Patient Name",
    "Patient Id",
    "Operator",
    "Paid",
    "Unpaid",
    "Total",
  ];

  List<ReceiptEntity> models = <ReceiptEntity>[];

  ReceiptTableDataSource() {
    init();
  }

  init() {
    _data = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Date', value: e.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.date!)),
              DataGridCell<String>(columnName: 'Patient Name', value: e.patient!.name),
              DataGridCell<int>(columnName: 'Patient Id', value: e.patientId!),
              DataGridCell<String>(columnName: 'Operator', value: e.operator!.name),
              DataGridCell<int>(columnName: 'Paid', value: e.paid),
              DataGridCell<int>(columnName: 'Unpaid', value: e.unpaid),
              DataGridCell<int>(columnName: 'Total', value: e.total),
            ]))
        .toList();
  }

  List<DataGridRow> _data = [];

  @override
  List<DataGridRow> get rows => _data;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          e.value.toString(),
          style: TextStyle(color: e.columnName.toLowerCase() == "unpaid" && e.value != 0 ? Colors.red : Colors.black),
        ),
      );
    }).toList());
  }

  Future<bool> updateData(List<ReceiptEntity> newData) async {
    models = newData;
    init();
    notifyListeners();

    return true;
  }
}
