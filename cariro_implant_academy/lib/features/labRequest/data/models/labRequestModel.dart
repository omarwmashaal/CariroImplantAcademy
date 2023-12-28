import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labStepModel.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/user/data/models/userModel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/enums/enums.dart';
import 'OmarModel.dart';

class LabRequestModel extends LabRequestEntity {
  LabRequestModel({
    super.id,
    super.notesFromTech,
    super.date,
    super.deliveryDate,
    super.labFees,
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
    super.assignedTo,
    super.assignedToId,
  });

  factory LabRequestModel.fromEntity(LabRequestEntity entity) {
    return LabRequestModel(
        id: entity.id,
        labFees: entity.labFees,
        date: entity.date,
        notesFromTech: entity.notesFromTech,
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
        assignedToId: entity.assignedToId,
        assignedTo: entity.assignedTo);
  }

  LabRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    labFees = json['labFees'] ?? 0;
    notesFromTech = json['notesFromTech'];
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
    waxUp = json['waxUp'] == null ? null : OmarModelsss.fromJson(json['waxUp']);
    zirconUnit = json['zirconUnit'] == null ? null : OmarModelsss.fromJson(json['zirconUnit']);
    pfm = json['pfm'] == null ? null : OmarModelsss.fromJson(json['pfm']);
    compositeInlay = json['compositeInlay'] == null ? null : OmarModelsss.fromJson(json['compositeInlay']);
    emaxVeneer = json['emaxVeneer'] == null ? null : OmarModelsss.fromJson(json['emaxVeneer']);
    milledPMMA = json['milledPMMA'] == null ? null : OmarModelsss.fromJson(json['milledPMMA']);
    printedPMMA = json['printedPMMA'] == null ? null : OmarModelsss.fromJson(json['printedPMMA']);
    tiAbutment = json['tiAbutment'] == null ? null : OmarModelsss.fromJson(json['tiAbutment']);
    tiBar = json['tiBar'] == null ? null : OmarModelsss.fromJson(json['tiBar']);
    threeDPrinting = json['threeDPrinting'] == null ? null : OmarModelsss.fromJson(json['threeDPrinting']);
    others = ((json['others'] ?? []) as List<dynamic>).map((e) => OmarModelsss.fromJson(e)).toList();

    /*if (steps != null) {
      var assigned = steps!.firstWhereOrNull((element) => element.status == LabStepStatus.InProgress);
      if (assigned == null) {
        assigned = steps!.firstWhereOrNull((element) => element.status == LabStepStatus.NotYet);
      }
      if (assigned != null) {
        assignedTo = json['assignedTo'] == null ? null : assignedTo ?? assigned!.technician ?? BasicNameIdObjectModel();
        assignedToId = assignedToId ?? assigned!.technicianId;
      }
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? 0;
    data['labFees'] = this.labFees ?? 0;
    data['initStatus'] = this.initStatus != null ? this.initStatus!.index : null;
    data['teeth'] = this.teeth ?? [];
    data['date'] = this.date?.toUtc().toIso8601String();
    data['deliveryDate'] =
        this.deliveryDate == null ? null : DateFormat("yyyy-MM-dd").format(this.deliveryDate!); // CIA_DateConverters.fromDateOnlyToBackend(this.deliveryDate);
    // data['entryById'] = this.entryById;
    // data['entryBy'] = this.entryBy != null ? this.entryBy!.toJson() : null;
    // if (this.steps != null && this.steps != []) {
    // this.assignedToId = steps![0].technicianId;
    //}
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
    data['waxUp'] = this.waxUp?.isNull() ?? true ? null : OmarModelsss.fromEntity(this.waxUp!).toJson();
    data['zirconUnit'] = this.zirconUnit?.isNull() ?? true ? null : OmarModelsss.fromEntity(this.zirconUnit!).toJson();
    data['pfm'] = this.pfm?.isNull() ?? true ? null : OmarModelsss.fromEntity(this.pfm!).toJson();
    data['compositeInlay'] = this.compositeInlay?.isNull() ?? true ? null : OmarModelsss.fromEntity(this.compositeInlay!).toJson();
    data['emaxVeneer'] = this.emaxVeneer?.isNull() ?? true ? null : OmarModelsss.fromEntity(this.emaxVeneer!).toJson();
    data['milledPMMA'] = this.milledPMMA?.isNull() ?? true ? null : OmarModelsss.fromEntity(this.milledPMMA!).toJson();
    data['printedPMMA'] = this.printedPMMA?.isNull() ?? true ? null : OmarModelsss.fromEntity(this.printedPMMA!).toJson();
    data['tiAbutment'] = this.tiAbutment?.isNull() ?? true ? null : OmarModelsss.fromEntity(this.tiAbutment!).toJson();
    data['tiBar'] = this.tiBar?.isNull() ?? true ? null : OmarModelsss.fromEntity(this.tiBar!).toJson();
    data['threeDPrinting'] = this.threeDPrinting?.isNull() ?? true ? null : OmarModelsss.fromEntity(this.threeDPrinting!).toJson();
    data['others'] = this.others?.map((e) => OmarModelsss.fromEntity(e).toJson()).toList();
    data['notes'] = this.notes;
    data['notesFromTech'] = this.notesFromTech;
    //  data['requiredStep'] = this.requiredStep;
    // data['steps'] = (this.steps ?? []).map((e) => LabStepModel.fromEntity(e).toJson()).toList();
    data['fileId'] = this.fileId;
    data['file'] = this.file != null ? BasicNameIdObjectModel.fromEntity(this.file!).toJson() : null;

    return data;
  }
}
