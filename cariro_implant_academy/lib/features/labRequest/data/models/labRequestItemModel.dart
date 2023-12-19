import 'dart:convert';

import '../../domain/entities/labRequestItemEntity.dart';

class LabRequestItemModel extends LabRequestItemEntity {
  LabRequestItemModel({
    String? name,
    String? description,
    int? number,
  }) : super(name: name, description: description, number: number);


  factory LabRequestItemModel.fromJson(Map<String, dynamic> map) {
    return LabRequestItemModel(
      name: map['name'],
      description: map['description'],
      number: map['number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'number': number,
    };
  }

  LabRequestItemModel.fromEntity(LabRequestItemEntity entity)
      : super(
    name: entity.name,
    description: entity.description,
    number: entity.number,
  );
}
