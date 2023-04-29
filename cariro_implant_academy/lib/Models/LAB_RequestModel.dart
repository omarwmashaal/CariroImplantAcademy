import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/LAB_CustomerModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_StepTimelineWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../API/LAB_RequestsAPI.dart';
import 'API_Response.dart';
import 'ApplicationUserModel.dart';
import 'DTOs/DropDownDTO.dart';
import 'Enum.dart';
import 'Lab_StepModel.dart';

class LAB_RequestModel {
  int? id;
  String? date;
  String? deliveryDate;
  int? entryById;
  DropDownDTO? entryBy;
  int? assignedToId;
  DropDownDTO? assignedTo;
  EnumLabRequestSources? source;
  int? customerId;
  ApplicationUserModel? customer;
  int? patientId;
  DropDownDTO? patient;
  EnumLabRequestStatus? status;
  bool? paid;
  int? cost;
  int? paidAmount;
  String? notes;
  String? requiredStep;
  List<LAB_StepModel>? steps;

  int? fileId;
  DropDownDTO? file;
  bool? fullZireonCrown;
  bool? porcelainFusedToZircomium;
  bool? porcelainFusedToMetal;
  bool? porcelainFusedToMetalCADCAMCoCrAlloy;
  bool? glassCeramicCrown;
  bool? visiolignBondedToPEEK;
  bool? laminateVeneer;
  bool? milledPMMATemporaryCrown;
  bool? longTermTemporaryCrown;
  bool? screwRatainedCrown;
  bool? surveyCrownForRPD;
  bool? surveyCrownWithExtraCoronalAttahcment;
  bool? castPostcore;
  bool? zirconiumPostAndCore;
  bool? customCarbonFiberPost;
  bool? zirconiumInlayOrOnlay;
  bool? glassCeramicInlayOrOnlay;
  bool? caDCAMAbutment;
  bool? specialTray;
  bool? occlusionBlock;
  bool? diagnosticOrTrailSetup;
  bool? flexibleRPD;
  bool? metallicRPD;
  bool? nightGuardVacuumTemplate;
  bool? radiographicDuplicatesForCBCT;
  bool? clearSurgicalTemplates;
  bool? diagnosticSurveying;

  LAB_RequestModel(
      {this.id,
      this.date,
      this.deliveryDate,
      this.entryById,
      this.entryBy,
      this.source,
      this.customerId,
      this.customer,
      this.patientId,
      this.patient,
      this.status,
      this.paid,
      this.cost,
      this.paidAmount,
      this.notes,
      this.requiredStep,
      this.steps,
      this.fileId,
      this.file,
      this.fullZireonCrown = false,
      this.porcelainFusedToZircomium = false,
      this.porcelainFusedToMetal = false,
      this.porcelainFusedToMetalCADCAMCoCrAlloy = false,
      this.glassCeramicCrown = false,
      this.visiolignBondedToPEEK = false,
      this.laminateVeneer = false,
      this.milledPMMATemporaryCrown = false,
      this.longTermTemporaryCrown = false,
      this.screwRatainedCrown = false,
      this.surveyCrownForRPD = false,
      this.surveyCrownWithExtraCoronalAttahcment = false,
      this.castPostcore = false,
      this.zirconiumPostAndCore = false,
      this.customCarbonFiberPost = false,
      this.zirconiumInlayOrOnlay = false,
      this.glassCeramicInlayOrOnlay = false,
      this.caDCAMAbutment = false,
      this.specialTray = false,
      this.occlusionBlock = false,
      this.diagnosticOrTrailSetup = false,
      this.flexibleRPD = false,
      this.metallicRPD = false,
      this.nightGuardVacuumTemplate = false,
      this.radiographicDuplicatesForCBCT = false,
      this.clearSurgicalTemplates = false,
      this.diagnosticSurveying = false}) {
    entryBy = DropDownDTO();
    customer = ApplicationUserModel();
    patient = DropDownDTO();
    file = DropDownDTO();
  }

  LAB_RequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = CIA_DateConverters.fromBackendToDateOnly(json['date']);
    deliveryDate = CIA_DateConverters.fromBackendToDateOnly(json['deliveryDate']);
    entryById = json['entryById'];
    entryBy = DropDownDTO.fromJson(json['entryBy'] ?? Map<String, dynamic>());
    //assignedToId = json['assignedToId'];
    //assignedTo = DropDownDTO.fromJson(json['assignedTo'] ?? Map<String, dynamic>());
    source = EnumLabRequestSources.values[json['source'] ?? 0];
    customerId = json['customerId'];
    customer = ApplicationUserModel.fromJson(json['customer'] ?? Map<String, dynamic>());
    patientId = json['patientId'];
    patient = DropDownDTO.fromJson(json['patient'] ?? Map<String, dynamic>());
    status = EnumLabRequestStatus.values[json['status'] ?? 0];
    paid = json['paid'] ?? false;
    cost = json['cost'];
    paidAmount = json['paidAmount'];
    notes = json['notes'] ?? "";
    requiredStep = json['requiredStep'] ?? "";
    steps = ((json['steps'] ?? []) as List<dynamic>).map((e) => LAB_StepModel.fromJson(e as Map<String, dynamic>)).toList();
    fileId = json['fileId'];
    file = DropDownDTO.fromJson(json['file'] ?? Map<String, dynamic>());
    fullZireonCrown = json['full_zireon_crown'] ?? false;
    porcelainFusedToZircomium = json['porcelain_fused_to_zircomium'] ?? false;
    porcelainFusedToMetal = json['porcelain_fused_to_metal'] ?? false;
    porcelainFusedToMetalCADCAMCoCrAlloy = json['porcelain_fused_to_metal_CAD_CAM_Co_Cr_alloy'] ?? false;
    glassCeramicCrown = json['glass_ceramic_crown'] ?? false;
    visiolignBondedToPEEK = json['visiolign_bonded_to_PEEK'] ?? false;
    laminateVeneer = json['laminate_veneer'] ?? false;
    milledPMMATemporaryCrown = json['milled_PMMA_temporary_crown'] ?? false;
    longTermTemporaryCrown = json['long_term_temporary_crown'] ?? false;
    screwRatainedCrown = json['screw_ratained_crown'] ?? false;
    surveyCrownForRPD = json['survey_crown_for_RPD'] ?? false;
    surveyCrownWithExtraCoronalAttahcment = json['survey_crown_with_extra_coronal_attahcment'] ?? false;
    castPostcore = json['cast_postcore'] ?? false;
    zirconiumPostAndCore = json['zirconium_post_and_core'] ?? false;
    customCarbonFiberPost = json['custom_carbon_fiber_post'] ?? false;
    zirconiumInlayOrOnlay = json['zirconium_inlay_or_onlay'] ?? false;
    glassCeramicInlayOrOnlay = json['glass_ceramic_inlay_or_onlay'] ?? false;
    caDCAMAbutment = json['caD_CAM_abutment'] ?? false;
    specialTray = json['special_tray'] ?? false;
    occlusionBlock = json['occlusion_block'] ?? false;
    diagnosticOrTrailSetup = json['diagnostic_or_trail_setup'] ?? false;
    flexibleRPD = json['flexible_RPD'] ?? false;
    metallicRPD = json['metallic_RPD'] ?? false;
    nightGuardVacuumTemplate = json['night_guard_vacuum_template'] ?? false;
    radiographicDuplicatesForCBCT = json['radiographic_duplicates_for_CBCT'] ?? false;
    clearSurgicalTemplates = json['clear_surgical_templates'] ?? false;
    diagnosticSurveying = json['diagnostic_surveying'] ?? false;

    if(steps!=null)
      {
        var assigned = steps!.firstWhereOrNull((element) => element.status==LabStepStatus.InProgress);
        if(assigned==null)
          {
            assigned = steps!.firstWhereOrNull((element) => element.status==LabStepStatus.NotYet);
          }
        if(assigned!=null)
          {
            assignedTo = assigned!.technician??DropDownDTO();
            assignedToId = assigned!.technicianId;
          }
      }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? 0;
    //data['date'] = CIA_DateConverters.fromDateTimeToBackend(this.date);
    data['deliveryDate'] = CIA_DateConverters.fromDateOnlyToBackend(this.deliveryDate);
    // data['entryById'] = this.entryById;
    // data['entryBy'] = this.entryBy != null ? this.entryBy!.toJson() : null;
    data['assignedToId'] = this.assignedToId;
    data['assignedTo'] = this.assignedTo != null ? this.assignedTo!.toJson() : null;
    data['source'] = (this.source ?? EnumLabRequestSources.CIA).index;
    data['customerId'] = this.customerId;
    //data['customer'] = this.customer != null ? this.customer!.toJson() : null;
    data['patientId'] = this.patientId;
    //data['patient'] = this.patient != null ? this.patient!.toJson() : null;
    data['status'] = (this.status ?? LabStepStatus.NotYet).index;
    data['paid'] = this.paid ?? false;
    data['cost'] = this.cost ?? 0;
    data['paidAmount'] = this.paidAmount ?? 0;
    data['notes'] = this.notes;
    data['requiredStep'] = this.requiredStep;
    data['steps'] = this.steps;
    data['fileId'] = this.fileId;
    data['file'] = this.file != null ? this.file!.toJson() : null;
    data['full_zireon_crown'] = this.fullZireonCrown;
    data['porcelain_fused_to_zircomium'] = this.porcelainFusedToZircomium;
    data['porcelain_fused_to_metal'] = this.porcelainFusedToMetal;
    data['porcelain_fused_to_metal_CAD_CAM_Co_Cr_alloy'] = this.porcelainFusedToMetalCADCAMCoCrAlloy;
    data['glass_ceramic_crown'] = this.glassCeramicCrown;
    data['visiolign_bonded_to_PEEK'] = this.visiolignBondedToPEEK;
    data['laminate_veneer'] = this.laminateVeneer;
    data['milled_PMMA_temporary_crown'] = this.milledPMMATemporaryCrown;
    data['long_term_temporary_crown'] = this.longTermTemporaryCrown;
    data['screw_ratained_crown'] = this.screwRatainedCrown;
    data['survey_crown_for_RPD'] = this.surveyCrownForRPD;
    data['survey_crown_with_extra_coronal_attahcment'] = this.surveyCrownWithExtraCoronalAttahcment;
    data['cast_postcore'] = this.castPostcore;
    data['zirconium_post_and_core'] = this.zirconiumPostAndCore;
    data['custom_carbon_fiber_post'] = this.customCarbonFiberPost;
    data['zirconium_inlay_or_onlay'] = this.zirconiumInlayOrOnlay;
    data['glass_ceramic_inlay_or_onlay'] = this.glassCeramicInlayOrOnlay;
    data['caD_CAM_abutment'] = this.caDCAMAbutment;
    data['special_tray'] = this.specialTray;
    data['occlusion_block'] = this.occlusionBlock;
    data['diagnostic_or_trail_setup'] = this.diagnosticOrTrailSetup;
    data['flexible_RPD'] = this.flexibleRPD;
    data['metallic_RPD'] = this.metallicRPD;
    data['night_guard_vacuum_template'] = this.nightGuardVacuumTemplate;
    data['radiographic_duplicates_for_CBCT'] = this.radiographicDuplicatesForCBCT;
    data['clear_surgical_templates'] = this.clearSurgicalTemplates;
    data['diagnostic_surveying'] = this.diagnosticSurveying;
    return data;
  }
}

class LabRequestDataSource extends DataGridSource {
  List<LAB_RequestModel> models = [];
  var columns = ["ID", "Date", "Source", "Customer Name", "Customer Phone", "Patient Name", "Paid", "Status"];

  /// Creates the labRequest data source class with required details.
  LabRequestDataSource() {
    init();
  }

  init() {
    _labRequestData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Date', value: e.date ?? ""),
              DataGridCell<String>(columnName: 'Source', value: e.source!.name),
              DataGridCell<String>(columnName: 'Customer Name', value: e.customer!.name ?? ""),
              DataGridCell<String>(columnName: 'Customer Phone', value: e.customer!.phoneNumber ?? ""),
              DataGridCell<String>(columnName: 'Patient Name', value: e.patient!.name ?? ""),
              DataGridCell<String>(columnName: 'Paid', value: (e.paid??false)?"Paid":"Not Paid"),
              DataGridCell<String>(columnName: 'Status', value: e.status.toString().split(".").last),
            ]))
        .toList();
  }

  List<DataGridRow> _labRequestData = [];

  @override
  List<DataGridRow> get rows => _labRequestData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  loadData({
    String? from,
    String? to,
    String? search,
    EnumLabRequestStatus? status,
    EnumLabRequestSources? source,
    bool? paid,
  }) async {
    API_Response res = await LAB_RequestsAPI.GetAllRequests(
      from: from,
      to: to,
      status: status,
      source: source,
      paid: paid,
      search: search,
    );
    if (res.statusCode == 200) {
      models = res.result as List<LAB_RequestModel>;
    }
    init();
    notifyListeners();
    return true;
  }
}
