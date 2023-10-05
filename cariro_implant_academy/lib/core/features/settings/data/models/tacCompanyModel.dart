import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';

class TacCompanyModel extends TacCompanyEntity {
  TacCompanyModel({
    super.count,
    super.id,
    super.name,
  });

  factory TacCompanyModel.fromEntity(TacCompanyEntity entity)
  {
    return TacCompanyModel(
     id: entity.id,
     name: entity.name,
     count: entity.count
    );
  }
  factory TacCompanyModel.fromJson(Map<String, dynamic> json) {
    return TacCompanyModel(
      id: json['id'],
      name: json['name'] ?? "",
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}
