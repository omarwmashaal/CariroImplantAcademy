
import 'package:cariro_implant_academy/features/cashflow/domain/entities/installmentItemEntity.dart';

class InstallmentItemModel extends InstallmentItemEntity {
  InstallmentItemModel({
    super.index,
    super.amount,
    super.paidAmount,
    super.paid,
    super.dueDate,
    super.lastDateOfPayment,
  });

  factory InstallmentItemModel.fromEntity(InstallmentItemEntity entity) {
    return InstallmentItemModel(
      index: entity.index,
      amount: entity.amount,
      paidAmount: entity.paidAmount,
      paid: entity.paid,
      dueDate: entity.dueDate,
      lastDateOfPayment: entity.lastDateOfPayment,
    );
  }

  InstallmentItemModel.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    amount = json['amount'];
    paidAmount = json['paidAmount'];
    paid = json['paid'];
    dueDate = DateTime.tryParse(json['dueDate'] ?? "")?.toLocal();
    lastDateOfPayment = DateTime.tryParse(json['lastDateOfPayment'] ?? "")?.toLocal();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['amount'] = this.amount;
    data['paidAmount'] = this.paidAmount;
    data['paid'] = this.paid;
    data['dueDate'] = this.dueDate?.toUtc().toIso8601String();
    data['lastDateOfPayment'] = this.lastDateOfPayment?.toUtc().toIso8601String();
    return data;
  }
}
