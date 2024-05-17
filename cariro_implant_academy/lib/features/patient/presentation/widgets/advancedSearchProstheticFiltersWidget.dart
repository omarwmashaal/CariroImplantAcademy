import 'package:cariro_implant_academy/Widgets/CIA_CheckBoxWidget.dart';
import 'package:cariro_implant_academy/Widgets/CIA_DropDown.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedProstheticSearchRequestEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/biteModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/diagnosticImpressionModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisDeliveryModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisHeallingCollarModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisImporessionModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/finalProsthesisTryInModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/prostheticModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/prostheticTreatmentFinalModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/scanApplianceModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import 'advancedSearchFilterChildWidgert.dart';

enum EnumProstheticType {
  Diagnostic,
  Bite,
  ScanAppliance,
  HealingColar,
  TryIn,
  Delivery,
  Impression,
}


class AdvancedSearchProstheticFilterWidget extends StatefulWidget {
  AdvancedSearchProstheticFilterWidget({
    Key? key,
    required this.searchProstheticDTO,
  }) : super(key: key);

  AdvancedProstheticSearchRequestEntity searchProstheticDTO;

  @override
  State<AdvancedSearchProstheticFilterWidget> createState() => _AdvancedSearchProstheticFilterWidgetState();
}

class _AdvancedSearchProstheticFilterWidgetState extends State<AdvancedSearchProstheticFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionTile(
        title: Text("Prosthetic Filter"),
        children: [
          AdvancedSearchFilterChildWidget(
            title: "Prostheic Type",
            child: Column(
              children: [
                CIA_CheckBoxWidget(
                  text: "All",
                  value: widget.searchProstheticDTO.searchType == null || widget.searchProstheticDTO.isNull(),
                  onChange: (value) {
                    if (value == true)
                      setState(() {
                        widget.searchProstheticDTO.setNull();
                      });
                  },
                ),
                CIA_CheckBoxWidget(
                  text: "Diagnostic",
                  value: widget.searchProstheticDTO.searchType == EnumProstheticSearchType.Diagnostic,
                  onChange: (value) {
                    if (value == true) {
                      widget.searchProstheticDTO.searchType = EnumProstheticSearchType.Diagnostic;
                      widget.searchProstheticDTO.fullArchAnd = null;
                      widget.searchProstheticDTO.fullArchOr = null;
                      widget.searchProstheticDTO.singleAndBridgeAnd = null;
                      widget.searchProstheticDTO.singleAndBridgeOr = null;
                      widget.searchProstheticDTO.prostheticType = EnumProstheticType.Diagnostic;
                    } else {
                      widget.searchProstheticDTO.searchType = null;
                      widget.searchProstheticDTO.setNull();
                    }
                    setState(() {});
                  },
                ),
                CIA_CheckBoxWidget(
                  text: "Sinlge And Bridge",
                  value: widget.searchProstheticDTO.searchType == EnumProstheticSearchType.SingleAndBridge,
                  onChange: (value) {
                    if (value == true) {
                      widget.searchProstheticDTO.searchType = EnumProstheticSearchType.SingleAndBridge;
                      widget.searchProstheticDTO.fullArchAnd = null;
                      widget.searchProstheticDTO.fullArchOr = null;
                      widget.searchProstheticDTO.diagnosticAnd = null;
                      widget.searchProstheticDTO.diagnosticOr = null;
                      widget.searchProstheticDTO.prostheticType = EnumProstheticType.HealingColar;
                    } else {
                      widget.searchProstheticDTO.searchType = null;
                      widget.searchProstheticDTO.setNull();
                    }
                    setState(() {});
                  },
                ),
                CIA_CheckBoxWidget(
                  text: "Full Arch",
                  value: widget.searchProstheticDTO.searchType == EnumProstheticSearchType.FullArch,
                  onChange: (value) {
                    if (value == true) {
                      widget.searchProstheticDTO.searchType = EnumProstheticSearchType.FullArch;
                      widget.searchProstheticDTO.singleAndBridgeAnd = null;
                      widget.searchProstheticDTO.singleAndBridgeOr = null;
                      widget.searchProstheticDTO.diagnosticAnd = null;
                      widget.searchProstheticDTO.diagnosticOr = null;
                      widget.searchProstheticDTO.prostheticType = EnumProstheticType.HealingColar;
                    } else {
                      widget.searchProstheticDTO.searchType = null;
                      widget.searchProstheticDTO.setNull();
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.searchProstheticDTO.searchType == EnumProstheticSearchType.Diagnostic,
            child: AdvancedSearchFilterChildWidget(
              title: "Diagnostic (All of the following)",
              child: Column(
                children: [
                  CIA_DropDownSearchBasicIdName(
                    items: EnumProstheticType.values.getRange(0, 3).map((e) => BasicNameIdObjectEntity(name: e.name, id: e.index)).toList(),
                    onSelect: (value) {
                      widget.searchProstheticDTO.setNull();
                      widget.searchProstheticDTO.diagnosticAnd ??= ProstheticTreatmentModel();
                      if (value.id == 0)
                        widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_DiagnosticImpression = [DiagnosticImpressionModel()];
                      else if (value.id == 1)
                        widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_Bite = [BiteModel()];
                      else if (value.id == 2) widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_ScanAppliance = [ScanApplianceModel()];
                      widget.searchProstheticDTO.searchType = EnumProstheticSearchType.Diagnostic;
                      setState(() => widget.searchProstheticDTO.prostheticType = EnumProstheticType.values[value.id!]);
                    },
                    selectedItem: BasicNameIdObjectEntity(
                        id: widget.searchProstheticDTO.prostheticType.index, name: widget.searchProstheticDTO.prostheticType.name),
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: widget.searchProstheticDTO.prostheticType == EnumProstheticType.Diagnostic,
                    child: Column(
                      children: [
                        FormTextValueWidget(text: "Diagnostic Impression"),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Diagnostic",
                          items: EnumProstheticDiagnosticDiagnosticImpressionDiagnostic.values
                              .map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name))
                              .toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.diagnostic?.index,
                            name: widget.searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.diagnostic?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.diagnosticAnd ??= ProstheticTreatmentModel();
                            widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_DiagnosticImpression ??= [DiagnosticImpressionModel()];
                            widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_DiagnosticImpression!.first.diagnostic =
                                EnumProstheticDiagnosticDiagnosticImpressionDiagnostic.values[value.id!];

                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Next Step",
                          items: EnumProstheticDiagnosticDiagnosticImpressionNextStep.values
                              .map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name))
                              .toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.nextStep?.index,
                            name: widget.searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.nextStep?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.diagnosticAnd ??= ProstheticTreatmentModel();
                            widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_DiagnosticImpression ??= [DiagnosticImpressionModel()];
                            widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_DiagnosticImpression!.first.nextStep =
                                EnumProstheticDiagnosticDiagnosticImpressionNextStep.values[value.id!];

                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            CIA_CheckBoxWidget(
                              text: "Scanned",
                              value:
                                  widget.searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.scanned == true,
                              onChange: (value) {
                                if (value == true) {
                                  widget.searchProstheticDTO.diagnosticAnd ??= ProstheticTreatmentModel();
                                  widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_DiagnosticImpression ??= [
                                    DiagnosticImpressionModel()
                                  ];
                                  widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_DiagnosticImpression!.firstOrNull?.scanned = true;
                                } else {
                                  widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_DiagnosticImpression!.firstOrNull?.scanned = null;
                                }

                                setState(() {});
                              },
                            ),
                            SizedBox(width: 10),
                            CIA_CheckBoxWidget(
                              text: "Needs Remake",
                              value: widget.searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.needsRemake ==
                                  true,
                              onChange: (value) {
                                if (value == true) {
                                  widget.searchProstheticDTO.diagnosticAnd ??= ProstheticTreatmentModel();
                                  widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_DiagnosticImpression ??= [
                                    DiagnosticImpressionModel()
                                  ];
                                  widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_DiagnosticImpression!.firstOrNull?.needsRemake =
                                      true;
                                } else {
                                  widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_DiagnosticImpression!.firstOrNull?.needsRemake =
                                      null;
                                }

                                setState(() {});
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.searchProstheticDTO.prostheticType == EnumProstheticType.Bite,
                    child: Column(
                      children: [
                        FormTextValueWidget(text: "Bite"),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Diagnostic",
                          items:
                              EnumProstheticDiagnosticBiteDiagnostic.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.diagnostic?.index,
                            name: widget.searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.diagnostic?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.diagnosticAnd ??= ProstheticTreatmentModel();
                            widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_Bite ??= [BiteModel()];
                            widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_Bite!.first.diagnostic =
                                EnumProstheticDiagnosticBiteDiagnostic.values[value.id!];

                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Next Step",
                          items: EnumProstheticDiagnosticBiteNextStep.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.nextStep?.index,
                            name: widget.searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.nextStep?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.diagnosticAnd ??= ProstheticTreatmentModel();
                            widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_Bite ??= [BiteModel()];
                            widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_Bite!.first.nextStep =
                                EnumProstheticDiagnosticBiteNextStep.values[value.id!];

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.searchProstheticDTO.prostheticType == EnumProstheticType.ScanAppliance,
                    child: Column(
                      children: [
                        FormTextValueWidget(text: "Scan Appliance"),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Diagnostic",
                          items: EnumProstheticDiagnosticScanApplianceDiagnostic.values
                              .map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name))
                              .toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.diagnostic?.index,
                            name: widget.searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.diagnostic?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.diagnosticAnd ??= ProstheticTreatmentModel();
                            widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_ScanAppliance ??= [ScanApplianceModel()];
                            widget.searchProstheticDTO.diagnosticAnd!.prostheticDiagnostic_ScanAppliance!.first.diagnostic =
                                EnumProstheticDiagnosticScanApplianceDiagnostic.values[value.id!];

                            setState(() {});
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.searchProstheticDTO.searchType == EnumProstheticSearchType.SingleAndBridge,
            child: AdvancedSearchFilterChildWidget(
              title: "Single And Bridge (All of the following)",
              child: Column(
                children: [
                  CIA_DropDownSearchBasicIdName(
                    items: EnumProstheticType.values
                        .getRange(3, EnumProstheticType.values.length)
                        .map((e) => BasicNameIdObjectEntity(name: e.name, id: e.index))
                        .toList(),
                    onSelect: (value) {
                      widget.searchProstheticDTO.setNull();
                      widget.searchProstheticDTO.singleAndBridgeAnd ??= ProstheticTreatmentFinalModel();
                      if (value.id == 3)
                        widget.searchProstheticDTO.singleAndBridgeAnd!.healingCollars = [FinalProthesisHealingCollarModel()];
                      else if (value.id == 4)
                        widget.searchProstheticDTO.singleAndBridgeAnd!.tryIns = [FinalProthesisTryInModel()];
                      else if (value.id == 5)
                        widget.searchProstheticDTO!.singleAndBridgeAnd!.delivery = [FinalProthesisDeliveryModel()];
                      else if (value.id == 6) widget.searchProstheticDTO.singleAndBridgeAnd!.impressions = [FinalProthesisImpressionModel()];
                      widget.searchProstheticDTO.searchType = EnumProstheticSearchType.SingleAndBridge;
                      setState(() => widget.searchProstheticDTO.prostheticType = EnumProstheticType.values[value.id!]);
                    },
                    selectedItem: BasicNameIdObjectEntity(
                        id: widget.searchProstheticDTO.prostheticType.index, name: widget.searchProstheticDTO.prostheticType.name),
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: widget.searchProstheticDTO.prostheticType == EnumProstheticType.HealingColar,
                    child: Column(
                      children: [
                        FormTextValueWidget(text: "Healing Collars"),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Status",
                          items: EnumFinalProthesisHealingCollarStatus.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.singleAndBridgeAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarStatus?.index,
                            name: widget.searchProstheticDTO.singleAndBridgeAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarStatus?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.singleAndBridgeAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.singleAndBridgeAnd!.healingCollars ??= [FinalProthesisHealingCollarModel()];
                            widget.searchProstheticDTO.singleAndBridgeAnd!.healingCollars!.first.finalProthesisHealingCollarStatus =
                                EnumFinalProthesisHealingCollarStatus.values[value.id!];

                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Next Visit",
                          items:
                              EnumFinalProthesisHealingCollarNextVisit.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget
                                .searchProstheticDTO.singleAndBridgeAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarNextVisit?.index,
                            name: widget
                                .searchProstheticDTO.singleAndBridgeAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarNextVisit?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.singleAndBridgeAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.singleAndBridgeAnd!.healingCollars ??= [FinalProthesisHealingCollarModel()];
                            widget.searchProstheticDTO.singleAndBridgeAnd!.healingCollars!.first.finalProthesisHealingCollarNextVisit =
                                EnumFinalProthesisHealingCollarNextVisit.values[value.id!];

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.searchProstheticDTO.prostheticType == EnumProstheticType.Impression,
                    child: Column(
                      children: [
                        FormTextValueWidget(text: "Impressions"),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Status",
                          items: EnumFinalProthesisImpressionStatus.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.singleAndBridgeAnd?.impressions?.firstOrNull?.finalProthesisImpressionStatus?.index,
                            name: widget.searchProstheticDTO.singleAndBridgeAnd?.impressions?.firstOrNull?.finalProthesisImpressionStatus?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.singleAndBridgeAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.singleAndBridgeAnd!.impressions ??= [FinalProthesisImpressionModel()];
                            widget.searchProstheticDTO.singleAndBridgeAnd!.impressions!.first.finalProthesisImpressionStatus =
                                EnumFinalProthesisImpressionStatus.values[value.id!];

                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Next Visit",
                          items: EnumFinalProthesisImpressionNextVisit.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.singleAndBridgeAnd?.impressions?.firstOrNull?.finalProthesisImpressionNextVisit?.index,
                            name: widget.searchProstheticDTO.singleAndBridgeAnd?.impressions?.firstOrNull?.finalProthesisImpressionNextVisit?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.singleAndBridgeAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.singleAndBridgeAnd!.impressions ??= [FinalProthesisImpressionModel()];
                            widget.searchProstheticDTO.singleAndBridgeAnd!.impressions!.first.finalProthesisImpressionNextVisit =
                                EnumFinalProthesisImpressionNextVisit.values[value.id!];

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.searchProstheticDTO.prostheticType == EnumProstheticType.TryIn,
                    child: Column(
                      children: [
                        FormTextValueWidget(text: "Try Ins"),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Status",
                          items: EnumFinalProthesisTryInStatus.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.singleAndBridgeAnd?.tryIns?.firstOrNull?.finalProthesisTryInStatus?.index,
                            name: widget.searchProstheticDTO.singleAndBridgeAnd?.tryIns?.firstOrNull?.finalProthesisTryInStatus?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.singleAndBridgeAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.singleAndBridgeAnd!.tryIns ??= [FinalProthesisTryInModel()];
                            widget.searchProstheticDTO.singleAndBridgeAnd!.tryIns!.first.finalProthesisTryInStatus =
                                EnumFinalProthesisTryInStatus.values[value.id!];

                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Next Visit",
                          items: EnumFinalProthesisTryInNextVisit.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.singleAndBridgeAnd?.tryIns?.firstOrNull?.finalProthesisTryInNextVisit?.index,
                            name: widget.searchProstheticDTO.singleAndBridgeAnd?.tryIns?.firstOrNull?.finalProthesisTryInNextVisit?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.singleAndBridgeAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.singleAndBridgeAnd!.tryIns ??= [FinalProthesisTryInModel()];
                            widget.searchProstheticDTO.singleAndBridgeAnd!.tryIns!.first.finalProthesisTryInNextVisit =
                                EnumFinalProthesisTryInNextVisit.values[value.id!];

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.searchProstheticDTO.prostheticType == EnumProstheticType.Delivery,
                    child: Column(
                      children: [
                        FormTextValueWidget(text: "Deliveries"),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Status",
                          items: EnumFinalProthesisDeliveryStatus.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.singleAndBridgeAnd?.delivery?.firstOrNull?.finalProthesisDeliveryStatus?.index,
                            name: widget.searchProstheticDTO.singleAndBridgeAnd?.delivery?.firstOrNull?.finalProthesisDeliveryStatus?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.singleAndBridgeAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.singleAndBridgeAnd!.delivery ??= [FinalProthesisDeliveryModel()];
                            widget.searchProstheticDTO.singleAndBridgeAnd!.delivery!.first.finalProthesisDeliveryStatus =
                                EnumFinalProthesisDeliveryStatus.values[value.id!];

                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Next Visit",
                          items: EnumFinalProthesisDeliveryNextVisit.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.singleAndBridgeAnd?.delivery?.firstOrNull?.finalProthesisDeliveryNextVisit?.index,
                            name: widget.searchProstheticDTO.singleAndBridgeAnd?.delivery?.firstOrNull?.finalProthesisDeliveryNextVisit?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.singleAndBridgeAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.singleAndBridgeAnd!.delivery ??= [FinalProthesisDeliveryModel()];
                            widget.searchProstheticDTO.singleAndBridgeAnd!.delivery!.first.finalProthesisDeliveryNextVisit =
                                EnumFinalProthesisDeliveryNextVisit.values[value.id!];

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.searchProstheticDTO.searchType == EnumProstheticSearchType.FullArch,
            child: AdvancedSearchFilterChildWidget(
              title: "Full Arch (All of the following)",
              child: Column(
                children: [
                  CIA_DropDownSearchBasicIdName(
                    items: EnumProstheticType.values
                        .getRange(3, EnumProstheticType.values.length)
                        .map((e) => BasicNameIdObjectEntity(name: e.name, id: e.index))
                        .toList(),
                    onSelect: (value) {
                      widget.searchProstheticDTO.setNull();
                      widget.searchProstheticDTO.fullArchAnd ??= ProstheticTreatmentFinalModel();
                      if (value.id == 3)
                        widget.searchProstheticDTO.fullArchAnd!.healingCollars = [FinalProthesisHealingCollarModel()];
                      else if (value.id == 4)
                        widget.searchProstheticDTO.fullArchAnd!.tryIns = [FinalProthesisTryInModel()];
                      else if (value.id == 5)
                        widget.searchProstheticDTO!.fullArchAnd!.delivery = [FinalProthesisDeliveryModel()];
                      else if (value.id == 6) widget.searchProstheticDTO.fullArchAnd!.impressions = [FinalProthesisImpressionModel()];
                      widget.searchProstheticDTO.searchType = EnumProstheticSearchType.FullArch;
                      setState(() => widget.searchProstheticDTO.prostheticType = EnumProstheticType.values[value.id!]);
                    },
                    selectedItem: BasicNameIdObjectEntity(
                        id: widget.searchProstheticDTO.prostheticType.index, name: widget.searchProstheticDTO.prostheticType.name),
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: widget.searchProstheticDTO.prostheticType == EnumProstheticType.HealingColar,
                    child: Column(
                      children: [
                        FormTextValueWidget(text: "Healing Collars"),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Status",
                          items: EnumFinalProthesisHealingCollarStatus.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.fullArchAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarStatus?.index,
                            name: widget.searchProstheticDTO.fullArchAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarStatus?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.fullArchAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.fullArchAnd!.healingCollars ??= [FinalProthesisHealingCollarModel()];
                            widget.searchProstheticDTO.fullArchAnd!.healingCollars!.first.finalProthesisHealingCollarStatus =
                                EnumFinalProthesisHealingCollarStatus.values[value.id!];

                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Next Visit",
                          items:
                              EnumFinalProthesisHealingCollarNextVisit.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.fullArchAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarNextVisit?.index,
                            name: widget.searchProstheticDTO.fullArchAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarNextVisit?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.fullArchAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.fullArchAnd!.healingCollars ??= [FinalProthesisHealingCollarModel()];
                            widget.searchProstheticDTO.fullArchAnd!.healingCollars!.first.finalProthesisHealingCollarNextVisit =
                                EnumFinalProthesisHealingCollarNextVisit.values[value.id!];

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.searchProstheticDTO.prostheticType == EnumProstheticType.Impression,
                    child: Column(
                      children: [
                        FormTextValueWidget(text: "Impressions"),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Status",
                          items: EnumFinalProthesisImpressionStatus.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.fullArchAnd?.impressions?.firstOrNull?.finalProthesisImpressionStatus?.index,
                            name: widget.searchProstheticDTO.fullArchAnd?.impressions?.firstOrNull?.finalProthesisImpressionStatus?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.fullArchAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.fullArchAnd!.impressions ??= [FinalProthesisImpressionModel()];
                            widget.searchProstheticDTO.fullArchAnd!.impressions!.first.finalProthesisImpressionStatus =
                                EnumFinalProthesisImpressionStatus.values[value.id!];

                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Next Visit",
                          items: EnumFinalProthesisImpressionNextVisit.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.fullArchAnd?.impressions?.firstOrNull?.finalProthesisImpressionNextVisit?.index,
                            name: widget.searchProstheticDTO.fullArchAnd?.impressions?.firstOrNull?.finalProthesisImpressionNextVisit?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.fullArchAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.fullArchAnd!.impressions ??= [FinalProthesisImpressionModel()];
                            widget.searchProstheticDTO.fullArchAnd!.impressions!.first.finalProthesisImpressionNextVisit =
                                EnumFinalProthesisImpressionNextVisit.values[value.id!];

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.searchProstheticDTO.prostheticType == EnumProstheticType.TryIn,
                    child: Column(
                      children: [
                        FormTextValueWidget(text: "Try Ins"),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Status",
                          items: EnumFinalProthesisTryInStatus.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.fullArchAnd?.tryIns?.firstOrNull?.finalProthesisTryInStatus?.index,
                            name: widget.searchProstheticDTO.fullArchAnd?.tryIns?.firstOrNull?.finalProthesisTryInStatus?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.fullArchAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.fullArchAnd!.tryIns ??= [FinalProthesisTryInModel()];
                            widget.searchProstheticDTO.fullArchAnd!.tryIns!.first.finalProthesisTryInStatus =
                                EnumFinalProthesisTryInStatus.values[value.id!];

                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Next Visit",
                          items: EnumFinalProthesisTryInNextVisit.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.fullArchAnd?.tryIns?.firstOrNull?.finalProthesisTryInNextVisit?.index,
                            name: widget.searchProstheticDTO.fullArchAnd?.tryIns?.firstOrNull?.finalProthesisTryInNextVisit?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.fullArchAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.fullArchAnd!.tryIns ??= [FinalProthesisTryInModel()];
                            widget.searchProstheticDTO.fullArchAnd!.tryIns!.first.finalProthesisTryInNextVisit =
                                EnumFinalProthesisTryInNextVisit.values[value.id!];

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.searchProstheticDTO.prostheticType == EnumProstheticType.Delivery,
                    child: Column(
                      children: [
                        FormTextValueWidget(text: "Deliveries"),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Status",
                          items: EnumFinalProthesisDeliveryStatus.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.fullArchAnd?.delivery?.firstOrNull?.finalProthesisDeliveryStatus?.index,
                            name: widget.searchProstheticDTO.fullArchAnd?.delivery?.firstOrNull?.finalProthesisDeliveryStatus?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.fullArchAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.fullArchAnd!.delivery ??= [FinalProthesisDeliveryModel()];
                            widget.searchProstheticDTO.fullArchAnd!.delivery!.first.finalProthesisDeliveryStatus =
                                EnumFinalProthesisDeliveryStatus.values[value.id!];

                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10),
                        CIA_DropDownSearchBasicIdName(
                          label: "Next Visit",
                          items: EnumFinalProthesisDeliveryNextVisit.values.map((e) => BasicNameIdObjectEntity(id: e.index, name: e.name)).toList(),
                          selectedItem: BasicNameIdObjectEntity(
                            id: widget.searchProstheticDTO.fullArchAnd?.delivery?.firstOrNull?.finalProthesisDeliveryNextVisit?.index,
                            name: widget.searchProstheticDTO.fullArchAnd?.delivery?.firstOrNull?.finalProthesisDeliveryNextVisit?.name,
                          ),
                          onSelect: (value) {
                            widget.searchProstheticDTO.fullArchAnd ??= ProstheticTreatmentFinalModel();
                            widget.searchProstheticDTO.fullArchAnd!.delivery ??= [FinalProthesisDeliveryModel()];
                            widget.searchProstheticDTO.fullArchAnd!.delivery!.first.finalProthesisDeliveryNextVisit =
                                EnumFinalProthesisDeliveryNextVisit.values[value.id!];

                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          AdvancedSearchFilterChildWidget(
              title: "Post Prosthesis Complications (One of the following)",
              child: Column(
                children: [
                  CIA_CheckBoxWidget(
                    text: "All",
                    value: widget.searchProstheticDTO.complicationsOr?.isNull() ?? true,
                    onChange: (value) {
                      setState(() {
                        widget.searchProstheticDTO.complicationsOr = null;
                      });
                    },
                  ),
                  CIA_CheckBoxWidget(
                    text: "Screw Loosness",
                    value: widget.searchProstheticDTO.complicationsOr?.screwLoosness == true,
                    onChange: (value) {
                      widget.searchProstheticDTO.complicationsOr ??= ComplicationsAfterProsthesisEntity();
                      widget.searchProstheticDTO.complicationsOr!.screwLoosness = value;
                      if (value == true) widget.searchProstheticDTO.complicationsAnd?.screwLoosness = null;
                      setState(() {});
                    },
                  ),
                  CIA_CheckBoxWidget(
                    text: "Crown Fall",
                    value: widget.searchProstheticDTO.complicationsOr?.crownFall == true,
                    onChange: (value) {
                      widget.searchProstheticDTO.complicationsOr ??= ComplicationsAfterProsthesisEntity();
                      widget.searchProstheticDTO.complicationsOr!.crownFall = value;
                      if (value == true) widget.searchProstheticDTO.complicationsAnd?.crownFall = null;
                      setState(() {});
                    },
                  ),
                  CIA_CheckBoxWidget(
                    text: "Fractured Zirconia",
                    value: widget.searchProstheticDTO.complicationsOr?.fracturedZirconia == true,
                    onChange: (value) {
                      widget.searchProstheticDTO.complicationsOr ??= ComplicationsAfterProsthesisEntity();
                      widget.searchProstheticDTO.complicationsOr!.fracturedZirconia = value;
                      if (value == true) widget.searchProstheticDTO.complicationsAnd?.fracturedZirconia = null;
                      setState(() {});
                    },
                  ),
                  CIA_CheckBoxWidget(
                    text: "Fractured Printed PMMA",
                    value: widget.searchProstheticDTO.complicationsOr?.fracturedPrintedPMMA == true,
                    onChange: (value) {
                      widget.searchProstheticDTO.complicationsOr ??= ComplicationsAfterProsthesisEntity();
                      widget.searchProstheticDTO.complicationsOr!.fracturedPrintedPMMA = value;
                      if (value == true) widget.searchProstheticDTO.complicationsAnd?.fracturedPrintedPMMA = null;
                      setState(() {});
                    },
                  ),
                  CIA_CheckBoxWidget(
                    text: "Food Impaction",
                    value: widget.searchProstheticDTO.complicationsOr?.foodImpaction == true,
                    onChange: (value) {
                      widget.searchProstheticDTO.complicationsOr ??= ComplicationsAfterProsthesisEntity();
                      widget.searchProstheticDTO.complicationsOr!.foodImpaction = value;
                      if (value == true) widget.searchProstheticDTO.complicationsAnd?.foodImpaction = null;
                      setState(() {});
                    },
                  ),
                  CIA_CheckBoxWidget(
                    text: "Pain",
                    value: widget.searchProstheticDTO.complicationsOr?.pain == true,
                    onChange: (value) {
                      widget.searchProstheticDTO.complicationsOr ??= ComplicationsAfterProsthesisEntity();
                      widget.searchProstheticDTO.complicationsOr!.pain = value;
                      if (value == true) widget.searchProstheticDTO.complicationsAnd?.pain = null;
                      setState(() {});
                    },
                  ),
                  ],
              )),
          AdvancedSearchFilterChildWidget(
              title: "Post Prosthesis Complications (All of the following)",
              child: Column(
                children: [
                  CIA_CheckBoxWidget(
                    text: "All",
                    value: widget.searchProstheticDTO.complicationsAnd?.isNull() ?? true,
                    onChange: (value) {
                      setState(() {
                        widget.searchProstheticDTO.complicationsAnd = null;
                      });
                    },
                  ),
                  CIA_CheckBoxWidget(
                    text: "Screw Loosness",
                    value: widget.searchProstheticDTO.complicationsAnd?.screwLoosness == true,
                    onChange: (value) {
                      widget.searchProstheticDTO.complicationsAnd ??= ComplicationsAfterProsthesisEntity();
                      widget.searchProstheticDTO.complicationsAnd!.screwLoosness = value;
                      if (value == true) widget.searchProstheticDTO.complicationsAnd?.screwLoosness = null;
                      setState(() {});
                    },
                  ),
                  CIA_CheckBoxWidget(
                    text: "Crown Fall",
                    value: widget.searchProstheticDTO.complicationsAnd?.crownFall == true,
                    onChange: (value) {
                      widget.searchProstheticDTO.complicationsAnd ??= ComplicationsAfterProsthesisEntity();
                      widget.searchProstheticDTO.complicationsAnd!.crownFall = value;
                      if (value == true) widget.searchProstheticDTO.complicationsOr?.crownFall = null;
                      setState(() {});
                    },
                  ),
                  CIA_CheckBoxWidget(
                    text: "Fractured Zirconia",
                    value: widget.searchProstheticDTO.complicationsAnd?.fracturedZirconia == true,
                    onChange: (value) {
                      widget.searchProstheticDTO.complicationsAnd ??= ComplicationsAfterProsthesisEntity();
                      widget.searchProstheticDTO.complicationsAnd!.fracturedZirconia = value;
                      if (value == true) widget.searchProstheticDTO.complicationsOr?.fracturedZirconia = null;
                      setState(() {});
                    },
                  ),
                  CIA_CheckBoxWidget(
                    text: "Fractured Printed PMMA",
                    value: widget.searchProstheticDTO.complicationsAnd?.fracturedPrintedPMMA == true,
                    onChange: (value) {
                      widget.searchProstheticDTO.complicationsAnd ??= ComplicationsAfterProsthesisEntity();
                      widget.searchProstheticDTO.complicationsAnd!.fracturedPrintedPMMA = value;
                      if (value == true) widget.searchProstheticDTO.complicationsOr?.fracturedPrintedPMMA = null;
                      setState(() {});
                    },
                  ),
                  CIA_CheckBoxWidget(
                    text: "Food Impaction",
                    value: widget.searchProstheticDTO.complicationsAnd?.foodImpaction == true,
                    onChange: (value) {
                      widget.searchProstheticDTO.complicationsAnd ??= ComplicationsAfterProsthesisEntity();
                      widget.searchProstheticDTO.complicationsAnd!.foodImpaction = value;
                      if (value == true) widget.searchProstheticDTO.complicationsOr?.foodImpaction = null;
                      setState(() {});
                    },
                  ),
                  CIA_CheckBoxWidget(
                    text: "Pain",
                    value: widget.searchProstheticDTO.complicationsAnd?.pain == true,
                    onChange: (value) {
                      widget.searchProstheticDTO.complicationsAnd ??= ComplicationsAfterProsthesisEntity();
                      widget.searchProstheticDTO.complicationsAnd!.pain = value;
                      if (value == true) widget.searchProstheticDTO.complicationsOr?.pain = null;
                      setState(() {});
                    },
                  ),
                  ],
              )),
        ],
      ),
    );
  }
}
