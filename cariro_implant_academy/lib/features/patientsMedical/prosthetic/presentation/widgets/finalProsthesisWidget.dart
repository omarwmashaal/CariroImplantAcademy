import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../Models/DTOs/DropDownDTO.dart';
import '../../../../../Widgets/CIA_CheckBoxWidget.dart';
import '../../../../../Widgets/CIA_DropDown.dart';
import '../../../../../Widgets/CIA_PopUp.dart';
import '../../../../../Widgets/CIA_TeethChart.dart';
import '../../../../../Widgets/FormTextWidget.dart';
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
             selectedTeeth:widget.fullArch?null: (){

              if(widget.data.healingCollars?.isNotEmpty??false)
                {
                  return widget.data.healingCollars!.first.finalProthesisTeeth??[];
                }
             else if(widget.data.delivery?.isNotEmpty??false)
                {
                  return widget.data.delivery!.first.finalProthesisTeeth??[];
                }
              else if(widget.data.impressions?.isNotEmpty??false)
                {
                  return widget.data.impressions!.first.finalProthesisTeeth??[];
                }
              else if(widget.data.tryIns?.isNotEmpty??false)
                {
                  return widget.data.tryIns!.first.finalProthesisTeeth??[];
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
