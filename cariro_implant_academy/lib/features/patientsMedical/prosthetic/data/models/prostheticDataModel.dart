import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDataEntity.dart';

class ProstheticDataModel extends ProstheticDataEntity {
  ProstheticDataModel({
    super.item,
    super.itemId,
  });
  ProstheticDataModel.fromJson(Map<String, dynamic> data) {
    itemId = data['diagnosticItemId'] ?? data['finalItemId'];
    if (data['diagnosticItem'] != null) {
      item = BasicNameIdObjectModel.fromJson(data['diagnosticItem']);
    } else if (data['finalItem'] != null) {
      item = BasicNameIdObjectModel.fromJson(data['finalItem']);
    }
  }
}
