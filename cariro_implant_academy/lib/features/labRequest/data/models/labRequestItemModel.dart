import 'dart:convert';

import '../../domain/entities/labRequestItemEntity.dart';

class LabRequestItemModel extends LabRequestItemEntity {
  LabRequestItemModel({
    String? name,
    String? description,
    int? number,
    int? price,
    int? totalPrice,
  }) : super(name: name, description: description, number: number,price:price,totalPrice:totalPrice);


  factory LabRequestItemModel.fromJson(Map<String, dynamic> map) {
    return LabRequestItemModel(
      name: map['name'],
      description: map['description'],
      number: map['number'],
      price: map['price'],
      totalPrice: map['totalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'number': number,
      'price': price,
      'totalPrice': totalPrice,
    };
  }

  LabRequestItemModel.fromEntity(LabRequestItemEntity entity)
      : super(
    name: entity.name,
    description: entity.description,
    number: entity.number,
    price: entity.price,
    totalPrice: entity.totalPrice,
  );
}
