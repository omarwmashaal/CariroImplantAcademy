import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

class LabOptionEntity extends BasicNameIdObjectEntity {
  int? labItemParentId;
  BasicNameIdObjectEntity? labItemParent;
  int? price;
  LabOptionEntity({
    this.labItemParentId,
    this.labItemParent,
    this.price = 0,
    super.id,
    super.name,
  });
}
