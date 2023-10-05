import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';

import '../../domain/entities/membraneCompanyEnity.dart';
import '../../domain/entities/membraneEnity.dart';

class MembraneModel extends MembraneEntity {
  MembraneModel({
    super.id,
    super.name,
    super.size,
  });

  factory MembraneModel.fromEntity(MembraneEntity entity) {
    return MembraneModel(
      size: entity.size,
      name: entity.name,
      id: entity.id,
    );
  }

  factory MembraneModel.fromJson(Map<String, dynamic> json) {
    return MembraneModel(
      id: json['id'],
      size: json['size'],
      name: json['name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['size'] = this.size;
    return data;
  }
}
