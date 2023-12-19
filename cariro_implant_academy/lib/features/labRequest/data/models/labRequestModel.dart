import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labRequestItemModel.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labStepModel.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/user/data/models/userModel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/enums/enums.dart';

class LabRequestModel extends LabRequestEntity {
  LabRequestModel({
    super.id,
    super.date,
    super.deliveryDate,
    super.entryById,
    super.entryBy,
    super.source,
    super.customerId,
    super.customer,
    super.patientId,
    super.waxUp,
    super.zirconUnit,
    super.pfm,
    super.compositeInlay,
    super.emaxVeneer,
    super.milledPMMA,
    super.printedPMMA,
    super.tiAbutment,
    super.tiBar,
    super.threeDPrinting,
    super.others,
    super.patient,
    super.status,
    super.paid,
    super.cost,
    super.paidAmount,
    super.notes,
    super.requiredStep,
    super.steps,
    super.fileId,
    super.file,
    super.initStatus,
    super.teeth,
  });

  factory LabRequestModel.fromEntity(LabRequestEntity entity) {
    return LabRequestModel(
      id: entity.id,
      date: entity.date,
      deliveryDate: entity.deliveryDate,
      entryById: entity.entryById,
      entryBy: entity.entryBy,
      source: entity.source,
      customerId: entity.customerId,
      customer: entity.customer,
      patientId: entity.patientId,
      patient: entity.patient,
      status: entity.status,
      paid: entity.paid,
      waxUp: entity.waxUp,
      zirconUnit: entity.zirconUnit,
      pfm: entity.pfm,
      compositeInlay: entity.compositeInlay,
      emaxVeneer: entity.emaxVeneer,
      milledPMMA: entity.milledPMMA,
      printedPMMA: entity.printedPMMA,
      tiAbutment: entity.tiAbutment,
      tiBar: entity.tiBar,
      threeDPrinting: entity.threeDPrinting,
      others: entity.others,
      cost: entity.cost,
      paidAmount: entity.paidAmount,
      notes: entity.notes,
      requiredStep: entity.requiredStep,
      steps: entity.steps,
      fileId: entity.fileId,
      file: entity.file,
      initStatus: entity.initStatus,
      teeth: entity.teeth,
    );
  }

  LabRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    initStatus = json['initStatus'] != null ? EnumLabRequestInitStatus.values[json['initStatus']] : null;
    teeth = ((json['teeth'] ?? []) as List<dynamic>).map((e) => e as int).toList();
    date = DateTime.tryParse(json['date'] ?? "")?.toLocal();
    deliveryDate = DateTime.tryParse(json['deliveryDate'] ?? "")?.toLocal();
    entryById = json['entryById'];
    entryBy = json['entryBy'] == null ? null : BasicNameIdObjectModel.fromJson(json['entryBy'] ?? Map<String, dynamic>());
    assignedToId = json['assignedToId'];
    assignedTo = json['assignedTo'] == null ? null : BasicNameIdObjectModel.fromJson(json['assignedTo'] ?? Map<String, dynamic>());
    source = EnumLabRequestSources.values[json['source'] ?? 0];
    customerId = json['customerId'];
    customer = UserModel.fromJson(json['customer'] ?? Map<String, dynamic>());
    patientId = json['patientId'];
    patient = json['patient'] == null ? null : BasicNameIdObjectModel.fromJson(json['patient'] ?? Map<String, dynamic>());
    status = EnumLabRequestStatus.values[json['status'] ?? 0];
    paid = json['paid'] ?? false;
    cost = json['cost'];
    paidAmount = json['paidAmount'];
    notes = json['notes'] ?? "";
    requiredStep = json['requiredStep'] ?? "";
    steps = ((json['steps'] ?? []) as List<dynamic>).map((e) => LabStepModel.fromJson(e as Map<String, dynamic>)).toList();
    if (steps != null && steps!.isNotEmpty && this.customerId == steps!.last.technicianId) assignedTo!.name = "Customer";
    fileId = json['fileId'];
    file = json['file'] == null ? null : BasicNameIdObjectModel.fromJson(json['file'] ?? Map<String, dynamic>());
    waxUp = json['waxUp'] == null ? null : LabRequestItemModel.fromJson(json['waxUp']);
    zirconUnit = json['zirconUnit'] == null ? null : LabRequestItemModel.fromJson(json['zirconUnit']);
    pfm = json['pfm'] == null ? null : LabRequestItemModel.fromJson(json['pfm']);
    compositeInlay = json['compositeInlay'] == null ? null : LabRequestItemModel.fromJson(json['compositeInlay']);
    emaxVeneer = json['emaxVeneer'] == null ? null : LabRequestItemModel.fromJson(json['emaxVeneer']);
    milledPMMA = json['milledPMMA'] == null ? null : LabRequestItemModel.fromJson(json['milledPMMA']);
    printedPMMA = json['printedPMMA'] == null ? null : LabRequestItemModel.fromJson(json['printedPMMA']);
    tiAbutment = json['tiAbutment'] == null ? null : LabRequestItemModel.fromJson(json['tiAbutment']);
    tiBar = json['tiBar'] == null ? null : LabRequestItemModel.fromJson(json['tiBar']);
    threeDPrinting = json['threeDPrinting'] == null ? null : LabRequestItemModel.fromJson(json['threeDPrinting']);
    others = ((json['others'] ?? []) as List<dynamic>).map((e) => LabRequestItemModel.fromJson(e)).toList();

    if (steps != null) {
      var assigned = steps!.firstWhereOrNull((element) => element.status == LabStepStatus.InProgress);
      if (assigned == null) {
        assigned = steps!.firstWhereOrNull((element) => element.status == LabStepStatus.NotYet);
      }
      if (assigned != null) {
        assignedTo = json['assignedTo'] == null ? null : assignedTo ?? assigned!.technician ?? BasicNameIdObjectModel();
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
    data['deliveryDate'] =
        this.deliveryDate == null ? null : DateFormat("yyyy-MM-dd").format(this.deliveryDate!); // CIA_DateConverters.fromDateOnlyToBackend(this.deliveryDate);
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
    data['waxUp'] = this.waxUp == null ? null : LabRequestItemModel.fromEntity(this.waxUp!).toJson();
    data['zirconUnit'] = this.zirconUnit == null ? null : LabRequestItemModel.fromEntity(this.zirconUnit!).toJson();
    data['pfm'] = this.pfm == null ? null : LabRequestItemModel.fromEntity(this.pfm!).toJson();
    data['compositeInlay'] = this.compositeInlay == null ? null : LabRequestItemModel.fromEntity(this.compositeInlay!).toJson();
    data['emaxVeneer'] = this.emaxVeneer == null ? null : LabRequestItemModel.fromEntity(this.emaxVeneer!).toJson();
    data['milledPMMA'] = this.milledPMMA == null ? null : LabRequestItemModel.fromEntity(this.milledPMMA!).toJson();
    data['printedPMMA'] = this.printedPMMA == null ? null : LabRequestItemModel.fromEntity(this.printedPMMA!).toJson();
    data['tiAbutment'] = this.tiAbutment == null ? null : LabRequestItemModel.fromEntity(this.tiAbutment!).toJson();
    data['tiBar'] = this.tiBar == null ? null : LabRequestItemModel.fromEntity(this.tiBar!).toJson();
    data['threeDPrinting'] = this.threeDPrinting == null ? null : LabRequestItemModel.fromEntity(this.threeDPrinting!).toJson();
    data['others'] = this.others?.map((e) => LabRequestItemModel.fromEntity(e).toJson()).toList();
    data['notes'] = this.notes;
    data['requiredStep'] = this.requiredStep;
    data['steps'] = (this.steps ?? []).map((e) => LabStepModel.fromEntity(e).toJson()).toList();
    data['fileId'] = this.fileId;
    data['file'] = this.file != null ? BasicNameIdObjectModel.fromEntity(this.file!).toJson() : null;

    return data;
  }
}
