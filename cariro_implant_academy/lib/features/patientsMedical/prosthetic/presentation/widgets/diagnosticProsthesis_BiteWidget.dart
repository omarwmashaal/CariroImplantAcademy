import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/biteEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/diagnosticImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/scanApplianceEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc_States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../Models/DTOs/DropDownDTO.dart';
import '../../../../../Widgets/CIA_CheckBoxWidget.dart';
import '../../../../../Widgets/CIA_DropDown.dart';
import '../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../Widgets/CIA_TeethChart.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../core/constants/enums/enums.dart';
import '../../../../../core/presentation/widgets/CIA_GestureWidget.dart';
import '../../domain/entities/finalProsthesisDeliveryEntity.dart';
import '../../domain/entities/finalProsthesisHealingCollarEntity.dart';
import '../../domain/entities/finalProsthesisImpressionEntity.dart';
import '../../domain/entities/finalProsthesisTryInEntity.dart';
import '../../domain/entities/prostheticFinalEntity.dart';
import '../../domain/enums/enum.dart';

class DiagnosticProsthesis_BiteWidget extends StatefulWidget {
  DiagnosticProsthesis_BiteWidget({
    Key? key,
    required this.data,
    required this.onDelete,
    required this.index,
  }) : super(key: key);
  BiteEntity data;
  Function() onDelete;
  int index;

  @override
  State<DiagnosticProsthesis_BiteWidget> createState() => _DiagnosticProsthesis_BiteWidgetState();
}

class _DiagnosticProsthesis_BiteWidgetState extends State<DiagnosticProsthesis_BiteWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FormTextKeyWidget(text: "${widget.index}. Bite"),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: CIA_DropDownSearch(
                  label: "Diagnostic",
                  selectedItem: () {
                    if (widget.data.diagnostic != null) {
                      return DropDownDTO(name: widget.data.diagnostic!.name.replaceAll("_", " "));
                    }
                    return null;
                  }(),
                  onSelect: (value) {
                    widget.data.operatorId = siteController.getUserId();
                    widget.data.diagnostic = EnumProstheticDiagnosticBiteDiagnostic.values[value.id!];
                    setState(() {
                      widget.data.operator = BasicNameIdObjectEntity(name: siteController.getUserName());
                      widget.data.date = DateTime.now();
                    });
                  },
                  items: [
                    DropDownDTO(name: "Done", id: 0),
                    DropDownDTO(name: "Needs ReScan", id: 1),
                    DropDownDTO(name: "Needs ReImpression", id: 2),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CIA_DropDownSearch(
                  label: "Next Step",
                  selectedItem: () {
                    if (widget.data.nextStep != null) {
                      return DropDownDTO(name: widget.data.nextStep!.name.replaceAll("_", " "));
                    }
                    return null;
                  }(),
                  onSelect: (value) {
                    widget.data.operatorId = siteController.getUserId();
                    widget.data.nextStep = EnumProstheticDiagnosticBiteNextStep.values[value.id!];
                    setState(() {
                      widget.data.operator = BasicNameIdObjectEntity(name: siteController.getUserName());
                      widget.data.date = DateTime.now();
                    });
                  },
                  items: [
                    DropDownDTO(name: "Scan Appliance", id: 0),
                    DropDownDTO(name: "ReImpression", id: 1),
                    DropDownDTO(name: "ReBite", id: 2),
                  ],
                ),
              ),
              SizedBox(width: 10),
              CIA_CheckBoxWidget(
                text: "Needs Remake",
                onChange: (v) {
                  widget.data.operatorId = siteController.getUserId();
                  if (v) widget.data.scanned = false;
                  setState(() {});
                  return widget.data.needsRemake = v;
                },
                value: widget.data.needsRemake ?? false,
              ),
              SizedBox(width: 10),
              CIA_CheckBoxWidget(
                text: "Scanned",
                onChange: (v) {
                  widget.data.operatorId = siteController.getUserId();
                  if (v) widget.data.needsRemake = false;
                  setState(() {});
                  return widget.data.scanned = v;
                },
                value: widget.data.scanned ?? false,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: FormTextValueWidget(
                      align: TextAlign.center,
                      text: widget.data.operator!.name ?? "",
                      secondaryInfo: true,
                    )),
                    SizedBox(width: 10),
                    Expanded(
                        child: CIA_GestureWidget(
                      onTap: () {
                        CIA_PopupDialog_DateTimePicker(context, "Change Date and Time", (v) {
                          setState(() {
                            widget.data.date = v;
                          });
                        });
                      },
                      child: FormTextValueWidget(
                        align: TextAlign.center,
                        text: widget.data.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(widget.data.date!),
                        secondaryInfo: true,
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                  onPressed: () {
                    widget.onDelete();
                  },
                  icon: Icon(Icons.delete)),
            ],
          ),
        ),
      ],
    );
  }
}
