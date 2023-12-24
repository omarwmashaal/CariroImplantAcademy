import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemParentEntity.dart';

class LabItemParentModel extends LabItemParentEntity {
  LabItemParentModel({
    super.id,
    super.name,
    super.unitPrice,
  });

  factory LabItemParentModel.fromJson(Map<String, dynamic> map) {
    return LabItemParentModel(
      name: map['name'],
      id: map['id'],
      unitPrice: map['unitPrice'],
    );
  }
  factory LabItemParentModel.fromEntity(LabItemParentEntity entity) {
    return LabItemParentModel(
      name:entity.name,
      id:entity.id,
      unitPrice:entity.id,
    );
  }

  Map<String,dynamic> toJson()
  {
    Map<String,dynamic> data = Map<String,dynamic>();
    data['name'] = this.name;
    data['unitPrice'] = this.unitPrice;
    data['id'] = this.id;
    return data;
  }
}
