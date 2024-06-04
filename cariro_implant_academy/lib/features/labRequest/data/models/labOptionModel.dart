import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labItemParentModel.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemCompanyEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemParentEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemShadeEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labOptionEntity.dart';

class LabOptionModel extends LabOptionEntity {
  LabOptionModel({
    super.labItemParentId,
    super.price,
    super.id,
    super.name,
    super.labItemParent,
  });

  factory LabOptionModel.fromJson(Map<String, dynamic> map) {
    return LabOptionModel(
      labItemParentId: map['labItemParentId'],
      labItemParent: map['labItemParent']==null?null:LabItemParentModel.fromJson(map['labItemParent']),
      price: map['price'],
      id: map['id'],
      name: map['name'],
    );
  }
  factory LabOptionModel.fromEntity(LabOptionEntity entity) {
    return LabOptionModel(
      labItemParentId: entity.labItemParentId,
      price: entity.price,
      id: entity.id,
      name: entity.name,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['labItemParentId'] = labItemParentId;
    data['price'] = price;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
