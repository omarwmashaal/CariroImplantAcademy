import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemCompanyEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemParentEntity.dart';

class LabItemCompanyModel extends LabItemCompanyEntity {
  LabItemCompanyModel({
    super.labItemParentId,
    super.id,
    super.name,
  });

  factory LabItemCompanyModel.fromJson(Map<String, dynamic> map) {
    return LabItemCompanyModel(
      labItemParentId: map['labItemParentId'],
    id: map['id'],
    name: map['name'],
    );
  }
  factory LabItemCompanyModel.fromEntity(LabItemCompanyEntity entity) {
    return LabItemCompanyModel(
     labItemParentId: entity.labItemParentId,
    id: entity.id,
    name: entity.name,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
   data['labItemParentId'] = labItemParentId;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
