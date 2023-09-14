import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';

import '../../domain/entities/membraneCompanyEnity.dart';

class MembraneCompanyModel extends MembraneCompanyEntity {
  MembraneCompanyModel({
    super.id,
    super.name,
  });

  factory MembraneCompanyModel.fromJson(Map<String, dynamic> json) {
    return MembraneCompanyModel(
      id: json['id'],
      name: json['name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
