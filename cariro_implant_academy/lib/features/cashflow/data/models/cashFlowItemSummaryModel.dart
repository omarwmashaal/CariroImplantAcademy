import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowItemSummaryEntity.dart';

import '../../../../core/data/models/BasicNameIdObjectModel.dart';

class CashFlowItemSummaryModel extends CashFlowItemSummaryEntity{
  CashFlowItemSummaryModel({
    super.category,
    super.total,
});
  CashFlowItemSummaryModel.fromJson(Map<String, dynamic> json) {
    category = BasicNameIdObjectModel.fromJson((json['category']??Map<String,dynamic>()));
    total = json['total'];

  }
}