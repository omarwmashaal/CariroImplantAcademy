import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

class StockLogEntity extends Equatable {
  int? id;
  String? name;
  int? count;
  int? categoryId;
  BasicNameIdObjectEntity? category;
  DateTime? date;
  String? status;
  int? operatorID;
  BasicNameIdObjectEntity? operator;

  StockLogEntity({
    this.id,
    this.name,
    this.count,
    this.operatorID,
    this.operator,
    this.category,
    this.categoryId,
    this.status,
    this.date,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        count,
        categoryId,
        category,
        date,
        status,
        operator,
        operatorID,
      ];

//IncomeDataSource dataSource = IncomeDataSource();
}
