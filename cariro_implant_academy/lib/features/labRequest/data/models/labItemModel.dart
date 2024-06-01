import '../../domain/entities/labItemEntity.dart';

class LabItemModel extends LabItemEntity {
  LabItemModel({
    super.id,
    super.code,
    super.consumedCount,
    super.consumed,
    super.size,
    super.labItemShadeId,
    super.labItemShade,
    super.name,
    super.labItemCompanyId,
    super.labItemParentId,
  });

  factory LabItemModel.fromJson(Map<String, dynamic> map) {
    return LabItemModel(
      id: map['id'],
      code: map['code'],
      consumedCount: map['consumedCount'],
      consumed: map['consumed'],
      size: map['size'],
      labItemShadeId: map['labItemShadeId'],
      labItemShade: map['labItemShade'],
      name: map['name'],
      labItemCompanyId: map['labItemCompanyId'],
      labItemParentId: map['labItemParentId'],
    );
  }

  factory LabItemModel.fromEntity(LabItemEntity entity) {
    return LabItemModel(
      id: entity.id,
      code: entity.code,
      consumedCount: entity.consumedCount,
      consumed: entity.consumed,
      size: entity.size,
      labItemShadeId: entity.labItemShadeId,
      labItemShade: entity.labItemShade,
      labItemCompanyId: entity.labItemCompanyId,
      labItemParentId: entity.labItemParentId,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['consumedCount'] = this.consumedCount;
    data['consumed'] = this.consumed;
    data['size'] = this.size;
    data['labItemShadeId'] = this.labItemShadeId;
    data['labItemShade'] = this.labItemShade;
    data['labItemCompanyId'] = this.labItemCompanyId;
    data['labItemParentId'] = this.labItemParentId;
    return data;
  }
}
