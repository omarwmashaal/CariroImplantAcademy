import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';

import '../../../../../Models/StockModel.dart';
import '../../domain/entities/implantEntity.dart';

class ImplantModel extends ImplantEntity {
  ImplantModel({
    super.count,
    super.id,
    super.name,
    super.size,
    super.stockItem,
    super.stockItemId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['size'] = this.size;
    data['count'] = this.count;
    data['stockItemId'] = this.stockItemId;
    if (this.stockItem != null) {
      data['stockItem'] = this.stockItem!.toJson();
    }
    return data;
  }

  factory ImplantModel.fromJson(Map<String, dynamic> json) {
    return ImplantModel(
      id: json['id'],
      name: json['name'] ?? "",
      size: json['size'],
      count: json['count'],
      stockItemId: json['stockItemId'],
      stockItem: json['stockItem'] != null ? new StockModel.fromJson(json['stockItem']) : null,
    );
  }
}
