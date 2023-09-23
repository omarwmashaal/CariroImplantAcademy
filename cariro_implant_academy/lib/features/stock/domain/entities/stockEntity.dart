import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

class StockEntity extends Equatable {
  int? id;
  String? name;
  int? count;
  int? categoryId;
  BasicNameIdObjectEntity? category;

  StockEntity({this.id, this.name, this.count, this.category,categoryId});



  @override
  List<Object?> get props => [
        id,
        name,
        count,
        categoryId,
        category,
      ];
//IncomeDataSource dataSource = IncomeDataSource();
}
