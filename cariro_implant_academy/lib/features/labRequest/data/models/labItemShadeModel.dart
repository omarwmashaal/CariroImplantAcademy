import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemCompanyEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemParentEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemShadeEntity.dart';

class LabItemShadeModel extends LabItemShadeEntity {
  LabItemShadeModel({
    super.labItemParentId,
    super.labItemCompanyId,
    super.id,
    super.name,
  });

  factory LabItemShadeModel.fromJson(Map<String, dynamic> map) {
    return LabItemShadeModel(
     labItemParentId: map['labItemParentId'],
    labItemCompanyId: map['labItemCompanyId'],
    id: map['id'],
    name: map['name'],
    );
  }
  factory LabItemShadeModel.fromEntity(LabItemShadeEntity entity) {
    return LabItemShadeModel(
    labItemParentId: entity.labItemParentId,
    labItemCompanyId: entity.labItemCompanyId,
    id: entity.id,
    name: entity.name,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
   data['labItemParentId'] = labItemParentId;
    data['labItemCompanyId'] = labItemCompanyId;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
