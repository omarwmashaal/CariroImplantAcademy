import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/entities/cbctEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/entities/dentalHistoryEntity.dart';

import '../../../../../core/constants/enums/enums.dart';

class CBCT_Model extends CBCT_Entity {
  CBCT_Model({
    super.date,
    super.done,
  });

  factory CBCT_Model.fromJson(Map<String, dynamic> json) {
    return CBCT_Model(
      date: DateTime.tryParse(json['date'] ?? "")?.toLocal(),
      done: json['done'] ?? 0,
    );
  }

  factory CBCT_Model.fromEntity(CBCT_Entity entity) {
    return CBCT_Model(
      done: entity.done,
      date: entity.date,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['done'] = this.done;
    data['date'] = this.date == null ? null : this.date!.toUtc().toIso8601String();
    return data;
  }
}
