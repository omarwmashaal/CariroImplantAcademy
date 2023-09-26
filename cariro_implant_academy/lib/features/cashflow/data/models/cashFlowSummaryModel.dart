import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowSummaryEntity.dart';

import 'cashFlowItemSummaryModel.dart';

class CashFlowSummaryModel extends CashFlowSummaryEntity {
  CashFlowSummaryModel({
    super.category,
    super.expenses,
    super.from,
    super.income,
    super.to,
  });

  CashFlowSummaryModel.fromJson(Map<String, dynamic> json) {
    from = DateTime.tryParse(json['from']??"")?.toLocal();
    to = DateTime.tryParse(json['to']??"")?.toLocal();
    category = BasicNameIdObjectModel.fromJson((json['category']??Map<String,dynamic>()) as Map<String,dynamic>);
    income = ((json['income']??[]) as List<dynamic>).map((e) => CashFlowItemSummaryModel.fromJson(e as Map<String,dynamic>)).toList();
    expenses = ((json['expenses']??[]) as List<dynamic>).map((e) => CashFlowItemSummaryModel.fromJson(e as Map<String,dynamic>)).toList();

  }
}
