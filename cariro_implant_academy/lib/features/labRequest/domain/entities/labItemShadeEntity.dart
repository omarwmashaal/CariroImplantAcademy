import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

class LabItemShadeEntity extends BasicNameIdObjectEntity {
  int? labItemParentId;
  int? labItemCompanyId;
  LabItemShadeEntity({
    this.labItemParentId,
    this.labItemCompanyId,
    super.id,
    super.name,
  });
}
