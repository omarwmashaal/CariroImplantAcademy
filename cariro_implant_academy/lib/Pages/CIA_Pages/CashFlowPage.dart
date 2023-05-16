import 'package:cariro_implant_academy/Models/PaymentLogModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_Table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../API/PatientAPI.dart';
import '../../Models/CashFlow.dart';
import '../../Models/CashFlowSummaryModel.dart';
import '../../Models/ReceiptModel.dart';
import '../../Widgets/CIA_PopUp.dart';
import '../../Widgets/FormTextWidget.dart';
import '../SharedPages/CashFlowSharedPage.dart';

class CashFlowsSearchPage extends StatefulWidget {
  const CashFlowsSearchPage({Key? key}) : super(key: key);

  @override
  State<CashFlowsSearchPage> createState() => _CashFlowsSearchPageState();
}

class _CashFlowsSearchPageState extends State<CashFlowsSearchPage> {
  CashFlowDataSource i_dataSource = CashFlowDataSource(type: CashFlowType.income);
  CashFlowDataSource e_dataSource = CashFlowDataSource(type: CashFlowType.expenses);
  CashFlowSummaryDataSource eS_dataSource = CashFlowSummaryDataSource(type: CashFlowType.income);
  CashFlowSummaryDataSource iS_dataSource = CashFlowSummaryDataSource(type: CashFlowType.expenses);

  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return CashFlowSharedPage(
      i_dataSource: CashFlowDataSource(type: CashFlowType.income),
      e_dataSource: CashFlowDataSource(type: CashFlowType.expenses),
      eS_dataSource: CashFlowSummaryDataSource(type: CashFlowType.expenses),
      iS_dataSource: CashFlowSummaryDataSource(type: CashFlowType.income),
      onIncomeRowClick: (model) async {
        PaymentLogDataSrouce dataSource = PaymentLogDataSrouce();
        var recRes = await PatientAPI.GetReceiptById(model.receiptID!);
        ReceiptModel receipt = ReceiptModel();
        if (recRes.statusCode == 200) receipt = recRes.result as ReceiptModel;

        await CIA_ShowPopUp(
            width: 1000,
            context: context,
            title: "Receipt And Payment Logs",
            child: Row(
              children: [
                Expanded(
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
                                  Expanded(child: FormTextValueWidget(text: receipt.date ?? "")),
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
                                  receipt.toothReceiptData!.forEach((element) {
                                    r.add(Visibility(
                                      visible: (element.crown ?? 0) != 0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            Expanded(child: FormTextKeyWidget(text: "tooth ${element.tooth.toString()} Crown")),
                                            Expanded(child: FormTextValueWidget(text: (element.crown ?? 0).toString())),
                                          ],
                                        ),
                                      ),
                                    ));
                                    r.add(Visibility(
                                      visible: (element.scaling ?? 0) != 0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            Expanded(child: FormTextKeyWidget(text: "tooth ${element.tooth.toString()} Scaling")),
                                            Expanded(child: FormTextValueWidget(text: (element.scaling ?? 0).toString())),
                                          ],
                                        ),
                                      ),
                                    ));
                                    r.add(Visibility(
                                      visible: (element.extraction ?? 0) != 0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            Expanded(child: FormTextKeyWidget(text: "tooth ${element.tooth.toString()} Extraction")),
                                            Expanded(child: FormTextValueWidget(text: (element.extraction ?? 0).toString())),
                                          ],
                                        ),
                                      ),
                                    ));
                                    r.add(Visibility(
                                      visible: (element.restoration ?? 0) != 0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            Expanded(child: FormTextKeyWidget(text: "tooth ${element.tooth.toString()} Restoration")),
                                            Expanded(child: FormTextValueWidget(text: (element.restoration ?? 0).toString())),
                                          ],
                                        ),
                                      ),
                                    ));
                                    r.add(Visibility(
                                      visible: (element.rootCanalTreatment ?? 0) != 0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            Expanded(child: FormTextKeyWidget(text: "tooth ${element.tooth.toString()} Root Canal Treatment")),
                                            Expanded(child: FormTextValueWidget(text: (element.rootCanalTreatment ?? 0).toString())),
                                          ],
                                        ),
                                      ),
                                    ));
                                    r.add(Divider());
                                  });
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
                            Expanded(child: FormTextValueWidget(
                                color: receipt.unpaid != 0 ? Colors.red : Colors.black, text: (receipt.unpaid ?? 0).toString())),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: CIA_Table(
                    columnNames: dataSource.columns,
                    dataSource: dataSource,
                    loadFunction: () async {
                      return await dataSource.loadData(id: model.patientId!, receiptId: model.receiptID!);
                    },
                  ),
                ),
              ],
            ));
      },
    );
  }
}
