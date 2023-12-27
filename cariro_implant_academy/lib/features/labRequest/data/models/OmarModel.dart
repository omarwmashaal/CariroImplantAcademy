import 'package:cariro_implant_academy/features/labRequest/domain/entities/OmarEntity.dart';

import 'labItemModel.dart';

class OmarModelsss extends OmarEntity{
  OmarModelsss({
    super.description,
    super.labItem,
    super.labItemId,
    super.name,
    super.number,
    super.price,
    super.totalPrice,
  }) ;

  factory OmarModelsss.fromJson(Map<String, dynamic> map) {
    return OmarModelsss(
      name: map['name'],
      description: map['description'],
      number: map['number'],
      price: map['price'],
      totalPrice: map['totalPrice'],
      labItemId: map['labItemId'],
      labItem: map['labItem'] == null ? null : LabItemModel.fromJson(map['labItem']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'number': number,
      'price': price,
      'totalPrice': totalPrice,
      'labItemId': labItemId,
    };
  }

  OmarModelsss.fromEntity(OmarEntity entity)
      : super(
    name: entity.name,
    description: entity.description,
    number: entity.number,
    price: entity.price,
    totalPrice: entity.totalPrice,
    labItemId: entity.labItemId,
  );
}