import 'package:cariro_implant_academy/Widgets/CIA_SecondaryButton.dart';
import 'package:cariro_implant_academy/Widgets/CIA_TagsInputWidget.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedProstheticSearchRequestEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as syncFusionExcel;
import 'dart:convert';
import 'dart:html';

class AdvancedSearchFiltersSummaryWidget extends StatelessWidget {
  AdvancedSearchFiltersSummaryWidget({
    super.key,
    required this.searchDTO,
    required this.searchProstheticDTO,
    required this.searchTreatmentsDTO,
    required this.onRemove,
    required this.treatmentItems,
    required this.exportToExcel,
  });

  AdvancedPatientSearchEntity searchDTO;
  AdvancedTreatmentSearchEntity searchTreatmentsDTO;
  List<TreatmentItemEntity> treatmentItems;
  AdvancedProstheticSearchRequestEntity searchProstheticDTO;
  Function() exportToExcel;
  Function(
    AdvancedPatientSearchEntity onRemoveSearchDTO,
    AdvancedTreatmentSearchEntity onRemoveSearchTreatmentsDTO,
    AdvancedProstheticSearchRequestEntity onRemoveSearchProstheticDTO,
  ) onRemove;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CIA_TagsInputWidget(
          label: "Personal Info filters",
          disableBorder: true,
          initialValue: getPatientFilterTags(),
          onDelete: (p0) => removeFilterTags(p0),
        ),
        Visibility(
          visible: searchTreatmentsDTO.noTreatmentPlan != true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CIA_TagsInputWidget(
              label: "${searchTreatmentsDTO.done == true ? "Done" : "Planned"}: Patient with one of the following treatments",
              disableBorder: true,
              initialValue: getTreatmentOrFilterTags(),
              onDelete: (p0) => removeFilterTags(p0),
            ),
          ),
        ),
        Visibility(
          visible: searchTreatmentsDTO.noTreatmentPlan != true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CIA_TagsInputWidget(
              label: "${searchTreatmentsDTO.done == true ? "Done" : "Planned"}: Patient with all of the following treatments",
              disableBorder: true,
              initialValue: getTreatmentAndFilterTags(),
              onDelete: (p0) => removeFilterTags(p0),
            ),
          ),
        ),
        Visibility(
          visible: searchTreatmentsDTO.noTreatmentPlan == true,
          child: FormTextKeyWidget(
            text: "No Treatment Plans or Surgeries",
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CIA_SecondaryButton(
              label: "Export Excel",
              icon: Icon(Icons.table_chart_rounded),
              onTab: () {
                exportToExcel();
              },
            ),
          ],
        )
      ],
    );
  }

  List<String> getPatientFilterTags() {
    List<String> filters = [];

    if (searchDTO.gender != null) {
      filters.add("Gender: ${searchDTO.gender!.name}");
    }
    if (searchDTO.ageRangeFrom != null) {
      filters.add("Age from: ${searchDTO.ageRangeFrom}");
    }
    if (searchDTO.ageRangeTo != null) {
      filters.add("Age to: ${searchDTO.ageRangeTo}");
    }
    if (searchDTO.anyDiseases != null) {
      filters.add("Diseases: ${searchDTO.anyDiseases! ? "Yes" : "No"}");
    }
    if (searchDTO.bloodPressureCategories != null) {
      searchDTO.bloodPressureCategories!.forEach((element) {
        filters.add("Blood Pressure: ${element.name}");
      });
    }
    if (searchDTO.diabetesCategories != null) {
      searchDTO.diabetesCategories!.forEach((element) {
        filters.add("Diabetes: ${element.name}");
      });
    }
    if (searchDTO.lastHAB1cFrom != null) {
      filters.add("Last HAB1c From: ${searchDTO.lastHAB1cFrom}");
    }
    if (searchDTO.lastHAB1cTo != null) {
      filters.add("Last HAB1c To: ${searchDTO.lastHAB1cTo}");
    }
    if (searchDTO.penecilin != null) {
      filters.add("Penecilin: ${searchDTO.penecilin! ? "Yes" : "No"}");
    }
    if (searchDTO.illegalDrugs != null) {
      filters.add("Illegal Drugs: ${searchDTO.illegalDrugs! ? "Yes" : "No"}");
    }
    if (searchDTO.pregnancy != null) {
      filters.add("Pregnancy: ${searchDTO.pregnancy!.name}");
    }
    if (searchDTO.chewing != null) {
      filters.add("Chewing: ${searchDTO.chewing! ? "Yes" : "No"}");
    }
    if (searchDTO.smokingStatus != null) {
      filters.add("Smoking Status: ${searchDTO.smokingStatus!.name}");
    }
    if (searchDTO.cooperationScore != null) {
      filters.add("Cooperation Score: ${searchDTO.cooperationScore!.name}");
    }
    if (searchDTO.oralHygieneRating != null) {
      filters.add("Oral Hygiene Rating: ${searchDTO.oralHygieneRating!.name}");
    }

    return filters;
  }

  List<String> getTreatmentOrFilterTags() {
    List<String> filters = [];
    // if (!(searchTreatmentsDTO.complicationsAfterSurgeryIdsOr?.isNull() ?? true)) {
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.swelling == true) {
    //     filters.add("Surgery Complications: Swelling");
    //   }
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.openWound == true) {
    //     filters.add("Surgery Complications: OpenWound");
    //   }
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.numbness == true) {
    //     filters.add("Surgery Complications: Numbness");
    //   }
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.oroantralCommunication == true)
    //     filters.add("Surgery Complications: Oroantral Communication");
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.pusInImplantSite == true) filters.add("Surgery Complications: Pus In Implant Site");
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.pusInDonorSite == true) {
    //     filters.add("Surgery Complications: Pus In Donor Site");
    //   }
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.sinusElevationFailure == true)
    //     filters.add("Surgery Complications: Sinus Elevation Failure");
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.gbrFailure == true) {
    //     filters.add("Surgery Complications: GBR Failure");
    //   }
    // }
    // if (!(searchProstheticDTO.complicationsOr?.isNull() ?? true)) {
    //   if (searchProstheticDTO.complicationsOr!.screwLoosness == true) {
    //     filters.add("Prosthetic Complications: Screw Loosness");
    //   }
    //   if (searchProstheticDTO.complicationsOr!.crownFall == true) {
    //     filters.add("Prosthetic Complications: Crown Fall");
    //   }
    //   if (searchProstheticDTO.complicationsOr!.fracturedZirconia == true) {
    //     filters.add("Prosthetic Complications: Fractured Zirconia");
    //   }
    //   if (searchProstheticDTO.complicationsOr!.fracturedPrintedPMMA == true) filters.add("Prosthetic Complications: Fractrured Printed PMMA");
    //   if (searchProstheticDTO.complicationsOr!.foodImpaction == true) filters.add("Prosthetic Complications: Food Impaction");
    //   if (searchProstheticDTO.complicationsOr!.pain == true) {
    //     filters.add("Prosthetic Complications: Pain");
    //   }
    // }
    for (var queryItem in searchTreatmentsDTO.or_treatmentIds ?? []) {
      filters.add(treatmentItems.firstWhere((element) => element.id == queryItem).name ?? "");
    }

    return filters;
  }

  List<String> getTreatmentAndFilterTags() {
    List<String> filters = [];
    // if (!(searchTreatmentsDTO.complicationsAfterSurgeryIds?.isNull() ?? true)) {
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIds!.swelling == true) {
    //     filters.add("Surgery Complications: Swelling");
    //   }
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIds!.openWound == true) {
    //     filters.add("Surgery Complications: OpenWound");
    //   }
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIds!.numbness == true) {
    //     filters.add("Surgery Complications: Numbness");
    //   }
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIds!.oroantralCommunication == true)
    //     filters.add("Surgery Complications: Oroantral Communication");
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIds!.pusInImplantSite == true) filters.add("Surgery Complications: Pus In Implant Site");
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIds!.pusInDonorSite == true) {
    //     filters.add("Surgery Complications: Pus In Donor Site");
    //   }
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIds!.sinusElevationFailure == true)
    //     filters.add("Surgery Complications: Sinus Elevation Failure");
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIds!.gbrFailure == true) {
    //     filters.add("Surgery Complications: GBR Failure");
    //   }
    // }

    // if (searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.diagnostic != null) {
    //   filters.add(
    //       "Diagnostic Impression Diagnosis ${searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.diagnostic?.name}");
    // }
    // if (searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.nextStep != null) {
    //   filters.add(
    //       "Diagnostic Impression Next Step ${searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.nextStep?.name}");
    // }
    // if (searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.needsRemake != null) {
    //   filters.add("Diagnostic Impression Needs Remake");
    // }
    // if (searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.scanned != null) {
    //   filters.add("Diagnostic Impression Scanned");
    // }
    // if (searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.diagnostic != null) {
    //   filters.add("Bite Diagnostic ${searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.diagnostic?.name}");
    // }
    // if (searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.nextStep != null) {
    //   filters.add("Bite Next Step ${searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.nextStep?.name}");
    // }
    // if (searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.needsRemake != null) {
    //   filters.add("Bite Needs Remake");
    // }
    // if (searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.scanned != null) {
    //   filters.add("Bite Scanned");
    // }
    // if (searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.diagnostic != null) {
    //   filters
    //       .add("Scan Appliance Diagnostic ${searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.diagnostic?.name}");
    // }
    // if (searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.needsRemake != null) {
    //   filters.add("Scan Appliance Needs Remake");
    // }
    // if (searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.scanned != null) {
    //   filters.add("Scan Appliance Scanned");
    // }

    // if (searchProstheticDTO?.singleAndBridgeAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarStatus != null) {
    //   filters.add(
    //       "Single & Bridge Healing Collar Status ${searchProstheticDTO?.singleAndBridgeAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarStatus?.name}");
    // }
    // if (searchProstheticDTO?.singleAndBridgeAnd?.impressions?.firstOrNull?.finalProthesisImpressionStatus != null) {
    //   filters.add(
    //       "Single & Bridge Impression Procedure ${searchProstheticDTO?.singleAndBridgeAnd?.impressions?.firstOrNull?.finalProthesisImpressionStatus?.name}");
    // }
    // if (searchProstheticDTO?.singleAndBridgeAnd?.impressions?.firstOrNull?.finalProthesisImpressionNextVisit != null) {
    //   filters.add(
    //       "Single & Bridge Impression Next Visit ${searchProstheticDTO?.singleAndBridgeAnd?.impressions?.firstOrNull?.finalProthesisImpressionNextVisit?.name}");
    // }
    // if (searchProstheticDTO?.singleAndBridgeAnd?.tryIns?.firstOrNull?.finalProthesisTryInStatus != null) {
    //   filters
    //       .add("Single & Bridge Try In Procedure ${searchProstheticDTO?.singleAndBridgeAnd?.tryIns?.firstOrNull?.finalProthesisTryInStatus?.name}");
    // }
    // if (searchProstheticDTO?.singleAndBridgeAnd?.tryIns?.firstOrNull?.finalProthesisTryInNextVisit != null) {
    //   filters.add(
    //       "Single & Bridge Try In Next Visit ${searchProstheticDTO?.singleAndBridgeAnd?.tryIns?.firstOrNull?.finalProthesisTryInNextVisit?.name}");
    // }
    // if (searchProstheticDTO?.singleAndBridgeAnd?.delivery?.firstOrNull?.finalProthesisDeliveryStatus != null) {
    //   filters.add(
    //       "Single & Bridge Delivery Procedure ${searchProstheticDTO?.singleAndBridgeAnd?.delivery?.firstOrNull?.finalProthesisDeliveryStatus?.name}");
    // }
    // if (searchProstheticDTO?.singleAndBridgeAnd?.delivery?.firstOrNull?.finalProthesisDeliveryNextVisit != null) {
    //   filters.add(
    //       "Single & Bridge Delivery Next Visit ${searchProstheticDTO?.singleAndBridgeAnd?.delivery?.firstOrNull?.finalProthesisDeliveryNextVisit?.name}");
    // }
    // if (searchProstheticDTO?.fullArchAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarStatus != null) {
    //   filters.add(
    //       "Full Arch Healing Collar Status ${searchProstheticDTO?.fullArchAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarStatus?.name}");
    // }
    // if (searchProstheticDTO?.fullArchAnd?.impressions?.firstOrNull?.finalProthesisImpressionStatus != null) {
    //   filters
    //       .add("Full Arch Impression Procedure ${searchProstheticDTO?.fullArchAnd?.impressions?.firstOrNull?.finalProthesisImpressionStatus?.name}");
    // }
    // if (searchProstheticDTO?.fullArchAnd?.impressions?.firstOrNull?.finalProthesisImpressionNextVisit != null) {
    //   filters.add(
    //       "Full Arch Impression Next Visit ${searchProstheticDTO?.fullArchAnd?.impressions?.firstOrNull?.finalProthesisImpressionNextVisit?.name}");
    // }
    // if (searchProstheticDTO?.fullArchAnd?.tryIns?.firstOrNull?.finalProthesisTryInStatus != null) {
    //   filters.add("Full Arch Try In Procedure ${searchProstheticDTO?.fullArchAnd?.tryIns?.firstOrNull?.finalProthesisTryInStatus?.name}");
    // }
    // if (searchProstheticDTO?.fullArchAnd?.tryIns?.firstOrNull?.finalProthesisTryInNextVisit != null) {
    //   filters.add("Full Arch Try In Next Visit ${searchProstheticDTO?.fullArchAnd?.tryIns?.firstOrNull?.finalProthesisTryInNextVisit?.name}");
    // }
    // if (searchProstheticDTO?.fullArchAnd?.delivery?.firstOrNull?.finalProthesisDeliveryStatus != null) {
    //   filters.add("Full Arch Delivery Procedure ${searchProstheticDTO?.fullArchAnd?.delivery?.firstOrNull?.finalProthesisDeliveryStatus?.name}");
    // }
    // if (searchProstheticDTO?.fullArchAnd?.delivery?.firstOrNull?.finalProthesisDeliveryNextVisit != null) {
    //   filters.add("Full Arch Delivery Next Visit ${searchProstheticDTO?.fullArchAnd?.delivery?.firstOrNull?.finalProthesisDeliveryNextVisit?.name}");
    // }

    // if (!(searchProstheticDTO.complicationsAnd?.isNull() ?? true)) {
    //   if (searchProstheticDTO.complicationsAnd!.screwLoosness == true) {
    //     filters.add("Prosthetic Complications: Screw Loosness");
    //   }
    //   if (searchProstheticDTO.complicationsAnd!.crownFall == true) {
    //     filters.add("Prosthetic Complications: Crown Fall");
    //   }
    //   if (searchProstheticDTO.complicationsAnd!.fracturedZirconia == true) {
    //     filters.add("Prosthetic Complications: Fractured Zirconia");
    //   }
    //   if (searchProstheticDTO.complicationsAnd!.fracturedPrintedPMMA == true) filters.add("Prosthetic Complications: Fractrured Printed PMMA");
    //   if (searchProstheticDTO.complicationsAnd!.foodImpaction == true) filters.add("Prosthetic Complications: Food Impaction");
    //   if (searchProstheticDTO.complicationsAnd!.pain == true) {
    //     filters.add("Prosthetic Complications: Pain");
    //   }
    // }
    if (searchTreatmentsDTO.implantFailed == true) {
      filters.add("Implant Failed");
    }

    for (var queryItem in searchTreatmentsDTO.and_treatmentIds ?? []) {
      filters.add(treatmentItems.firstWhere((element) => element.id == queryItem).name ?? "");
    }
    return filters;
  }

  void removeFilterTags(String filter) {
    // if (filter.contains("Surgery Complications")) {
    //   if (filter.contains("Surgery Complications: Swelling")) {
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIds != null) searchTreatmentsDTO.complicationsAfterSurgeryIds!.swelling = null;
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr != null) searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.swelling = null;
    //   }
    //   if (filter.contains("Surgery Complications: OpenWound")) {
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIds != null) searchTreatmentsDTO.complicationsAfterSurgeryIds!.openWound = null;
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr != null) searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.openWound = null;
    //   }
    //   if (filter.contains("Surgery Complications: Numbness")) {
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIds != null) searchTreatmentsDTO.complicationsAfterSurgeryIds!.numbness = null;
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr != null) searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.numbness = null;
    //   }
    //   if (filter.contains("Surgery Complications: Oroantral Communication")) {
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIds != null) searchTreatmentsDTO.complicationsAfterSurgeryIds!.oroantralCommunication = null;
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr != null)
    //       searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.oroantralCommunication = null;
    //   }
    //   if (filter.contains("Surgery Complications: Pus In Implant Site")) {
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIds != null) searchTreatmentsDTO.complicationsAfterSurgeryIds!.pusInImplantSite = null;
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr != null) searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.pusInImplantSite = null;
    //   }
    //   if (filter.contains("Surgery Complications: Pus In Donor Site")) {
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIds != null) searchTreatmentsDTO.complicationsAfterSurgeryIds!.pusInDonorSite = null;
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr != null) searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.pusInDonorSite = null;
    //   }
    //   if (filter.contains("Surgery Complications: Sinus Elevation Failure")) {
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIds != null) searchTreatmentsDTO.complicationsAfterSurgeryIds!.sinusElevationFailure = null;
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr != null)
    //       searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.sinusElevationFailure = null;
    //   }
    //   if (filter.contains("Surgery Complications: GBR Failure")) {
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIds != null) searchTreatmentsDTO.complicationsAfterSurgeryIds!.gbrFailure = null;
    //     if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr != null) searchTreatmentsDTO.complicationsAfterSurgeryIdsOr!.gbrFailure = null;
    //   }
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIds?.isNull() ?? true) {
    //     searchTreatmentsDTO.complicationsAfterSurgeryIds = null;
    //   }
    //   if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr?.isNull() ?? true) {
    //     searchTreatmentsDTO.complicationsAfterSurgeryIdsOr = null;
    //   }
    // }
    // if (filter.contains("Prosthetic Complications")) {
    //   if (filter.contains("Prosthetic Complications: Screw Loosness")) {
    //     if (searchProstheticDTO.complicationsAnd != null) searchProstheticDTO.complicationsAnd!.screwLoosness = null;
    //     if (searchProstheticDTO.complicationsOr != null) searchProstheticDTO.complicationsOr!.screwLoosness = null;
    //   }
    //   if (filter.contains("Prosthetic Complications: Crown Fall")) {
    //     if (searchProstheticDTO.complicationsAnd != null) searchProstheticDTO.complicationsAnd!.crownFall = null;
    //     if (searchProstheticDTO.complicationsOr != null) searchProstheticDTO.complicationsOr!.crownFall = null;
    //   }
    //   if (filter.contains("Prosthetic Complications: Fractured Zirconia")) {
    //     if (searchProstheticDTO.complicationsAnd != null) searchProstheticDTO.complicationsAnd!.fracturedZirconia = null;
    //     if (searchProstheticDTO.complicationsOr != null) searchProstheticDTO.complicationsOr!.fracturedZirconia = null;
    //   }
    //   if (filter.contains("Prosthetic Complications: Fractrured Printed PMMA")) {
    //     if (searchProstheticDTO.complicationsAnd != null) searchProstheticDTO.complicationsAnd!.fracturedPrintedPMMA = null;
    //     if (searchProstheticDTO.complicationsOr != null) searchProstheticDTO.complicationsOr!.fracturedPrintedPMMA = null;
    //   }
    //   if (filter.contains("Prosthetic Complications: Food Impaction")) {
    //     if (searchProstheticDTO.complicationsAnd != null) searchProstheticDTO.complicationsAnd!.foodImpaction = null;
    //     if (searchProstheticDTO.complicationsOr != null) searchProstheticDTO.complicationsOr!.foodImpaction = null;
    //   }
    //   if (filter.contains("Prosthetic Complications: Pain")) {
    //     if (searchProstheticDTO.complicationsAnd != null) searchProstheticDTO.complicationsAnd!.pain = null;
    //     if (searchProstheticDTO.complicationsOr != null) searchProstheticDTO.complicationsOr!.pain = null;
    //   }

    //   // if (searchTreatmentsDTO.complicationsAfterSurgeryIds?.isNull() ?? true) {
    //   //   searchTreatmentsDTO.complicationsAfterSurgeryIds = null;
    //   // }
    //   // if (searchTreatmentsDTO.complicationsAfterSurgeryIdsOr?.isNull() ?? true) {
    //   //   searchTreatmentsDTO.complicationsAfterSurgeryIdsOr = null;
    //   // }

    //   if (searchProstheticDTO.complicationsAnd?.isNull() ?? true) {
    //     searchProstheticDTO.complicationsAnd = null;
    //   }
    //   if (searchProstheticDTO.complicationsOr?.isNull() ?? true) {
    //     searchProstheticDTO.complicationsOr = null;
    //   }
    // }

    // if (filter.contains("Diagnostic Impression Diagnosis")) {
    //   searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.diagnostic = null;
    // }
    // if (filter.contains("Diagnostic Impression Next Step")) {
    //   searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.nextStep = null;
    // }
    // if (filter.contains("Diagnostic Impression Needs Remake")) {
    //   searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.needsRemake = null;
    // }
    // if (filter.contains("Diagnostic Impression Scanned")) {
    //   searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.scanned = null;
    // }
    // if (filter.contains("Bite Diagnostic")) {
    //   searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.diagnostic = null;
    // }
    // if (filter.contains("Bite Next Step")) {
    //   searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.nextStep = null;
    // }
    // if (filter.contains("Bite Needs Remake")) {
    //   searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.needsRemake = null;
    // }
    // if (filter.contains("Bite Scanned")) {
    //   searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.scanned = null;
    // }
    // if (filter.contains("Scan Appliance Diagnostic")) {
    //   searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.diagnostic = null;
    // }
    // if (filter.contains("Scan Appliance Needs Remake")) {
    //   searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.needsRemake = null;
    // }
    // if (filter.contains("Scan Appliance Scanned")) {
    //   searchProstheticDTO?.diagnosticAnd?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.scanned = null;
    // }

    // if (filter.contains("Single & Bridge Healing Collar Status")) {
    //   searchProstheticDTO?.singleAndBridgeAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarStatus = null;
    // }
    // if (filter.contains("Single & Bridge Impression Procedure")) {
    //   searchProstheticDTO?.singleAndBridgeAnd?.impressions?.firstOrNull?.finalProthesisImpressionStatus = null;
    // }
    // if (filter.contains("Single & Bridge Impression Next Visit")) {
    //   searchProstheticDTO?.singleAndBridgeAnd?.impressions?.firstOrNull?.finalProthesisImpressionNextVisit = null;
    // }
    // if (filter.contains("Single & Bridge Try In Procedure")) {
    //   searchProstheticDTO?.singleAndBridgeAnd?.tryIns?.firstOrNull?.finalProthesisTryInStatus = null;
    // }
    // if (filter.contains("Single & Bridge Try In Next Visit")) {
    //   searchProstheticDTO?.singleAndBridgeAnd?.tryIns?.firstOrNull?.finalProthesisTryInNextVisit = null;
    // }
    // if (filter.contains("Single & Bridge Delivery Procedure")) {
    //   searchProstheticDTO?.singleAndBridgeAnd?.delivery?.firstOrNull?.finalProthesisDeliveryStatus = null;
    // }
    // if (filter.contains("Single & Bridge Delivery Next Visit")) {
    //   searchProstheticDTO?.singleAndBridgeAnd?.delivery?.firstOrNull?.finalProthesisDeliveryNextVisit = null;
    // }
    // if (filter.contains("Full Arch Healing Collar Status")) {
    //   searchProstheticDTO?.fullArchAnd?.healingCollars?.firstOrNull?.finalProthesisHealingCollarStatus = null;
    // }
    // if (filter.contains("Full Arch Impression Procedure")) {
    //   searchProstheticDTO?.fullArchAnd?.impressions?.firstOrNull?.finalProthesisImpressionStatus = null;
    // }
    // if (filter.contains("Full Arch Impression Next Visit")) {
    //   searchProstheticDTO?.fullArchAnd?.impressions?.firstOrNull?.finalProthesisImpressionNextVisit = null;
    // }
    // if (filter.contains("Full Arch Try In Procedure")) {
    //   searchProstheticDTO?.fullArchAnd?.tryIns?.firstOrNull?.finalProthesisTryInStatus = null;
    // }
    // if (filter.contains("Full Arch Try In Next Visit")) {
    //   searchProstheticDTO?.fullArchAnd?.tryIns?.firstOrNull?.finalProthesisTryInNextVisit = null;
    // }
    // if (filter.contains("Full Arch Delivery Procedure")) {
    //   searchProstheticDTO?.fullArchAnd?.delivery?.firstOrNull?.finalProthesisDeliveryStatus = null;
    // }
    // if (filter.contains("Full Arch Delivery Next Visit")) {
    //   searchProstheticDTO?.fullArchAnd?.delivery?.firstOrNull?.finalProthesisDeliveryNextVisit = null;
    // }
    // if ((searchProstheticDTO.singleAndBridgeAnd?.healingCollars?.firstOrNull?.isNull() ?? true)) {
    //   searchProstheticDTO.singleAndBridgeAnd?.healingCollars = null;
    // }
    // if ((searchProstheticDTO.singleAndBridgeAnd?.tryIns?.firstOrNull?.isNull() ?? true)) {
    //   searchProstheticDTO.singleAndBridgeAnd?.tryIns = null;
    // }
    // if ((searchProstheticDTO.singleAndBridgeAnd?.delivery?.firstOrNull?.isNull() ?? true)) {
    //   searchProstheticDTO.singleAndBridgeAnd?.tryIns = null;
    // }
    // if ((searchProstheticDTO.singleAndBridgeAnd?.impressions?.firstOrNull?.isNull() ?? true)) {
    //   searchProstheticDTO.singleAndBridgeAnd?.impressions = null;
    // }
    // if ((searchProstheticDTO.singleAndBridgeAnd?.isNull() ?? true)) searchProstheticDTO.singleAndBridgeAnd = null;
    // if ((searchProstheticDTO.fullArchAnd?.healingCollars?.firstOrNull?.isNull() ?? true)) {
    //   searchProstheticDTO.fullArchAnd?.healingCollars = null;
    // }
    // if ((searchProstheticDTO.fullArchAnd?.tryIns?.firstOrNull?.isNull() ?? true)) {
    //   searchProstheticDTO.fullArchAnd?.tryIns = null;
    // }
    // if ((searchProstheticDTO.fullArchAnd?.delivery?.firstOrNull?.isNull() ?? true)) {
    //   searchProstheticDTO.fullArchAnd?.tryIns = null;
    // }
    // if ((searchProstheticDTO.fullArchAnd?.impressions?.firstOrNull?.isNull() ?? true)) {
    //   searchProstheticDTO.fullArchAnd?.impressions = null;
    // }
    // if ((searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_Bite?.firstOrNull?.isNull() ?? true)) {
    //   searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_Bite = null;
    // }
    // if ((searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_ScanAppliance?.firstOrNull?.isNull() ?? true)) {
    //   searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_ScanAppliance = null;
    // }
    // if ((searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression?.firstOrNull?.isNull() ?? true)) {
    //   searchProstheticDTO.diagnosticAnd?.prostheticDiagnostic_DiagnosticImpression = null;
    // }
    // if ((searchProstheticDTO.fullArchAnd?.isNull() ?? true)) searchProstheticDTO.fullArchAnd = null;
    // if ((searchProstheticDTO.singleAndBridgeAnd?.isNull() ?? true)) searchProstheticDTO.singleAndBridgeAnd = null;
    // if ((searchProstheticDTO.diagnosticAnd?.isNull() ?? true)) searchProstheticDTO.diagnosticAnd = null;

    if (filter == "Implant Failed") {
      searchTreatmentsDTO.implantFailed = null;
    }
    var fromTreatmentItems = treatmentItems.firstWhereOrNull((element) => element.name == filter);
    if (fromTreatmentItems != null) {
      searchTreatmentsDTO.and_treatmentIds!.remove(fromTreatmentItems.id!);
      searchTreatmentsDTO.or_treatmentIds!.remove(fromTreatmentItems.id!);
    }

    if (filter == "Gender: ${searchDTO.gender?.name}") searchDTO.gender = null;
    if (filter == "Age from: ${searchDTO.ageRangeFrom}") {
      searchDTO.ageRangeFrom = null;
    }
    if (filter == "Age to: ${searchDTO.ageRangeTo}") {
      searchDTO.ageRangeTo = null;
    }
    if (filter.contains("Diseases")) searchDTO.anyDiseases = null;

    BloodPressureEnum.values.forEach((element) {
      if (filter == "Blood Pressure: ${element.name}") {
        (searchDTO.bloodPressureCategories ?? []).remove(element);
      }
    });
    DiabetesEnum.values.forEach((element) {
      if (filter == "Diabetes: ${element.name}") {
        (searchDTO.diabetesCategories ?? []).remove(element);
      }
    });
    if (searchDTO.diabetesCategories?.isEmpty ?? true) {
      searchDTO.diabetesCategories = null;
    }
    if (searchDTO.bloodPressureCategories?.isEmpty ?? true) {
      searchDTO.bloodPressureCategories = null;
    }

    if (filter == "Last HAB1c From: ${searchDTO.lastHAB1cFrom}") {
      searchDTO.lastHAB1cFrom = null;
    }
    if (filter == "Last HAB1c To: ${searchDTO.lastHAB1cTo}") {
      searchDTO.lastHAB1cTo = null;
    }
    if (filter.contains("Penecilin")) searchDTO.penecilin = null;
    if (filter.contains("Illegal Drugs")) searchDTO.illegalDrugs = null;
    if (filter.contains("Pregnancy")) searchDTO.pregnancy = null;
    if (filter.contains("Chewing")) searchDTO.chewing = null;
    if (filter == "Smoking Status: ${searchDTO.smokingStatus?.name}") {
      searchDTO.smokingStatus = null;
    }
    if (filter == "Cooperation Score: ${searchDTO.cooperationScore?.name}") {
      searchDTO.cooperationScore = null;
    }
    if (filter == "Oral Hygiene Rating: ${searchDTO.oralHygieneRating?.name}") {
      searchDTO.oralHygieneRating = null;
    }

    onRemove(searchDTO, searchTreatmentsDTO, searchProstheticDTO);
  }
}
