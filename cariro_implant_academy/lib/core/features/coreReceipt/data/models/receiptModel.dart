import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/data/models/toothReceiptModel.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';

class ReceiptModel extends ReceiptEntity {
  ReceiptModel({
    super.date,
    super.id,
    super.operator,
    super.operatorId,
    super.paid,
    super.patient,
    super.patientId,
    super.toothReceiptData,
    super.total,
    super.unpaid,
    super.prices,
    super.isPaid,
  });

  factory ReceiptModel.fromEntity(ReceiptEntity entity)
  {
    return ReceiptModel(
      date:entity.date,
      id:entity.id,
      operator:entity.operator,
      operatorId:entity.operatorId,
      paid:entity.paid,
      patient:entity.patient,
      patientId:entity.patientId,
      toothReceiptData:entity.toothReceiptData,
      total:entity.total,
      unpaid:entity.unpaid,
      prices:entity.prices,
      isPaid:entity.isPaid,
    );
  }
  ReceiptModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = DateTime.tryParse(json['date']??"")?.toLocal();
    patientId = json['patientId'];
    patient = BasicNameIdObjectModel.fromJson(json['patient'] ?? Map<String, dynamic>());
    operatorId = json['operatorId'];
    operator = BasicNameIdObjectModel.fromJson(json['operator'] ?? Map<String, dynamic>());
    toothReceiptData = ((json['toothReceiptData']??[]) as List<dynamic> ).map((e) => ToothReceiptModel.fromJson(e as Map<String,dynamic>)).toList();
    total = json['total'];
    paid = json['paid'];
    unpaid = json['unpaid'];
    prices = json['clinicPrices']==null?null:(json['clinicPrices'] as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e)).toList();
    isPaid = json['isPaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date==null?null:this.date!.toUtc().toIso8601String();
    data['patientId'] = this.patientId;
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
