import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemParentEntity.dart';

class LabItemParentModel extends LabItemParentEntity {
  LabItemParentModel({
    super.hasCode = true,
    super.hasCompanies = true,
    super.hasShades = true,
    super.hasSize = true,
    super.isStock = true,
    super.id,
    super.name,
  });

  factory LabItemParentModel.fromJson(Map<String, dynamic> map) {
    return LabItemParentModel(
      hasCode: map['hasCode'],
      hasCompanies: map['hasCompanies'],
      hasShades: map['hasShades'],
      hasSize: map['hasSize'],
      isStock: map['isStock'],
      id: map['id'],
      name: map['name'],
    );
  }
  factory LabItemParentModel.fromEntity(LabItemParentEntity entity) {
    return LabItemParentModel(
      hasCode: entity.hasCode,
      hasCompanies: entity.hasCompanies,
      hasShades: entity.hasShades,
      hasSize: entity.hasSize,
      isStock: entity.isStock,
      id: entity.id,
      name: entity.name,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['hasCode'] = hasCode;
    data['hasCompanies'] = hasCompanies;
    data['hasShades'] = hasShades;
    data['hasSize'] = hasSize;
    data['isStock'] = isStock;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
