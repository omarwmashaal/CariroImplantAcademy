import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/paymentLogEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/blocs/receiptBloc.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/blocs/receiptBloc_States.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getPaymentMethodsUseCase.dart';
import 'package:cariro_implant_academy/core/injection_contianer.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../Widgets/CIA_PrimaryButton.dart';
import '../../../../../Widgets/CIA_TextFormField.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../Widgets/SnackBar.dart';
import '../../../../constants/enums/enums.dart';

class PaymentLogTableWidget {
  final BuildContext context;
  final int? patientId;
  final int receiptId;

  PaymentLogTableWidget({
    required this.receiptId,
    required this.context,
    this.patientId = 0,
  });

  void call() {
    ReceiptBloc bloc = context.read<ReceiptBloc>();
    late ReceiptEntity receipt;
    PaymentLogsTableDataSource dataSource = PaymentLogsTableDataSource(bloc: bloc);
    bloc.loadPaymentLogTableData(receiptId: receiptId);
    CIA_ShowPopUp(
      width: double.maxFinite,
      context: context,
      onSave: () {
        if (patientId != null) bloc.getPatientReceipts(patientId!);
      },
      child: BlocConsumer<ReceiptBloc, ReceiptBloc_States>(
        buildWhen: (previous, current) =>
            current is ReceiptBloc_LoadedPaymentLogsSuccessfullyState ||
            current is ReceiptBloc_LoadingPaymentLogsState ||
            current is ReceiptBloc_LoadingPaymentLogsErrorState,
        builder: (context, state) {
          if (state is ReceiptBloc_LoadingPaymentLogsErrorState)
            return BigErrorPageWidget(message: state.message);
          else if (state is ReceiptBloc_LoadingPaymentLogsState)
            return LoadingWidget();
          else if (state is ReceiptBloc_LoadedPaymentLogsSuccessfullyState) {
            receipt = state.receipt;
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(child: FormTextKeyWidget(text: "Date")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: receipt.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(receipt.date!))),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(child: FormTextKeyWidget(text: receipt.patient?.id == null ? "Candidate Id" : "Patient ID")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: (receipt.patient?.id == null ? (receipt.candidate?.id ?? "") : (receipt.patient?.id ?? ""))
                                              .toString())),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(child: FormTextKeyWidget(text: receipt.patient?.name == null ? "Candidate Name" : "Patient Name")),
                                  Expanded(
                                      child: FormTextValueWidget(
                                          text: receipt.patient?.name == null ? (receipt.candidate?.name ?? "") : (receipt.patient?.name ?? ""))),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(child: FormTextKeyWidget(text: "Operator")),
                                  Expanded(child: FormTextValueWidget(text: receipt.operator!.name ?? "")),
                                ],
                              ),
                              SizedBox(height: 10),
                              Column(
                                children: () {
                                  List<Widget> r = [];

                                  var teeth = (receipt.toothReceiptData ?? []).map((e) => e.tooth ?? 0).toSet().toList();
                                  for (var tooth in teeth) {
                                    r.add(Divider());
                                    var toothData = (receipt.toothReceiptData ?? [])
                                        .where((element) => element.tooth == tooth && (element.price ?? 0) != 0)
                                        .toList();
                                    r.addAll(toothData
                                        .map((e) => Padding(
                                              padding: const EdgeInsets.only(bottom: 10),
                                              child: Row(
                                                children: [
                                                  Expanded(child: FormTextKeyWidget(text: "Tooth ${e.tooth == 0 ? "All" : e.tooth} ${e.name}")),
                                                  Expanded(child: FormTextValueWidget(text: (e.price ?? 0).toString())),
                                                ],
                                              ),
                                            ))
                                        .toList());
                                  }
                                  return r;
                                }(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(child: FormTextKeyWidget(text: "Total")),
                            Expanded(child: FormTextValueWidget(text: (receipt.total ?? 0).toString())),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(child: FormTextKeyWidget(text: "Paid amount")),
                            Expanded(child: FormTextValueWidget(color: Colors.green, text: (receipt.paid ?? 0).toString())),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(child: FormTextKeyWidget(text: "Unpaid amount")),
                            Expanded(
                                child: FormTextValueWidget(
                                    color: receipt.unpaid != 0 ? Colors.red : Colors.black, text: (receipt.unpaid ?? 0).toString())),
                          ],
                        ),
                      ),
                      patientId == null
                          ? Container()
                          : CIA_PrimaryButton(
                              label: "Add payment",
                              onTab: () async {
                                int newPrice = 0;
                                BasicNameIdObjectEntity? paymentMethod;
                                CIA_ShowPopUp(
                                  height: 200,
                                  context: context,
                                  onSave: () => bloc.addPayment(
                                    patientId: patientId!,
                                    receiptId: receiptId,
                                    paidAmount: newPrice,
                                    paymentMethodId: paymentMethod?.id,
                                  ),
                                  child: Column(
                                    children: [
                                      CIA_TextFormField(
                                        label: "New payment",
                                        isNumber: true,
                                        controller: TextEditingController(),
                                        onChange: (v) => newPrice = int.parse(v),
                                        validator: (value) {
                                          if (int.parse(value) >= receipt.unpaid!) value = receipt.unpaid!.toString();
                                          return value;
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      CIA_DropDownSearchBasicIdName(
                                        onClear: () {
                                          paymentMethod = null;
                                        },
                                        label: "Payment Method",
                                        asyncUseCase: sl<GetPaymentMethodsUseCase>(),
                                        onSelect: (value) {
                                          paymentMethod = value;
                                        },
                                        selectedItem: paymentMethod,
                                      ),
                                    ],
                                  ),
                                );
                              })
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      FormTextKeyWidget(text: "Payment log for receipt Id $receiptId"),
                      Expanded(
                        child: TableWidget(
                          dataSource: dataSource,
                        ),
                      ),
                      FormTextKeyWidget(
                          text: "Total paid ${() {
                        int paid = 0;
                        dataSource.models.forEach((element) {
                          paid += element.paidAmount ?? 0;
                        });
                        return paid.toString();
                      }()}"),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        },
        listener: (context, state) {
          if (state is ReceiptBloc_LoadedPaymentLogsSuccessfullyState)
            dataSource.updateData(state.paymentLogs);
          else if (state is ReceiptBloc_RemovedPaymentSuccessfullyState) {
            bloc.loadPaymentLogTableData(receiptId: receiptId);
            ShowSnackBar(context, isSuccess: true);
            CustomLoader.hide();
          } else if (state is ReceiptBloc_AddedPaymentSuccessfullyState) {
            //  dialogHelper.dismissSingle(context);
            bloc.loadPaymentLogTableData(receiptId: receiptId);
            ShowSnackBar(context, isSuccess: true);
            CustomLoader.hide();
          } else if (state is ReceiptBloc_RemovingPaymentState || state is ReceiptBloc_AddingPaymentState) CustomLoader.show(context);
        },
      ),
    );
  }
}

class PaymentLogsTableDataSource extends DataGridSource {
  ReceiptBloc bloc;
  List<String> columns = ["ID", "Date", "Patient Name", "Patient Id", "Operator", "Paid", "Remove Payment"];

  List<PaymentLogEntity> models = <PaymentLogEntity>[];

  PaymentLogsTableDataSource({required this.bloc}) {
    init();
  }

  init() {
    _data = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<DateTime>(columnName: 'Date', value: e.date),
              DataGridCell<String>(columnName: 'Patient Name', value: e.patient?.name),
              DataGridCell<int>(columnName: 'Patient Id', value: e.patientId),
              DataGridCell<String>(columnName: 'Operator', value: e.operator!.name),
              DataGridCell<int>(columnName: 'Paid', value: e.paidAmount),
              DataGridCell<String>(columnName: 'Payment Method', value: e.paymentMethod?.name ?? "-"),
              DataGridCell<Widget>(
                  columnName: 'Remove Payment',
                  value: IconButton(
                    onPressed: () => bloc.removePayment(paymentId: e.id!),
                    icon: Icon(Icons.remove),
                  )),
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
        child: e.value is Widget
            ? e.value
            : Text(
                e.value is DateTime ? DateFormat("dd-MM-yyyy hh:mm a").format(e.value) : e.value.toString(),
              ),
      );
    }).toList());
  }

  Future<bool> updateData(List<PaymentLogEntity> newData) async {
    models = newData;
    init();
    notifyListeners();

    return true;
  }
}
