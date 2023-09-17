import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/paymentLogEntity.dart';

class PaymentLogModel extends PaymentLogEntity {
  PaymentLogModel({
    super.id,
    super.patientId,
    super.patient,
    super.operatorId,
    super.operator,
    super.date,
    super.receiptId,
    super.receipt,
    super.paidAmount,
  });

  factory PaymentLogModel.fromEntity(PaymentLogEntity entity) {
    return PaymentLogModel(
      id: entity.id,
      patientId: entity.patientId,
      patient: entity.patient,
      operatorId: entity.operatorId,
      operator: entity.operator,
      date: entity.date,
      receiptId: entity.receiptId,
      receipt: entity.receipt,
      paidAmount: entity.paidAmount,
    );
  }

  PaymentLogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    patient = BasicNameIdObjectModel.fromJson(json['patient'] ?? Map<String, dynamic>());
    operatorId = json['operatorId'];
    operator = BasicNameIdObjectModel.fromJson(json['operator'] ?? Map<String, dynamic>());
    date = DateTime.tryParse(json['date']);
    receiptId = json['receiptId'];
    //receipt = json['receipt'];
    paidAmount = json['paidAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    data['patient'] = this.patient;
    data['operatorId'] = this.operatorId;
    data['operator'] = this.operator;
    data['date'] = this.date == null ? null : this.date!.toIso8601String();
    data['receiptId'] = this.receiptId;
    data['receipt'] = this.receipt;
    data['paidAmount'] = this.paidAmount;
    return data;
  }
}
