import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/cashflow/data/models/installmentItemModel.dart';
import '../../domain/entities/installmentPlanEntity.dart';

class InstallmentPlanModel extends InstallmentPlanEntity {
  InstallmentPlanModel({
    super.id,
    super.userId,
    super.total,
    super.paidAmount,
    super.startDate,
    super.endDate,
    super.installmentInterval,
    super.status,
    super.numberOfPayments,
    super.installments,
  });

  factory InstallmentPlanModel.fromEntity(InstallmentPlanEntity entity) {
    return InstallmentPlanModel(
      id: entity.id,
      userId: entity.userId,
      total: entity.total,
      paidAmount: entity.paidAmount,
      startDate: entity.startDate,
      endDate: entity.endDate,
      installmentInterval: entity.installmentInterval,
      status: entity.status,
      numberOfPayments: entity.numberOfPayments,
      installments: entity.installments,
    );
  }

  InstallmentPlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    total = json['total'];
    paidAmount = json['paidAmount'];
    startDate = DateTime.tryParse(json['startDate'] ?? "")?.toLocal();
    endDate = DateTime.tryParse(json['endDate'] ?? "")?.toLocal();
    installmentInterval = EnumInstallmentInterval.values[json['installmentInterval']];
    status = EnumInstallmentStatus.values[json['status']];
    numberOfPayments = json['numberOfPayments'];
    installments = json['installments'] == null
        ? []
        : (json['installments'] as List<dynamic>).map((e) => InstallmentItemModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['total'] = this.total;
    data['paidAmount'] = this.paidAmount;
    data['startDate'] = this.startDate?.toUtc().toIso8601String();
    data['endDate'] = this.endDate?.toUtc().toIso8601String();
    data['installmentInterval'] = this.installmentInterval?.index;
    data['status'] = this.status?.index;
    data['numberOfPayments'] = this.numberOfPayments;
    data['installments'] = this.installments?.map((v) => InstallmentItemModel.fromEntity(v).toJson()).toList();
    if (this.installments != null) {}
    return data;
  }
}
