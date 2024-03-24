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
import '../../../../labRequest/presentation/pages/LapCreateNewRequestPage.dart';
import '../../domain/entities/finalProsthesisDeliveryEntity.dart';
import '../../domain/entities/finalProsthesisHealingCollarEntity.dart';
import '../../domain/entities/finalProsthesisImpressionEntity.dart';
import '../../domain/entities/finalProsthesisTryInEntity.dart';
import '../../domain/entities/prostheticFinalEntity.dart';
import '../../domain/enums/enum.dart';

class FinalProsthesis_TryInsWidget extends StatefulWidget {
  FinalProsthesis_TryInsWidget({
    Key? key,
    required this.data,
    required this.onDelete,
    required this.index,
    required this.patientId,
    this.fullArch = false,
  }) : super(key: key);
  bool fullArch;
  FinalProthesisTryInEntity data;
  Function() onDelete;
  int index;
  int patientId;

  @override
  State<FinalProsthesis_TryInsWidget> createState() => _FinalProsthesis_TryInsWidgetState();
}

class _FinalProsthesis_TryInsWidgetState extends State<FinalProsthesis_TryInsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              FormTextKeyWidget(text: "${widget.index}. Try In"),
              FormTextValueWidget(
                text: " || Teeth: ",
              ),
              FormTextValueWidget(
                text: widget.fullArch ? "Full Arch" : widget.data.finalProthesisTeeth?.toString(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      child: CIA_DropDownSearch(
                        label: "Procedure",
                        selectedItem: () {
                          if (widget.data!.finalProthesisTryInStatus != null) {
                            return DropDownDTO(name: widget.data!.finalProthesisTryInStatus!.name.replaceAll("_", " "));
                          }
                          return null;
                        }(),
                        onSelect: (value) {
                          CIA_ShowPopUp(
                            hideButton: true,
                            context: context,
                            width: 1100,
                            height: 650,
                            child: LabCreateNewRequestPage(
                              fixDismiss: true,
                              isDoctor: true,
                              patientId: widget.patientId,
                            ),
                          );
                          widget.data!.finalProthesisTryInStatus = EnumFinalProthesisTryInStatus.values[value.id!];
                          {
                            CIA_ShowPopUp(
                              hideButton: true,
                              context: context,
                              width: 1100,
                              height: 650,
                              child: LabCreateNewRequestPage(
                                fixDismiss: true,
                                isDoctor: true,
                                patientId: widget.patientId,
                              ),
                            );
                          }
                        },
                        items: [
                          DropDownDTO(name: "Try in abutment + scan abutment", id: 0),
                          DropDownDTO(name: "Try in PMMA", id: 1),
                          DropDownDTO(name: "Try in on scan abutment PMMA", id: 2),
                          DropDownDTO(name: "Physical Impression closed tray", id: 3),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CIA_DropDownSearch(
                        label: "Next Visit",
                        selectedItem: () {
                          if (widget.data!.finalProthesisTryInNextVisit != null) {
                            return DropDownDTO(name: widget.data!.finalProthesisTryInNextVisit!.name.replaceAll("_", " "));
                          }
                          return null;
                        }(),
                        onSelect: (value) {
                          widget.data!.finalProthesisTryInNextVisit = EnumFinalProthesisTryInNextVisit.values[value.id!];
                        },
                        items: [
                          DropDownDTO(name: "Delivery", id: 0),
                          DropDownDTO(name: "Try in PMMA", id: 1),
                          DropDownDTO(name: "ReImpression", id: 2),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child: CIA_SecondaryButton(
                      label: "Check List",
                      onTab: () => CIA_ShowPopUp(
                          context: context,
                          width: 900,
                          height: 600,
                          child: StatefulBuilder(builder: (context, setState) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListView(
                                children: [
                                  Row(
                                    children: [
                                      CIA_MultiSelectChipWidget(
                                        singleSelect: true,
                                        labels: [
                                          CIA_MultiSelectChipWidgeModel(label: "Satisfied", isSelected: widget.data.satisfied == true),
                                          CIA_MultiSelectChipWidgeModel(label: "Non Satisfied", isSelected: widget.data.satisfied == false),
                                        ],
                                        onChange: (item, isSelected) {
                                          if (item == "Satisfied") {
                                            widget.data.satisfied = true;
                                            widget.data.nonSatisfiedNewScan = null;
                                            widget.data.nonSatisfiedDescription = null;
                                          } else if (item == "Non Satisfied") {
                                            widget.data.satisfied = false;
                                          }
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 10),
                                      Visibility(
                                        visible: widget.data.satisfied == false,
                                        child: Expanded(
                                          child: Row(
                                            children: [
                                              CIA_MultiSelectChipWidget(
                                                singleSelect: true,
                                                labels: [
                                                  CIA_MultiSelectChipWidgeModel(
                                                      label: "New Scan", isSelected: widget.data.nonSatisfiedNewScan == true),
                                                  CIA_MultiSelectChipWidgeModel(
                                                      label: "Same Scan", isSelected: widget.data.nonSatisfiedNewScan == false),
                                                ],
                                                onChange: (item, isSelected) {
                                                  if (item == "New Scan") {
                                                    widget.data.nonSatisfiedNewScan = true;
                                                  } else if (item == "Same Scan") {
                                                    widget.data.nonSatisfiedNewScan = false;
                                                  }
                                                  setState(() {});
                                                },
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: CIA_TextFormField(
                                                  label: "Non Satisfied Description",
                                                  controller: TextEditingController(text: widget.data.nonSatisfiedDescription),
                                                  onChange: (v) => widget.data.nonSatisfiedDescription = v,
                                                ),
                                              ),
                                              // Add more fields as needed
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      FormTextKeyWidget(text: "Seating"),
                                      SizedBox(width: 10),
                                      CIA_MultiSelectChipWidget(
                                        singleSelect: true,
                                        labels: [
                                          CIA_MultiSelectChipWidgeModel(label: "Yes", isSelected: widget.data.seating == true),
                                          CIA_MultiSelectChipWidgeModel(label: "No", isSelected: widget.data.seating == false),
                                        ],
                                        onChange: (item, isSelected) {
                                          if (item == "Yes") {
                                            widget.data.seating = true;
                                            widget.data.nonSeatingOtherNotes = null;
                                            widget.data.nonSeatingType = null;
                                          } else if (item == "No") {
                                            widget.data.seating = false;
                                          }
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 10),
                                      Visibility(
                                        visible: widget.data.seating == false,
                                        child: Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: CIA_DropDownSearch(
                                                  label: "Non Seating Type",
                                                  selectedItem: widget.data.nonSeatingType != null
                                                      ? DropDownDTO(name: widget.data.nonSeatingType!.name.replaceAll("_", " "))
                                                      : null,
                                                  onSelect: (value) {
                                                    widget.data.nonSeatingType = EnumTryInSeating.values[value.id!];
                                                  },
                                                  items: EnumTryInSeating.values
                                                      .map(
                                                        (value) => DropDownDTO(
                                                          name: value.name.replaceAll("_", " "),
                                                          id: EnumTryInSeating.values.indexOf(value),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: CIA_TextFormField(
                                                  label: "Non Seating Other Notes",
                                                  controller: TextEditingController(text: widget.data.nonSeatingOtherNotes),
                                                  onChange: (v) => widget.data.nonSeatingOtherNotes = v,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 10),
                                  CIA_DropDownSearch(
                                    label: "Mesial Contact",
                                    selectedItem: widget.data.mesialContacts != null
                                        ? DropDownDTO(name: widget.data.mesialContacts!.name.replaceAll("_", " "))
                                        : null,
                                    onSelect: (value) {
                                      widget.data.mesialContacts = EnumTryInContacts.values[value.id!];
                                    },
                                    items: EnumTryInContacts.values
                                        .map(
                                          (value) => DropDownDTO(
                                            name: value.name.replaceAll("_", " "),
                                            id: EnumTryInContacts.values.indexOf(value),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  SizedBox(height: 10),
                                  CIA_DropDownSearch(
                                    label: "Distal Contact",
                                    selectedItem: widget.data.distalContacts != null
                                        ? DropDownDTO(name: widget.data.distalContacts!.name.replaceAll("_", " "))
                                        : null,
                                    onSelect: (value) {
                                      widget.data.distalContacts = EnumTryInContacts.values[value.id!];
                                    },
                                    items: EnumTryInContacts.values
                                        .map(
                                          (value) => DropDownDTO(
                                            name: value.name.replaceAll("_", " "),
                                            id: EnumTryInContacts.values.indexOf(value),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  SizedBox(height: 10),
                                  CIA_DropDownSearch(
                                    label: "Occlusion",
                                    selectedItem:
                                        widget.data.occlusion != null ? DropDownDTO(name: widget.data.occlusion!.name.replaceAll("_", " ")) : null,
                                    onSelect: (value) {
                                      widget.data.occlusion = EnumOcclusion.values[value.id!];
                                    },
                                    items: EnumOcclusion.values
                                        .map(
                                          (value) => DropDownDTO(
                                            name: value.name.replaceAll("_", " "),
                                            id: EnumOcclusion.values.indexOf(value),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  SizedBox(height: 10),
                                  CIA_DropDownSearch(
                                    label: "Buccal Contour",
                                    selectedItem: widget.data.buccalContour != null
                                        ? DropDownDTO(name: widget.data.buccalContour!.name.replaceAll("_", " "))
                                        : null,
                                    onSelect: (value) {
                                      widget.data.buccalContour = EnumBuccalContour.values[value.id!];
                                    },
                                    items: EnumBuccalContour.values
                                        .map(
                                          (value) => DropDownDTO(
                                            name: value.name.replaceAll("_", " "),
                                            id: EnumBuccalContour.values.indexOf(value),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: FormTextKeyWidget(
                                          text: "Passive",
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_MultiSelectChipWidget(
                                          singleSelect: true,
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(label: "Yes", isSelected: widget.data.passive == true),
                                            CIA_MultiSelectChipWidgeModel(label: "No", isSelected: widget.data.passive == false),
                                          ],
                                          onChange: (item, isSelected) {
                                            widget.data.passive = item == "Yes";
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Other dropdowns and text fields...
                                  SizedBox(height: 10),
                                  CIA_TextFormField(
                                    label: "Retention",
                                    controller: TextEditingController(text: widget.data.retention),
                                    onChange: (v) => widget.data.retention = v,
                                  ),
                                  SizedBox(height: 10),
                                  CIA_TextFormField(
                                    label: "Occlusion Notes",
                                    controller: TextEditingController(text: widget.data.occlusionNotes),
                                    onChange: (v) => widget.data.occlusionNotes = v,
                                  ),
                                  SizedBox(height: 10),
                                  CIA_TextFormField(
                                    label: "Occlusal Plan and Midline",
                                    controller: TextEditingController(text: widget.data.occlusalPlanAndMidline),
                                    onChange: (v) => widget.data.occlusalPlanAndMidline = v,
                                  ),
                                  SizedBox(height: 10),
                                  CIA_TextFormField(
                                    label: "Centric Relation",
                                    controller: TextEditingController(text: widget.data.centricRelation),
                                    onChange: (v) => widget.data.centricRelation = v,
                                  ),
                                  SizedBox(height: 10),
                                  CIA_TextFormField(
                                    label: "Vertical Dimension",
                                    controller: TextEditingController(text: widget.data.verticalDimension),
                                    onChange: (v) => widget.data.verticalDimension = v,
                                  ),

                                  SizedBox(height: 10),
                                  CIA_TextFormField(
                                    label: "Lip Support",
                                    controller: TextEditingController(text: widget.data.lipSupport),
                                    onChange: (v) => widget.data.lipSupport = v,
                                  ),

                                  SizedBox(height: 10),
                                  CIA_TextFormField(
                                    label: "Size and Shape of Teeth",
                                    controller: TextEditingController(text: widget.data.sizeAndShapeOfTeeth),
                                    onChange: (v) => widget.data.sizeAndShapeOfTeeth = v,
                                  ),

                                  SizedBox(height: 10),
                                  CIA_TextFormField(
                                    label: "Canting",
                                    controller: TextEditingController(text: widget.data.canting),
                                    onChange: (v) => widget.data.canting = v,
                                  ),

                                  SizedBox(height: 10),
                                  CIA_TextFormField(
                                    label: "Frontal Smiling and Lateral Photos",
                                    controller: TextEditingController(text: widget.data.frontalSmilingAndLateralPhotos),
                                    onChange: (v) => widget.data.frontalSmilingAndLateralPhotos = v,
                                  ),

                                  SizedBox(height: 10),
                                  CIA_TextFormField(
                                    label: "Evaluation",
                                    controller: TextEditingController(text: widget.data.evaluation),
                                    onChange: (v) => widget.data.evaluation = v,
                                  ),

                                  SizedBox(height: 10),
                                  CIA_TextFormField(
                                    label: "Explain Why",
                                    controller: TextEditingController(text: widget.data.explainWhy),
                                    onChange: (v) => widget.data.explainWhy = v,
                                  ),
                                  // Add the remaining fields as needed...
                                ],
                              ),
                            );
                          })),
                    )),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    FormTextKeyWidget(text: "Date"),
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
                        text: widget.data.date == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(widget.data.date!),
                      ),
                    )),
                    SizedBox(width: 10),
                    Expanded(
                        child: FormTextValueWidget(
                      text: widget.data.operator?.name,
                    )),
                    SizedBox(width: 10),
                    IconButton(onPressed: () => widget.onDelete(), icon: Icon(Icons.delete)),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
