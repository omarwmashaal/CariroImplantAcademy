import 'package:cariro_implant_academy/features/labRequest/data/models/labItemModel.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labItemParentModel.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labstepItemEntity.dart';

class LabStepItemModel extends LabStepItemEntity {
  LabStepItemModel({
    super.consumedLabItem,
    super.consumedLabItemId,
    super.id,
    super.labItemFromSettings,
    super.labItemFromSettingsId,
    super.labPrice,
    super.labRequestId,
    super.patientId,
    super.tooth,
    super.description,
  });

  LabStepItemModel.fromJson(Map<String, dynamic> data) {
    consumedLabItem = data['consumedLabItem'] == null ? null : LabItemModel.fromJson(data['consumedLabItem']);
    consumedLabItemId = data['consumedLabItemId'];
    id = data['id'];
    labItemFromSettings = data['labItemFromSettings'] == null ? null : LabItemParentModel.fromJson(data['labItemFromSettings']);
    labItemFromSettingsId = data['labItemFromSettingsId'];
    labPrice = data['labPrice'] ?? 0;
    labRequestId = data['labRequestId'];
    patientId = data['patientId'];
    tooth = data['tooth'];
    description = data['description'];
  }
  LabStepItemModel.fromEntity(LabStepItemEntity entity) {
    consumedLabItem = entity.consumedLabItem;
    consumedLabItemId = entity.consumedLabItemId;
    id = entity.id;
    labItemFromSettings = entity.labItemFromSettings;
    labItemFromSettingsId = entity.labItemFromSettingsId;
    labPrice = entity.labPrice;
    labRequestId = entity.labRequestId;
    patientId = entity.patientId;
    tooth = entity.tooth;
    description = entity.description;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['consumedLabItemId'] = this.consumedLabItemId;
    data['id'] = this.id;
    data['labItemFromSettingsId'] = this.labItemFromSettingsId;
    data['labPrice'] = this.labPrice;
    data['labRequestId'] = this.labRequestId;
    data['patientId'] = this.patientId;
    data['tooth'] = this.tooth;
    data['description'] = this.description;
    return data;
  }
}
