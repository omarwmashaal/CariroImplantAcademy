import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';

import '../../domain/entities/membraneCompanyEnity.dart';
import '../../domain/entities/membraneEnity.dart';

class MembraneCompanyModel extends MembraneEntity {
  MembraneCompanyModel({
    super.id,
    super.name,
    super.size,
  });

  factory MembraneCompanyModel.fromJson(Map<String, dynamic> json) {
    return MembraneCompanyModel(
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
