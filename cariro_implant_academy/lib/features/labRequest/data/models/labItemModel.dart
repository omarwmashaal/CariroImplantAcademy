import '../../domain/entities/labItemEntity.dart';

class LabItemModel extends LabItemEntity {
  LabItemModel({
    super.id,
    super.code,
    super.consumedCount,
    super.unitPrice,
    super.consumed,
    super.size,
    super.labItemShadeId,
    super.labItemShade,
  });

  factory LabItemModel.fromJson(Map<String, dynamic> map) {
    return LabItemModel(
      id: map['id'],
      code: map['code'],
      consumedCount: map['consumedCount'],
      unitPrice: map['unitPrice'],
      consumed: map['consumed'],
      size: map['size'],
      labItemShadeId: map['labItemShadeId'],
      labItemShade: map['labItemShade'],
    );
  }

  factory LabItemModel.fromEntity(LabItemEntity entity) {
    return LabItemModel(
      id: entity.id,
      code: entity.code,
      consumedCount: entity.consumedCount,
      unitPrice: entity.unitPrice,
      consumed: entity.consumed,
      size: entity.size,
      labItemShadeId: entity.labItemShadeId,
      labItemShade: entity.labItemShade,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['consumedCount'] = this.consumedCount;
    data['unitPrice'] = this.unitPrice;
    data['consumed'] = this.consumed;
    data['size'] = this.size;
    data['labItemShadeId'] = this.labItemShadeId;
    data['labItemShade'] = this.labItemShade;
    return data;
  }
}
