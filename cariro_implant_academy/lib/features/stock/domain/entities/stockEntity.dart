import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

class StockEntity extends BasicNameIdObjectEntity {
  int? id;
  String? name;
  int? count;
  String? code;
  int? categoryId;
  BasicNameIdObjectEntity? category;
  String? companyName;
  String? shadeName;
  String? labItemType;
  int? consumeCount;
  bool? consumed;

  StockEntity({
    this.id,
    this.name,
    this.consumeCount,
    this.consumed,
    this.count,
    this.category,
    this.code,
    this.categoryId,
    this.companyName,
    this.labItemType,
    this.shadeName,
  });

  @override
  List<Object?> get props => [
        id,
        name,
    consumeCount,
        count,
    consumed,
        categoryId,
        category,
    code,
      ];
//IncomeDataSource dataSource = IncomeDataSource();
}
