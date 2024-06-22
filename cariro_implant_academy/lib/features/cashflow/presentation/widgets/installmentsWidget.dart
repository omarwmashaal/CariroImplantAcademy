import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextField.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/tableWidget.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/installmentPlanEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/createInstallmentPlanUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/payInstallmentUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc_Events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InstallmentsWidget extends StatelessWidget {
  InstallmentsWidget({
    super.key,
    required this.installmentPlan,
    required this.cashFlowBloc,
    required this.userId,
  });
  InstallmentPlanEntity installmentPlan;
  int userId;

  CashFlowBloc cashFlowBloc;
  late CashFlowInstallmentDataGridSource dataGridSource;
  @override
  Widget build(BuildContext context) {
    dataGridSource = CashFlowInstallmentDataGridSource(models: installmentPlan?.installments ?? []);
    int amountToBePaid = ((installmentPlan.installments ?? [])
                .firstWhereOrNull(
                  (element) => element.paid != true,
                )
                ?.amount ??
            0) -
        ((installmentPlan.installments ?? [])
                .firstWhereOrNull(
                  (element) => element.paid != true,
                )
                ?.paidAmount ??
            0);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: FormTextKeyWidget(text: "Start Date")),
                        SizedBox(width: 10),
                        Expanded(
                            child:
                                FormTextKeyWidget(text: installmentPlan == null ? "" : DateFormat("dd/MM/yyyy").format(installmentPlan!.startDate!))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: FormTextKeyWidget(text: "End Date")),
                        SizedBox(width: 10),
                        Expanded(
                            child: FormTextKeyWidget(
                                text: installmentPlan?.endDate == null ? "" : DateFormat("dd/MM/yyyy").format(installmentPlan!.endDate!))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: FormTextKeyWidget(text: "Next Payment")),
                        SizedBox(width: 10),
                        Expanded(
                          child: FormTextKeyWidget(
                            text: installmentPlan?.installments == null
                                ? ""
                                : DateFormat("dd/MM/yyyy").format((installmentPlan!.installments ?? [])
                                    .firstWhere((element) => (element.dueDate!).isAfter(DateTime.now()))
                                    .dueDate!),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: FormTextKeyWidget(text: "Total Amount")),
                        SizedBox(width: 10),
                        Expanded(
                          child: FormTextKeyWidget(
                            text: (installmentPlan?.total ?? 0).toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: FormTextKeyWidget(text: "Paid Amount")),
                        SizedBox(width: 10),
                        Expanded(
                          child: FormTextKeyWidget(
                            text: (installmentPlan?.paidAmount ?? 0).toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: FormTextKeyWidget(text: "Status")),
                        SizedBox(width: 10),
                        Expanded(
                          child: FormTextKeyWidget(
                            text: (installmentPlan?.status?.name ?? ""),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: FormTextKeyWidget(text: "Interval")),
                        SizedBox(width: 10),
                        Expanded(
                          child: FormTextKeyWidget(
                            text: (installmentPlan?.installmentInterval?.name ?? ""),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: ((installmentPlan.installments?.isNotEmpty) ?? false) && installmentPlan.userId == null,
              child: Center(
                child: CIA_PrimaryButton(
                    label: "Create Plan Now!",
                    onTab: () {
                      cashFlowBloc.add(CashFlowBloc_CreateInstallmentForUserEvent(
                        params: CreateInstallmentPlanParams(
                          id: userId,
                          total: installmentPlan.total!,
                          startDate: installmentPlan.startDate!,
                          numberOfPayments: installmentPlan!.numberOfPayments!,
                          interval: installmentPlan!.installmentInterval!,
                        ),
                      ));
                    }),
              ),
            ),
            Visibility(
              visible: ((installmentPlan.installments?.isNotEmpty) ?? false) && installmentPlan.id != null,
              child: Expanded(
                child: Column(children: [
                  CIA_TextFormField(
                    label: "Amount To Be Paid",
                    controller: TextEditingController(text: amountToBePaid.toString()),
                    onChange: (v) => amountToBePaid = int.tryParse(v) ?? 0,
                  ),
                  CIA_PrimaryButton(
                      label: "Add Payment",
                      onTab: () {
                        cashFlowBloc.add(CashFlowBloc_PayInstallmentEvent(
                          params: PayInstallmentParams(
                            installmentPlanId: installmentPlan.id!,
                            value: amountToBePaid,
                          ),
                        ));
                      }),
                ]),
              ),
            )
          ],
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormTextKeyWidget(
              text: "Installments",
            ),
          ),
        ),
        Expanded(
          child: TableWidget(
            dataSource: dataGridSource,
          ),
        ),
      ],
    );
  }
}
