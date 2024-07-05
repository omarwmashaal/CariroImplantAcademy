import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getProstheticNextVisitUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getProstheticStatusUseCase.dart';
import 'package:cariro_implant_academy/core/injection_contianer.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticStepEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../Widgets/CIA_CheckBoxWidget.dart';
import '../../../../../Widgets/CIA_DropDown.dart';
import '../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../core/presentation/widgets/CIA_GestureWidget.dart';

class DiagnosticProsthesis_StepWidget extends StatefulWidget {
  DiagnosticProsthesis_StepWidget({
    Key? key,
    required this.data,
    required this.onDelete,
    required this.index,
  }) : super(key: key);
  ProstheticStepEntity data;
  Function() onDelete;
  int index;

  @override
  State<DiagnosticProsthesis_StepWidget> createState() => _DiagnosticProsthesis_StepWidgetState();
}

class _DiagnosticProsthesis_StepWidgetState extends State<DiagnosticProsthesis_StepWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FormTextKeyWidget(text: "${widget.index}. ${widget.data.item?.name}"),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: CIA_DropDownSearchBasicIdName(
                  onClear: () {
                    widget.data.status = null;
                    widget.data.statusId = null;
                    widget.data.operatorId = siteController.getUserId();
                    setState(() {
                      widget.data.operator = BasicNameIdObjectEntity(name: siteController.getUserName());
                      widget.data.date = widget.data.date ?? DateTime.now();
                    });
                  },
                  label: "Diagnostic",
                  asyncUseCase: sl<GetProstheticStatusUseCase>(),
                  searchParams: GetProstheticStatusParams(itemId: widget.data.itemId!, type: EnumProstheticType.Diagnostic),
                  selectedItem: () {
                    if (widget.data.status != null) {
                      return BasicNameIdObjectEntity(
                        name: widget.data.status!.name,
                        id: widget.data.statusId,
                      );
                    }
                    return null;
                  }(),
                  onSelect: (value) {
                    widget.data.status = value;
                    widget.data.statusId = value.id;
                    widget.data.operatorId = siteController.getUserId();
                    setState(() {
                      widget.data.operator = BasicNameIdObjectEntity(name: siteController.getUserName());
                      widget.data.date = widget.data.date ?? DateTime.now();
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CIA_DropDownSearchBasicIdName(
                  onClear: () {
                    widget.data.nextVisit = null;
                    widget.data.nextVisitId = null;
                    widget.data.operatorId = siteController.getUserId();
                    setState(() {
                      widget.data.operator = BasicNameIdObjectEntity(name: siteController.getUserName());
                      widget.data.date = widget.data.date ?? DateTime.now();
                    });
                  },
                  label: "Next Step",
                  asyncUseCase: sl<GetProstheticNextVisitUseCase>(),
                  searchParams: GetProstheticNextVisitParams(itemId: widget.data.itemId!, type: EnumProstheticType.Diagnostic),
                  selectedItem: () {
                    if (widget.data.nextVisit != null) {
                      return BasicNameIdObjectEntity(
                        name: widget.data.nextVisit!.name,
                        id: widget.data.nextVisitId,
                      );
                    }
                    return null;
                  }(),
                  onSelect: (value) {
                    widget.data.nextVisit = value;
                    widget.data.nextVisitId = value.id;
                    widget.data.operatorId = siteController.getUserId();
                    setState(() {
                      widget.data.operator = BasicNameIdObjectEntity(name: siteController.getUserName());
                      widget.data.date = widget.data.date ?? DateTime.now();
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              CIA_CheckBoxWidget(
                text: "Needs Remake",
                onChange: (v) {
                  widget.data.operatorId = siteController.getUserId();
                  if (v) widget.data.scanned = false;
                  setState(() {});
                  widget.data.needsRemake = v;
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
                        child: CIA_GestureWidget(
                      onTap: () => CIA_ShowPopUp(
                        context: context,
                        height: 100,
                        onSave: () => setState(() => null),
                        child: CIA_DropDownSearchBasicIdName<LoadUsersEnum>(
                          onClear: () {
                            widget.data.operatorId = null;
                            widget.data.operator = null;
                          },
                          asyncUseCase: sl<LoadUsersUseCase>(),
                          searchParams: LoadUsersEnum.instructorsAndAssistants,
                          onSelect: (value) {
                            widget.data.operatorId = value.id;
                            widget.data.operator = value;
                          },
                          //selectedItem: DropDownDTO(),
                          selectedItem: widget.data.operator ?? BasicNameIdObjectEntity(name: "", id: 0),
                          label: "Operator",
                        ),
                      ),
                      child: FormTextValueWidget(
                        align: TextAlign.center,
                        text: widget.data.operator!.name ?? "",
                        secondaryInfo: true,
                      ),
                    )),
                    SizedBox(width: 10),
                    Expanded(
                        child: CIA_GestureWidget(
                      onTap: () {
                        CIA_PopupDialog_DateOnlyPicker(
                          context,
                          "Change Date and Time",
                          (v) {
                            setState(() {
                              widget.data.date = v;
                            });
                          },
                          initialDate: widget.data.date,
                        );
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
              IconButton(onPressed: () => widget.onDelete(), icon: Icon(Icons.delete)),
            ],
          ),
        )
      ],
    );
  }
}
