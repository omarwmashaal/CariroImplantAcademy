import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

import '../../../../../Models/StockModel.dart';

class ImplantEntity extends BasicNameIdObjectEntity {
  int? count;
  String? size;
  int? stockItemId;
  StockModel? stockItem;

  ImplantEntity({
    super.id,
    super.name = "",
    this.count = 0,
    this.size,
    this.stockItem,
    this.stockItemId,
  });

  @override
  List<Object?> get props => [name, id, count, size, stockItemId, stockItem];
}
