import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

class LabItemCompanyEntity extends BasicNameIdObjectEntity {
  int? labItemParentId;
  LabItemCompanyEntity({
    this.labItemParentId,
    super.id,
    super.name,
  });
}
