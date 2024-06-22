import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/installmentItemEntity.dart';

class InstallmentPlanEntity {
  int? id;
  int? userId;
  int? total;
  int? paidAmount;
  DateTime? startDate;
  DateTime? endDate;
  EnumInstallmentInterval? installmentInterval;
  EnumInstallmentStatus? status;
  int? numberOfPayments;
  List<InstallmentItemEntity>? installments;

  InstallmentPlanEntity({
    this.id,
    this.userId,
    this.total,
    this.paidAmount,
    this.startDate,
    this.endDate,
    this.installmentInterval,
    this.status,
    this.numberOfPayments,
    this.installments,
  });
}
