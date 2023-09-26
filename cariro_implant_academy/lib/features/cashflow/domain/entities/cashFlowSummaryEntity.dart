import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowItemSummaryEntity.dart';
import 'package:equatable/equatable.dart';

class CashFlowSummaryEntity extends Equatable {
  DateTime? from;
  DateTime? to;
  BasicNameIdObjectEntity? category;
  List<CashFlowItemSummaryEntity>? income;
  List<CashFlowItemSummaryEntity>? expenses;

  CashFlowSummaryEntity({
    this.income,
    this.category,
    this.to,
    this.from,
    this.expenses,
  });

  @override
  List<Object?> get props => [
        from,
        to,
        category,
        income,
        expenses,
      ];
}
