import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labStepItemModel.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labRequestEntityl.dart';
import 'package:cariro_implant_academy/features/user/data/models/userModel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/enums/enums.dart';

class LabRequestModel extends LabRequestEntity {
  LabRequestModel({
    super.id,
    super.notesFromTech,
    super.date,
    super.deliveryDate,
    super.entryById,
    super.entryBy,
    super.source,
    super.customerId,
    super.customer,
    super.patientId,
    super.patient,
    super.status,
    super.status2,
    super.paid,
    super.free,
    super.cost,
    super.paidAmount,
    super.notes,
    super.requiredStep,
    super.fileId,
    super.designer,
    super.designerId,
    super.file,
    super.initStatus,
    super.teeth,
    super.assignedTo,
    super.assignedToId,
    super.labRequestStepItems,
    super.labFees,
  });

  factory LabRequestModel.fromEntity(LabRequestEntity entity) {
    return LabRequestModel(
        id: entity.id,
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
        status2: entity.status2,
        paid: entity.paid,
        free: entity.free,
        designer: entity.designer,
        designerId: entity.designerId,
        cost: entity.cost,
        paidAmount: entity.paidAmount,
        notes: entity.notes,
        requiredStep: entity.requiredStep,
        fileId: entity.fileId,
        file: entity.file,
        initStatus: entity.initStatus,
        teeth: entity.teeth,
        assignedToId: entity.assignedToId,
        labRequestStepItems: entity.labRequestStepItems,
        labFees: entity.labFees,
        assignedTo: entity.assignedTo);
  }

  LabRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notesFromTech = json['notesFromTech'];
    initStatus = json['initStatus'] != null ? EnumLabRequestInitStatus.values[json['initStatus']] : null;
    teeth = ((json['teeth'] ?? []) as List<dynamic>).map((e) => e as int).toList();
    date = DateTime.tryParse(json['date'] ?? "")?.toLocal();
    deliveryDate = DateTime.tryParse(json['deliveryDate'] ?? "")?.toLocal();
    entryById = json['entryById'];
    entryBy = json['entryBy'] == null ? null : BasicNameIdObjectModel.fromJson(json['entryBy'] ?? Map<String, dynamic>());
    designerId = json['designerId'];
    designer = json['designer'] == null ? null : BasicNameIdObjectModel.fromJson(json['designer'] ?? Map<String, dynamic>());
    assignedToId = json['assignedToId'];
    assignedTo = json['assignedTo'] == null ? null : BasicNameIdObjectModel.fromJson(json['assignedTo'] ?? Map<String, dynamic>());
    source = Website.values[json['source'] ?? 0];
    customerId = json['customerId'];
    customer = UserModel.fromJson(json['customer'] ?? Map<String, dynamic>());
    patientId = json['patientId'];
    patient = json['patient'] == null ? null : BasicNameIdObjectModel.fromJson(json['patient'] ?? Map<String, dynamic>());
    status = EnumLabRequestStatus.values[json['status'] ?? 0];
    status2 = EnumLabRequestStatus2.values[json['status2'] ?? 0];
    paid = json['paid'] ?? false;
    free = json['free'] ?? false;
    cost = json['cost'];
    paidAmount = json['paidAmount'];
    notes = json['notes'] ?? "";
    labFees = json['labFees'];
    requiredStep = json['requiredStep'] ?? "";
    // steps = ((json['steps'] ?? []) as List<dynamic>).map((e) => LabStepModel.fromJson(e as Map<String, dynamic>)).toList();
    labRequestStepItems =
        ((json['labRequestStepItems'] ?? []) as List<dynamic>).map((e) => LabStepItemModel.fromJson(e as Map<String, dynamic>)).toList();
    // if (steps != null && steps!.isNotEmpty && this.customerId == steps!.last.technicianId) assignedTo!.name = "Customer";
    fileId = json['fileId'];
    file = json['file'] == null ? null : BasicNameIdObjectModel.fromJson(json['file'] ?? Map<String, dynamic>());

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
    data['deliveryDate'] = this.deliveryDate == null
        ? null
        : DateFormat("yyyy-MM-dd").format(this.deliveryDate!); // CIA_DateConverters.fromDateOnlyToBackend(this.deliveryDate);
    data['entryById'] = this.entryById;
    // data['entryBy'] = this.entryBy != null ? this.entryBy!.toJson() : null;
    // if (this.steps != null && this.steps != []) {
    // this.assignedToId = steps![0].technicianId;
    //}
    data['assignedToId'] = this.assignedToId;
    //data['assignedTo'] = this.assignedTo != null ? this.assignedTo!.toJson() : null;
    data['source'] = (this.source ?? Website.CIA).index;
    data['customerId'] = this.customerId;
    //data['customer'] = this.customer != null ? this.customer!.toJson() : null;
    data['patientId'] = this.patientId;
    data['designerId'] = this.designerId;
    //data['patient'] = this.patient != null ? this.patient!.toJson() : null;
    data['status'] = (this.status ?? EnumLabRequestStatus.InQueue).index;
    data['status2'] = (this.status2 ?? EnumLabRequestStatus2.New).index;
    data['paid'] = this.paid ?? false;
    data['free'] = this.free ?? false;
    data['cost'] = this.cost ?? 0;
    data['paidAmount'] = this.paidAmount ?? 0;
    data['notes'] = this.notes;
    data['notesFromTech'] = this.notesFromTech;
    //  data['requiredStep'] = this.requiredStep;
    // data['steps'] = (this.steps ?? []).map((e) => LabStepModel.fromEntity(e).toJson()).toList();
    data['fileId'] = this.fileId;
    data['file'] = this.file != null ? BasicNameIdObjectModel.fromEntity(this.file!).toJson() : null;
    data['labRequestStepItems'] = (this.labRequestStepItems ?? []).map((e) => LabStepItemModel.fromEntity(e).toJson()).toList();

    return data;
  }
}
