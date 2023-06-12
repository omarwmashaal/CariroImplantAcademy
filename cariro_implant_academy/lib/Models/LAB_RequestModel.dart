import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/LAB_CustomerModel.dart';
import 'package:cariro_implant_academy/Widgets/CIA_StepTimelineWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../API/LAB_RequestsAPI.dart';
import '../Widgets/SnackBar.dart';
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
  List<int>? teeth;
  EnumLabRequestInitStatus? initStatus;

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

  List<String> getMedicalInfoList() {
    List<String> r = [];
    if (fullZireonCrown ?? false) r.add("Full Zireon Crown");
    if (porcelainFusedToZircomium ?? false) r.add("Porcelain Fused To Zircomium");
    if (porcelainFusedToMetal ?? false) r.add("Porcelain Fused ToMetal");
    if (porcelainFusedToMetalCADCAMCoCrAlloy ?? false) r.add("Porcelain Fused To Metal CAD-CAM-Co-Cr Alloy");
    if (glassCeramicCrown ?? false) r.add("Glass Ceramic Crown");
    if (visiolignBondedToPEEK ?? false) r.add("Visiolign Bonded To PEEK");
    if (laminateVeneer ?? false) r.add("Laminate Veneer");
    if (milledPMMATemporaryCrown ?? false) r.add("Milled PMMA TemporaryCrown");
    if (longTermTemporaryCrown ?? false) r.add("Long Term Temporary Crown");
    if (screwRatainedCrown ?? false) r.add("Screw Ratained Crown");
    if (surveyCrownForRPD ?? false) r.add("Survey Crown For RPD");
    if (surveyCrownWithExtraCoronalAttahcment ?? false) r.add("Survey Crown With Extra Coronal Attahcment");
    if (castPostcore ?? false) r.add("Cast Postcore");
    if (zirconiumPostAndCore ?? false) r.add("Zirconium Post And Core");
    if (customCarbonFiberPost ?? false) r.add("Custom Carbon Fiber Post");
    if (zirconiumInlayOrOnlay ?? false) r.add("Zirconium Inlay Or Onlay");
    if (glassCeramicInlayOrOnlay ?? false) r.add("Glass Ceramic Inlay Or Onlay");
    if (caDCAMAbutment ?? false) r.add("CaDCAMAbutment");
    if (specialTray ?? false) r.add("Special Tray");
    if (occlusionBlock ?? false) r.add("Occlusion Block");
    if (diagnosticOrTrailSetup ?? false) r.add("Diagnostic Or Trail Setup");
    if (flexibleRPD ?? false) r.add("Flexible RPD");
    if (metallicRPD ?? false) r.add("Metallic RPD");
    if (nightGuardVacuumTemplate ?? false) r.add("Night Guard Vacuum Template");
    if (radiographicDuplicatesForCBCT ?? false) r.add("Radiographic Duplicates For CBCT");
    if (clearSurgicalTemplates ?? false) r.add("Clear Surgical Templates");
    if (diagnosticSurveying ?? false) r.add("Diagnostic Surveying");
    return r;
  }

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
      this.initStatus = EnumLabRequestInitStatus.Scan,
      this.nightGuardVacuumTemplate = false,
      this.radiographicDuplicatesForCBCT = false,
      this.clearSurgicalTemplates = false,
      this.teeth,
      this.diagnosticSurveying = false}) {
    entryBy = DropDownDTO();
    customer = ApplicationUserModel();
    patient = DropDownDTO();
    file = DropDownDTO();
    teeth = [];
  }

  LAB_RequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    initStatus = json['initStatus'] != null ? EnumLabRequestInitStatus.values[json['initStatus']] : null;
    teeth = ((json['teeth'] ?? []) as List<dynamic>).map((e) => e as int).toList();
    date = CIA_DateConverters.fromBackendToDateOnly(json['date']);
    deliveryDate = CIA_DateConverters.fromBackendToDateOnly(json['deliveryDate']);
    entryById = json['entryById'];
    entryBy = DropDownDTO.fromJson(json['entryBy'] ?? Map<String, dynamic>());
    assignedToId = json['assignedToId'];
    assignedTo = DropDownDTO.fromJson(json['assignedTo'] ?? Map<String, dynamic>());
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

    if (steps != null) {
      var assigned = steps!.firstWhereOrNull((element) => element.status == LabStepStatus.InProgress);
      if (assigned == null) {
        assigned = steps!.firstWhereOrNull((element) => element.status == LabStepStatus.NotYet);
      }
      if (assigned != null) {
        assignedTo = assignedTo ?? assigned!.technician ?? DropDownDTO();
        assignedToId = assignedToId ?? assigned!.technicianId;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? 0;
    data['initStatus'] = this.initStatus != null ? this.initStatus!.index : null;
    data['teeth'] = this.teeth ?? [];
    //data['date'] = CIA_DateConverters.fromDateTimeToBackend(this.date);
    data['deliveryDate'] = CIA_DateConverters.fromDateOnlyToBackend(this.deliveryDate);
    // data['entryById'] = this.entryById;
    // data['entryBy'] = this.entryBy != null ? this.entryBy!.toJson() : null;
    if (this.steps != null && this.steps != []) {
      this.assignedToId = steps![0].technicianId;
    }
    data['assignedToId'] = this.assignedToId;
    //data['assignedTo'] = this.assignedTo != null ? this.assignedTo!.toJson() : null;
    data['source'] = (this.source ?? EnumLabRequestSources.CIA).index;
    data['customerId'] = this.customerId;
    //data['customer'] = this.customer != null ? this.customer!.toJson() : null;
    data['patientId'] = this.patientId;
    //data['patient'] = this.patient != null ? this.patient!.toJson() : null;
    data['status'] = (this.status ?? EnumLabRequestStatus.InQueue).index;
    data['paid'] = this.paid ?? false;
    data['cost'] = this.cost ?? 0;
    data['paidAmount'] = this.paidAmount ?? 0;
    data['notes'] = this.notes;
    data['requiredStep'] = this.requiredStep;
    data['steps'] = (this.steps ?? []).map((e) => e.toJson()).toList();
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

  String? from;
  String? to;
  String? search;
  EnumLabRequestStatus? status;
  EnumLabRequestSources? source;
  bool? paid;
  bool? myRequests;

  /// Creates the labRequest data source class with required details.
  LabRequestDataSource() {
    init();
  }

  init() {
    columns = [
     // "ID",
      "Date",
      "Source",
      "Customer Name",
      "Customer Phone",
      "Patient Name",
      "Paid",
      "Assigned",
      "Status",
      "Step",
    ];
    _labRequestData = models
        .map<DataGridRow>((e) => DataGridRow(cells: [
              //DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Date', value: e.date ?? ""),
              DataGridCell<String>(columnName: 'Source', value: e.source!.name),
              DataGridCell<String>(columnName: 'Customer Name', value: e.customer!.name ?? ""),
              DataGridCell<String>(columnName: 'Customer Phone', value: e.customer!.phoneNumber ?? ""),
              DataGridCell<String>(columnName: 'Patient Name', value: e.patient!.name ?? ""),
              DataGridCell<String>(columnName: 'Paid', value: (e.paid ?? false) ? "Paid" : "Not Paid"),
              DataGridCell<String>(columnName: 'Assigned', value: e.assignedToId == siteController.getUser().idInt ? "You" : e.assignedTo!.name),
              DataGridCell<String>(columnName: 'Status', value: e.status.toString().split(".").last),
              DataGridCell<String>(columnName: 'Step', value: (e.steps ?? []).last.step!.name),
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
      if (e.value is Widget) return e.value;
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
    bool? myRequests
  }) async {
    this.from = from;
    this.to = to;
    this.search = search;
    this.status = status;
    this.source = source;
    this.paid = paid;
    this.myRequests = myRequests;
    API_Response res = await LAB_RequestsAPI.GetAllRequests(
      from: from,
      to: to,
      status: status,
      source: source,
      paid: paid,
      search: search,
      myRequests: myRequests??false,
    );
    if (res.statusCode == 200) {
      models = res.result as List<LAB_RequestModel>;
    }
    init();
    notifyListeners();
    return res;
  }

  loadPatientRequests(int id) async {
    API_Response res = await LAB_RequestsAPI.GetPatientRequests(
      id
    );
    if (res.statusCode == 200) {
      models = res.result as List<LAB_RequestModel>;
    }
    init();
    notifyListeners();
    return res;
  }
}
