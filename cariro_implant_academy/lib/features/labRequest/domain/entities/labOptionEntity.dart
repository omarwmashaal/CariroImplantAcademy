import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemParentEntity.dart';

class LabOptionEntity extends BasicNameIdObjectEntity {
  int? labItemParentId;
  LabItemParentEntity? labItemParent;
  int? price;
  LabOptionEntity({
    this.labItemParentId,
    this.labItemParent,
    this.price = 0,
    super.id,
    super.name,
  });
}
