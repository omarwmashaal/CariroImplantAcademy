import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/addPaymentUsecase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/getTodaysReceiptUsecase.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/usecases/getTotalDeptUseCase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../Widgets/CIA_TextFormField.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../Widgets/SnackBar.dart';
import '../../../../constants/enums/enums.dart';
import '../../../../injection_contianer.dart';

class PaymentWidget {
  final int patientId;
  final BuildContext context;
  final Function(String message) onFailure;

  PaymentWidget({
    required this.patientId,
    required this.onFailure,
    required this.context,
  });

  void call() async {
    if (siteController.getSite() == Website.CIA) {
      var todaysReceiptResult = await sl<GetTodaysReceiptUsecase>()(patientId);
      todaysReceiptResult.fold(
        (l) => onFailure(l.message ?? ""),
        (r) async {
          ReceiptEntity receipt = r;
          int newPayment = 0;
          int debt = 0;
          await sl<GetTotalDebtUsecase>()(patientId).then((value) => value.fold(
                (l) => onFailure(l.message ?? ""),
                (r) async {
                  debt = r;
                  if (debt != 0) {
                    await CIA_ShowPopUp(
                        width: 500,
                        context: context,
                        title: "Receipt",
                        onSave: () async {
                          if (newPayment != 0) {
                            await sl<AddPaymentUseCase>()(AddPaymentParams(
                              patientId: patientId,
                              receiptId: receipt.id!,
                              paidAmount: newPayment,
                            )).then((value) => value.fold(
                                  (l) {
                                    ShowSnackBar(context, isSuccess: false, message: "Failed to add payment");
                                  },
                                  (r) {
                                    ShowSnackBar(context, isSuccess: true, message: "Added Payment");
                                  },
                                ));
                          }
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Patient total debt")),
                                        Expanded(child: FormTextValueWidget(color: debt != 0 ? Colors.red : Colors.black, text: debt.toString())),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Date")),
                                        Expanded(
                                            child: FormTextValueWidget(
                                          text: receipt.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(receipt.date!),
                                        )),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Patient ID")),
                                        Expanded(child: FormTextValueWidget(text: (receipt.patient!.id ?? "").toString())),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(child: FormTextKeyWidget(text: "Patient Name")),
                                        Expanded(child: FormTextValueWidget(text: receipt.patient!.name ?? "")),
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
                                                        Expanded(child: FormTextKeyWidget(text: "Tooth ${e.tooth==0?"All":e.tooth} ${e.name}")),
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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: CIA_TextFormField(
                                label: "New Payment",
                                isNumber: true,
                                controller: TextEditingController(text: "0"),
                                suffix: "EGP",
                                onChange: (v) => newPayment = int.parse(v),
                              ),
                            ),
                          ],
                        ));
                  }
                },
              ));
          return null;
        },
      );
    } else if (siteController.getSite() == Website.Clinic) {
      {
        var todaysReceiptResult = await sl<GetTodaysReceiptUsecase>()(patientId);
        todaysReceiptResult.fold(
          (l) => onFailure(l.message ?? ""),
          (r) async {
            ReceiptEntity receipt = r;
            int newPayment = 0;
            int debt = 0;
            await sl<GetTotalDebtUsecase>()(patientId).then((value) => value.fold(
                  (l) => onFailure(l.message ?? ""),
                  (r) async {
                    debt = r;
                    if (debt != 0) {
                      await CIA_ShowPopUp(
                          width: 500,
                          context: context,
                          title: "Receipt",
                          onSave: () async {
                            if (newPayment != 0) {
                              await sl<AddPaymentUseCase>()(AddPaymentParams(
                                patientId: patientId,
                                receiptId: receipt.id!,
                                paidAmount: newPayment,
                              )).then((value) => value.fold(
                                    (l) {
                                      ShowSnackBar(context, isSuccess: false, message: "Failed to add payment");
                                    },
                                    (r) {
                                      ShowSnackBar(context, isSuccess: true, message: "Added Payment");
                                    },
                                  ));
                            }
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(child: FormTextKeyWidget(text: "Patient total debt")),
                                          Expanded(child: FormTextValueWidget(color: debt != 0 ? Colors.red : Colors.black, text: debt.toString())),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(child: FormTextKeyWidget(text: "Date")),
                                          Expanded(
                                              child: FormTextValueWidget(
                                            text: receipt.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(receipt.date!),
                                          )),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(child: FormTextKeyWidget(text: "Patient ID")),
                                          Expanded(child: FormTextValueWidget(text: (receipt.patient!.id ?? "").toString())),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(child: FormTextKeyWidget(text: "Patient Name")),
                                          Expanded(child: FormTextValueWidget(text: receipt.patient!.name ?? "")),
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
                                        children: [],
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
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: CIA_TextFormField(
                                  label: "New Payment",
                                  isNumber: true,
                                  controller: TextEditingController(text: "0"),
                                  suffix: "EGP",
                                  onChange: (v) => newPayment = int.parse(v),
                                ),
                              ),
                            ],
                          ));
                    }
                  },
                ));
            return null;
          },
        );
      }
    }
  }
}
