import 'dart:js_interop';

import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/labRequestEntityl.dart';

class LabRequestItemReceiptWidget extends StatefulWidget {
  LabRequestItemReceiptWidget({
    Key? key,
    required this.request,
    this.viewOnly = false,
  }) : super(key: key);
  LabRequestEntity request;
  bool viewOnly;

  @override
  State<LabRequestItemReceiptWidget> createState() => _LabRequestItemReceiptWidgetState();
}

class _LabRequestItemReceiptWidgetState extends State<LabRequestItemReceiptWidget> {
  @override
  void initState() {
    super.initState();
  }

  var overAllTotal = 0.obs;

  recalculateTotal() {
    var tempTotal = (widget.request.labFees ?? 0);
    widget.request.labRequestStepItems!.forEach((element) {
      tempTotal += element.labPrice ?? 0;
    });
    overAllTotal.value = tempTotal;
  }

  @override
  Widget build(BuildContext context) {
    recalculateTotal();
    return Column(
      children: [
        Expanded(
          child: widget.viewOnly
              ? ListView(
                  children: widget.request.labRequestStepItems!
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: FormTextKeyWidget(
                                      text: "Tooth: ${e.tooth == 0 ? "All" : e.tooth} || ${e.labOption?.name} || ${e.consumedLabItem?.name}")),
                              Expanded(child: FormTextValueWidget(text: "EGP ${e.labPrice}")),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                )
              : ListView(
                  children: widget.request.labRequestStepItems!
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CIA_TextFormField(
                            label: "Tooth: ${e.tooth == 0 ? "All" : e.tooth} || ${e.labOption?.name} || ${e.consumedLabItem?.name}",
                            controller: TextEditingController(text: e.labPrice!.toString()),
                            isNumber: true,
                            onChange: (value) {
                              e.labPrice = int.tryParse(value) ?? e.labPrice ?? 0;
                              recalculateTotal();
                            },
                            suffix: "EGP",
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        widget.viewOnly
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: FormTextKeyWidget(text: "Lab Fees")),
                    Expanded(child: FormTextValueWidget(text: "EGP ${widget.request.labFees ?? 0}")),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: CIA_TextFormField(
                  label: "Lab Fees",
                  controller: TextEditingController(text: (widget.request.labFees ?? 0).toString()),
                  onChange: (value) {
                    widget.request.labFees = int.tryParse(value) ?? widget.request.labFees;
                    recalculateTotal();
                  },
                ),
              ),
        Row(
          children: [
            FormTextKeyWidget(
              text: "Paid: EGP ${widget.request.paidAmount ?? 0}",
              secondaryInfo: true,
            ),
            SizedBox(width: 10),
            FormTextKeyWidget(
              text: "Remaining: EGP ${(widget.request.cost ?? 0) - (widget.request.paidAmount ?? 0)}",
              secondaryInfo: true,
            ),
            Expanded(child: SizedBox()),
            Obx(() => FormTextKeyWidget(text: "Total: EGP ${overAllTotal.value}")),
          ],
        )
      ],
    );
  }
}
