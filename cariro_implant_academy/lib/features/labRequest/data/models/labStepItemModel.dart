import 'package:cariro_implant_academy/features/labRequest/data/models/labItemModel.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labItemParentModel.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labOptionModel.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labstepItemEntity.dart';

class LabStepItemModel extends LabStepItemEntity {
  LabStepItemModel({
    super.consumedLabItem,
    super.consumedLabItemId,
    super.id,
    super.labPrice,
    super.labRequestId,
    super.patientId,
    super.labOption,
    super.labOptionId,
    super.tooth,
    super.description,
  });

  LabStepItemModel.fromJson(Map<String, dynamic> data) {
    consumedLabItem = data['consumedLabItem'] == null ? null : LabItemModel.fromJson(data['consumedLabItem']);
    consumedLabItemId = data['consumedLabItemId'];
    id = data['id'];
    labPrice = data['labPrice'] ?? 0;
    labRequestId = data['labRequestId'];
    patientId = data['patientId'];
    tooth = data['tooth'];
    description = data['description'];
    labOption = data['labOption']==null?null:LabOptionModel.fromJson(data['labOption']);
    labOptionId = data['labOptionId'];
  }
  LabStepItemModel.fromEntity(LabStepItemEntity entity) {
    consumedLabItem = entity.consumedLabItem;
    consumedLabItemId = entity.consumedLabItemId;
    id = entity.id;
    labPrice = entity.labPrice;
    labRequestId = entity.labRequestId;
    patientId = entity.patientId;
    tooth = entity.tooth;
    description = entity.description;
    labOptionId = entity.labOptionId;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['consumedLabItemId'] = this.consumedLabItemId;
    data['id'] = this.id;
    data['labPrice'] = this.labPrice;
    data['labRequestId'] = this.labRequestId;
    data['patientId'] = this.patientId;
    data['tooth'] = this.tooth;
    data['description'] = this.description;
    data['labOptionId'] = this.labOptionId;
    return data;
  }
}
