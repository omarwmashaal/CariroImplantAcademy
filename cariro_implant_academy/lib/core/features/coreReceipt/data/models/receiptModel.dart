import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/data/models/toothReceiptModel.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';

class ReceiptModel extends ReceiptEntity {
  ReceiptModel({
    super.id,
    super.date,
    super.patientId,
    super.patient,
    super.operatorId,
    super.candidate,
    super.candidateId,
    super.operator,
    super.toothReceiptData,
    super.total,
    super.paid,
    super.unpaid,
    super.isPaid,
  });

  factory ReceiptModel.fromEntity(ReceiptEntity entity) {
    return ReceiptModel(
      date: entity.date,
      id: entity.id,
      operator: entity.operator,
      operatorId: entity.operatorId,
      paid: entity.paid,
      patient: entity.patient,
      candidate: entity.candidate,
      candidateId: entity.candidateId,
      patientId: entity.patientId,
      toothReceiptData: entity.toothReceiptData,
      total: entity.total,
      unpaid: entity.unpaid,
      isPaid: entity.isPaid,
    );
  }

  ReceiptModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = DateTime.tryParse(json['date'] ?? "")?.toLocal();
    patientId = json['patientId'];
    candidateId = json['candidateId'];
    patient = BasicNameIdObjectModel.fromJson(json['patient'] ?? Map<String, dynamic>());
    candidate = BasicNameIdObjectModel.fromJson(json['candidate'] ?? Map<String, dynamic>());
    operatorId = json['operatorId'];
    operator = BasicNameIdObjectModel.fromJson(json['operator'] ?? Map<String, dynamic>());
    toothReceiptData = ((json['toothReceiptData'] ?? []) as List<dynamic>).map((e) => ToothReceiptModel.fromJson(e as Map<String, dynamic>)).toList();
    total = json['total'];
    paid = json['paid'];
    unpaid = json['unpaid'];
    isPaid = json['isPaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date == null ? null : this.date!.toUtc().toIso8601String();
    data['patientId'] = this.patientId;
    data['candidateId'] = this.candidateId;
    data['toothReceiptData'] = this.toothReceiptData?.map((e) => ToothReceiptModel.fromEntity(e).toJson()).toList();
    //data['patient'] = this.patient == null ? null : BasicNameIdObjectModel.fromEntity(this.patient!).t();
    data['operatorId'] = this.operatorId;
    //   data['operator'] = this.operator == null ? null : this.operator!.toJson();
    data['total'] = this.total;
    data['paid'] = this.paid;
    data['unpaid'] = this.unpaid;
    data['isPaid'] = this.isPaid;
    return data;
  }
}
