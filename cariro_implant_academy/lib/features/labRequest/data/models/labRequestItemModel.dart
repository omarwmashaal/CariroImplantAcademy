import 'dart:convert';

import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labItemModel.dart';

import '../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import '../../domain/entities/labItemEntity.dart';
import '../../domain/entities/labRequestItemEntity.dart';

class LabRequestItemModel extends LabRequestItemEntity {
  LabRequestItemModel({
    String? name,
    String? description,
    int? number,
    int? price,
    int? totalPrice,
    int? labItemId,
    LabItemEntity? labItem,
  }) : super(
          name: name,
          description: description,
          number: number,
          price: price,
          totalPrice: totalPrice,
          labItem: labItem,
          labItemId: labItemId,
        );

  factory LabRequestItemModel.fromJson(Map<String, dynamic> map) {
    return LabRequestItemModel(
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

  LabRequestItemModel.fromEntity(LabRequestItemEntity entity)
      : super(
          name: entity.name,
          description: entity.description,
          number: entity.number,
          price: entity.price,
          totalPrice: entity.totalPrice,
          labItemId: entity.labItemId,
        );
}
