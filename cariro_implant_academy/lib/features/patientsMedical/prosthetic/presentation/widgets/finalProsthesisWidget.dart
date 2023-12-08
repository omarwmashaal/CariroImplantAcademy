import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TextFormField.dart';
import 'package:cariro_implant_academy/Widgets/MultiSelectChipWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../Models/DTOs/DropDownDTO.dart';
import '../../../../../Widgets/CIA_CheckBoxWidget.dart';
import '../../../../../Widgets/CIA_DropDown.dart';
import '../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../Widgets/CIA_TeethChart.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../core/constants/enums/enums.dart';
import '../../../../labRequest/presentation/pages/LapCreateNewRequestPage.dart';
import '../../domain/entities/finalProsthesisDeliveryEntity.dart';
import '../../domain/entities/finalProsthesisHealingCollarEntity.dart';
import '../../domain/entities/finalProsthesisImpressionEntity.dart';
import '../../domain/entities/finalProsthesisTryInEntity.dart';
import '../../domain/entities/prostheticTreatmentFinalEntity.dart';
import '../../domain/enums/enum.dart';

class FinalProsthesisWidget extends StatefulWidget {
  FinalProsthesisWidget({
    Key? key,
    required this.data,
    required this.patientId,
    this.fullArch = false,
  }) : super(key: key);
  ProstheticTreatmentFinalEntity data;
  bool fullArch;
  int patientId;

  @override
  State<FinalProsthesisWidget> createState() => _FinalProsthesisWidgetState();
}

class _FinalProsthesisWidgetState extends State<FinalProsthesisWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Visibility(
          visible: !widget.fullArch,
          child: CIA_TeethChart(
            onChange: (selectedTeethList) {
              widget.data?.healingCollars?.forEach((element) {
                element.finalProthesisTeeth = selectedTeethList;
              });
              widget.data?.tryIns?.forEach((element) {
                element.finalProthesisTeeth = selectedTeethList;
              });
              widget.data?.impressions?.forEach((element) {
                element.finalProthesisTeeth = selectedTeethList;
              });
              widget.data?.delivery?.forEach((element) {
                element.finalProthesisTeeth = selectedTeethList;
              });
            },
            selectedTeeth: widget.fullArch
                ? null
                : () {
                    if (widget.data.healingCollars?.isNotEmpty ?? false) {
                      return widget.data.healingCollars!.first.finalProthesisTeeth ?? [];
                    } else if (widget.data.delivery?.isNotEmpty ?? false) {
                      return widget.data.delivery!.first.finalProthesisTeeth ?? [];
                    } else if (widget.data.impressions?.isNotEmpty ?? false) {
                      return widget.data.impressions!.first.finalProthesisTeeth ?? [];
                    } else if (widget.data.tryIns?.isNotEmpty ?? false) {
                      return widget.data.tryIns!.first.finalProthesisTeeth ?? [];
                    }
                    return <int>[];
                  }(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: widget.data?.healingCollars
                      ?.map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CIA_CheckBoxWidget(
                                    text: "Healing Collar",
                                    onChange: (value) {
                                      e!.finalProthesisHealingCollar = value;
                                      if (value == true)
                                        e.finalProthesisHealingCollarDate = DateTime.now();
                                      else
                                        e.finalProthesisHealingCollarDate = null;

                                      setState(() {});
                                    },
                                    value: e!.finalProthesisHealingCollar ?? false,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 3,
                                  child: CIA_DropDownSearch(
                                    label: "Customization",
                                    selectedItem: () {
                                      if (e!.finalProthesisHealingCollarStatus != null) {
                                        return DropDownDTO(name: e!.finalProthesisHealingCollarStatus!.name.replaceAll("_", " "));
                                      }
                                      return null;
                                    }(),
                                    onSelect: (value) {
                                      e!.finalProthesisHealingCollarStatus = EnumFinalProthesisHealingCollarStatus.values[value.id!];
                                    },
                                    items: [
                                      DropDownDTO(name: "With Customization", id: 0),
                                      DropDownDTO(name: "Without Customization", id: 1),
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
                                          child: FormTextValueWidget(
                                        text: e.finalProthesisHealingCollarDate == null
                                            ? ""
                                            : DateFormat("dd-MM-yyyy hh:mm a").format(e.finalProthesisHealingCollarDate!),
                                      )),
                                      SizedBox(width: 10),
                                      IconButton(
                                          onPressed: () {
                                            if (widget.data!.healingCollars != null)
                                              widget.data!.healingCollars = [
                                                ...widget.data!.healingCollars!,
                                                FinalProthesisHealingCollarEntity(
                                                  patientId: widget.patientId,
                                                )
                                              ];
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.add)),
                                      SizedBox(width: 10),
                                      IconButton(
                                          onPressed: () {
                                            if (widget.data!.healingCollars != null) widget.data!.healingCollars!.remove(e);
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.delete)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList() ??
                  [],
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: widget.data?.impressions
                      ?.map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CIA_CheckBoxWidget(
                                    text: "Impression",
                                    onChange: (v) {
                                      e!.finalProthesisImpression = v;
                                      if (v == true)
                                        e.finalProthesisImpressionDate = DateTime.now();
                                      else
                                        e.finalProthesisImpressionDate = null;
                                      setState(() {});
                                    },
                                    value: e!.finalProthesisImpression ?? false,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CIA_DropDownSearch(
                                          label: "Procedure",
                                          selectedItem: () {
                                            if (e!.finalProthesisImpressionStatus != null) {
                                              return DropDownDTO(name: e!.finalProthesisImpressionStatus!.name.replaceAll("_", " "));
                                            }
                                            return null;
                                          }(),
                                          onSelect: (value) {
                                            e!.finalProthesisImpressionStatus = EnumFinalProthesisImpressionStatus.values[value.id!];
                                            if (value.name?.toLowerCase().contains("physical impression") == true) {
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
                                            DropDownDTO(name: "Scan by scan body", id: 0),
                                            DropDownDTO(name: "Scan by abutment", id: 1),
                                            DropDownDTO(name: "Physical Impression open tray", id: 2),
                                            DropDownDTO(name: "Physical Impression closed tray", id: 3),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_DropDownSearch(
                                          label: "Next Visit",
                                          selectedItem: () {
                                            if (e!.finalProthesisImpressionNextVisit != null) {
                                              return DropDownDTO(name: e!.finalProthesisImpressionNextVisit!.name.replaceAll("_", " "));
                                            }
                                            return null;
                                          }(),
                                          onSelect: (value) {
                                            e!.finalProthesisImpressionNextVisit = EnumFinalProthesisImpressionNextVisit.values[value.id!];
                                          },
                                          items: [
                                            DropDownDTO(name: "Custom Abutment", id: 0),
                                            DropDownDTO(name: "Try In", id: 1),
                                            DropDownDTO(name: "Delivery", id: 2),
                                          ],
                                        ),
                                      ),
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
                                          child: FormTextValueWidget(
                                        text: e.finalProthesisImpressionDate == null
                                            ? ""
                                            : DateFormat("dd-MM-yyyy hh:mm a").format(e.finalProthesisImpressionDate!),
                                      )),
                                      SizedBox(width: 10),
                                      IconButton(
                                          onPressed: () {
                                            if (widget.data!.impressions != null)
                                              widget.data!.impressions = [
                                                ...widget.data!.impressions!,
                                                FinalProthesisImpressionEntity(
                                                  patientId: widget.patientId,
                                                )
                                              ];
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.add)),
                                      SizedBox(width: 10),
                                      IconButton(
                                          onPressed: () {
                                            if (widget.data!.impressions != null) widget.data!.impressions!.remove(e);
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.delete)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList() ??
                  [],
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: widget.data?.tryIns
                      ?.map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: CIA_CheckBoxWidget(
                                  text: "Try in",
                                  onChange: (v) {
                                    e!.finalProthesisTryIn = v;
                                    if (v == true)
                                      e.finalProthesisTryInDate = DateTime.now();
                                    else
                                      e.finalProthesisTryInDate = null;
                                    setState(() {});
                                  },
                                  value: e!.finalProthesisTryIn ?? false,
                                )),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CIA_DropDownSearch(
                                          label: "Procedure",
                                          selectedItem: () {
                                            if (e!.finalProthesisTryInStatus != null) {
                                              return DropDownDTO(name: e!.finalProthesisTryInStatus!.name.replaceAll("_", " "));
                                            }
                                            return null;
                                          }(),
                                          onSelect: (value) {
                                            e!.finalProthesisTryInStatus = EnumFinalProthesisTryInStatus.values[value.id!];
                                            if (value.name?.toLowerCase().contains("physical impression") == true) {
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
                                            if (e!.finalProthesisTryInNextVisit != null) {
                                              return DropDownDTO(name: e!.finalProthesisTryInNextVisit!.name.replaceAll("_", " "));
                                            }
                                            return null;
                                          }(),
                                          onSelect: (value) {
                                            e!.finalProthesisTryInNextVisit = EnumFinalProthesisTryInNextVisit.values[value.id!];
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
                                            child: StatefulBuilder(
                                              builder: (context,setState) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: ListView(
                                                    children: [
                                                      Row(
                                                      children: [
                                                        CIA_MultiSelectChipWidget(
                                                          singleSelect: true,
                                                          labels: [
                                                            CIA_MultiSelectChipWidgeModel(label: "Satisfied", isSelected: e.satisfied==true),
                                                            CIA_MultiSelectChipWidgeModel(label: "Non Satisfied", isSelected: e.satisfied==false),
                                                          ],
                                                          onChange: (item, isSelected) {
                                                            if (item == "Satisfied") {
                                                              e.satisfied = true;
                                                              e.nonSatisfiedNewScan = null;
                                                              e.nonSatisfiedDescription = null;
                                                            } else if (item == "Non Satisfied") {
                                                              e.satisfied = false;
                                                            }
                                                            setState(() {});
                                                          },
                                                        ),
                                                        SizedBox(width: 10),
                                                        Visibility(
                                                          visible: e.satisfied == false,
                                                          child: Expanded(
                                                            child: Row(
                                                              children: [
                                                                CIA_MultiSelectChipWidget(
                                                                  singleSelect: true,
                                                                  labels: [
                                                                    CIA_MultiSelectChipWidgeModel(label: "New Scan", isSelected: e.nonSatisfiedNewScan==true),
                                                                    CIA_MultiSelectChipWidgeModel(label: "Same Scan", isSelected: e.nonSatisfiedNewScan==false),
                                                                  ],
                                                                  onChange: (item, isSelected) {
                                                                    if (item == "New Scan") {
                                                                      e.nonSatisfiedNewScan = true;
                                                                    } else if (item == "Same Scan") {
                                                                      e.nonSatisfiedNewScan = false;
                                                                    }
                                                                  },
                                                                ),
                                                                SizedBox(width: 10),
                                                                Expanded(
                                                                  child: CIA_TextFormField(
                                                                    label: "Non Satisfied Description",
                                                                    controller: TextEditingController(text: e.nonSatisfiedDescription),
                                                                    onChange: (v) => e.nonSatisfiedDescription = v,
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
                                                              CIA_MultiSelectChipWidgeModel(label: "Yes", isSelected: e.seating==true),
                                                              CIA_MultiSelectChipWidgeModel(label: "No", isSelected: e.seating==false),
                                                            ],
                                                            onChange: (item, isSelected) {
                                                              if (item == "Yes") {
                                                                e.seating = true;
                                                                e.nonSeatingOtherNotes = null;
                                                                e.nonSeatingType = null;
                                                              } else if (item == "No") {
                                                                e.seating = false;
                                                              }
                                                              setState(() {});
                                                            },
                                                          ),
                                                          SizedBox(width: 10),
                                                          Visibility(
                                                            visible: e.seating==false,
                                                            child: Expanded(
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: CIA_DropDownSearch(
                                                                      label: "Non Seating Type",
                                                                      selectedItem: e.nonSeatingType != null
                                                                          ? DropDownDTO(name: e.nonSeatingType!.name.replaceAll("_", " "))
                                                                          : null,
                                                                      onSelect: (value) {
                                                                        e.nonSeatingType = EnumTryInSeating.values[value.id!];
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
                                                                      controller: TextEditingController(text: e.nonSeatingOtherNotes),
                                                                      onChange: (v) => e.nonSeatingOtherNotes = v,
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
                                                        selectedItem:
                                                            e.mesialContacts != null ? DropDownDTO(name: e.mesialContacts!.name.replaceAll("_", " ")) : null,
                                                        onSelect: (value) {
                                                          e.mesialContacts = EnumTryInContacts.values[value.id!];
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
                                                        selectedItem:
                                                            e.distalContacts != null ? DropDownDTO(name: e.distalContacts!.name.replaceAll("_", " ")) : null,
                                                        onSelect: (value) {
                                                          e.distalContacts = EnumTryInContacts.values[value.id!];
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
                                                        selectedItem: e.occlusion != null ? DropDownDTO(name: e.occlusion!.name.replaceAll("_", " ")) : null,
                                                        onSelect: (value) {
                                                          e.occlusion = EnumOcclusion.values[value.id!];
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
                                                        selectedItem: e.buccalContour != null ? DropDownDTO(name: e.buccalContour!.name.replaceAll("_", " ")) : null,
                                                        onSelect: (value) {
                                                          e.buccalContour = EnumBuccalContour.values[value.id!];
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
                                                                CIA_MultiSelectChipWidgeModel(label: "Yes", isSelected: e.passive==true),
                                                                CIA_MultiSelectChipWidgeModel(label: "No", isSelected: e.passive==false),
                                                              ],
                                                              onChange: (item, isSelected) {
                                                                e.passive = item == "Yes";
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      // Other dropdowns and text fields...
                                                      SizedBox(height: 10),
                                                      CIA_TextFormField(
                                                        label: "Retention",
                                                        controller: TextEditingController(text: e.retention),
                                                        onChange: (v) => e.retention = v,
                                                      ),
                                                      SizedBox(height: 10),
                                                      CIA_TextFormField(
                                                        label: "Occlusion Notes",
                                                        controller: TextEditingController(text: e.occlusionNotes),
                                                        onChange: (v) => e.occlusionNotes = v,
                                                      ),
                                                      SizedBox(height: 10),
                                                      CIA_TextFormField(
                                                        label: "Occlusal Plan and Midline",
                                                        controller: TextEditingController(text: e.occlusalPlanAndMidline),
                                                        onChange: (v) => e.occlusalPlanAndMidline = v,
                                                      ),
                                                      SizedBox(height: 10),
                                                      CIA_TextFormField(
                                                        label: "Centric Relation",
                                                        controller: TextEditingController(text: e.centricRelation),
                                                        onChange: (v) => e.centricRelation = v,
                                                      ),
                                                      SizedBox(height: 10),
                                                      CIA_TextFormField(
                                                        label: "Vertical Dimension",
                                                        controller: TextEditingController(text: e.verticalDimension),
                                                        onChange: (v) => e.verticalDimension = v,
                                                      ),

                                                      SizedBox(height: 10),
                                                      CIA_TextFormField(
                                                        label: "Lip Support",
                                                        controller: TextEditingController(text: e.lipSupport),
                                                        onChange: (v) => e.lipSupport = v,
                                                      ),

                                                      SizedBox(height: 10),
                                                      CIA_TextFormField(
                                                        label: "Size and Shape of Teeth",
                                                        controller: TextEditingController(text: e.sizeAndShapeOfTeeth),
                                                        onChange: (v) => e.sizeAndShapeOfTeeth = v,
                                                      ),

                                                      SizedBox(height: 10),
                                                      CIA_TextFormField(
                                                        label: "Canting",
                                                        controller: TextEditingController(text: e.canting),
                                                        onChange: (v) => e.canting = v,
                                                      ),

                                                      SizedBox(height: 10),
                                                      CIA_TextFormField(
                                                        label: "Frontal Smiling and Lateral Photos",
                                                        controller: TextEditingController(text: e.frontalSmilingAndLateralPhotos),
                                                        onChange: (v) => e.frontalSmilingAndLateralPhotos = v,
                                                      ),

                                                      SizedBox(height: 10),
                                                      CIA_TextFormField(
                                                        label: "Evaluation",
                                                        controller: TextEditingController(text: e.evaluation),
                                                        onChange: (v) => e.evaluation = v,
                                                      ),

                                                      SizedBox(height: 10),
                                                      CIA_TextFormField(
                                                        label: "Explain Why",
                                                        controller: TextEditingController(text: e.explainWhy),
                                                        onChange: (v) => e.explainWhy = v,
                                                      ),
                                                      // Add the remaining fields as needed...
                                                    ],
                                                  ),
                                                );
                                              }
                                            )),
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
                                          child: FormTextValueWidget(
                                        text: e.finalProthesisTryInDate == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.finalProthesisTryInDate!),
                                      )),
                                      SizedBox(width: 10),
                                      IconButton(
                                          onPressed: () {
                                            if (widget.data!.tryIns != null)
                                              widget.data!.tryIns = [
                                                ...widget.data!.tryIns!,
                                                FinalProthesisTryInEntity(
                                                  patientId: widget.patientId,
                                                )
                                              ];
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.add)),
                                      SizedBox(width: 10),
                                      IconButton(
                                          onPressed: () {
                                            if (widget.data!.tryIns != null) widget.data!.tryIns!.remove(e);
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.delete)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                      .toList() ??
                  [],
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
        StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: widget.data?.delivery
                      ?.map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: CIA_CheckBoxWidget(
                                  text: "Delivery",
                                  onChange: (v) {
                                    e!.finalProthesisDelivery = v;
                                    if (v == true)
                                      e.finalProthesisDeliveryDate = DateTime.now();
                                    else
                                      e.finalProthesisDeliveryDate = null;
                                    setState(() {});
                                  },
                                  value: e!.finalProthesisDelivery ?? false,
                                )),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CIA_DropDownSearch(
                                          label: "Status",
                                          selectedItem: () {
                                            if (e!.finalProthesisDeliveryStatus != null) {
                                              return DropDownDTO(name: e!.finalProthesisDeliveryStatus!.name.replaceAll("_", " "));
                                            }
                                            return null;
                                          }(),
                                          onSelect: (value) {
                                            e!.finalProthesisDeliveryStatus = EnumFinalProthesisDeliveryStatus.values[value.id!];
                                          },
                                          items: [
                                            DropDownDTO(name: "Done", id: 0),
                                            DropDownDTO(name: "ReDesign", id: 1),
                                            DropDownDTO(name: "ReImpression", id: 2),
                                            DropDownDTO(name: "ReTryIn", id: 3),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_DropDownSearch(
                                          label: "Next Visit",
                                          selectedItem: () {
                                            if (e.finalProthesisDeliveryNextVisit != null) {
                                              return DropDownDTO(name: e!.finalProthesisDeliveryNextVisit!.name.replaceAll("_", " "));
                                            }
                                            return null;
                                          }(),
                                          onSelect: (value) {
                                            e!.finalProthesisDeliveryNextVisit = EnumFinalProthesisDeliveryNextVisit.values[value.id!];
                                          },
                                          items: [
                                            DropDownDTO(name: "Done", id: 0),
                                            DropDownDTO(name: "ReDesign", id: 1),
                                            DropDownDTO(name: "ReImpression", id: 2),
                                            DropDownDTO(name: "ReTryIn", id: 3),
                                          ],
                                        ),
                                      ),
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
                                          child: FormTextValueWidget(
                                        text:
                                            e.finalProthesisDeliveryDate == null ? "" : DateFormat("dd-MM-yyyy hh:mm a").format(e.finalProthesisDeliveryDate!),
                                      )),
                                      SizedBox(width: 10),
                                      IconButton(
                                          onPressed: () {
                                            if (widget.data!.delivery != null)
                                              widget.data!.delivery = [
                                                ...widget.data!.delivery!,
                                                FinalProthesisDeliveryEntity(
                                                  patientId: widget.patientId,
                                                )
                                              ];
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.add)),
                                      SizedBox(width: 10),
                                      IconButton(
                                          onPressed: () {
                                            if (widget.data!.delivery != null) widget.data!.delivery!.remove(e);
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.delete)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                      .toList() ??
                  [],
            );
          },
        ),
      ],
    );
  }
}
