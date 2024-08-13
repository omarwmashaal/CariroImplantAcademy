import 'package:cariro_implant_academy/core/features/settings/domain/entities/labSizesThresholdEntity.dart';

class LabSizesThresholdModel extends LabSizesThresholdEntity {
  LabSizesThresholdModel({
    super.id,
    super.parentId,
    super.size,
    super.threshold,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map();
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    data['size'] = this.size;
    data['threshold'] = this.threshold;
    return data;
  }

  LabSizesThresholdModel.fromJson(Map<String, dynamic> data) {
    this.id = data['id'];
    this.parentId = data['parentId'];
    this.size = data['size'];
    this.threshold = data['threshold'];
  }
  LabSizesThresholdModel.fromEntity(LabSizesThresholdEntity data) {
    this.id = data.id;
    this.parentId = data.parentId;
    this.size = data.size;
    this.threshold = data.threshold;
  }
}
