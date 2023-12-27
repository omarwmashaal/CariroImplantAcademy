import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/data/models/dentalExaminationBaseModel.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockEntity.dart';

class StockModel extends StockEntity {
  StockModel({
    super.category,
    super.count,
    super.id,
    super.name,
    super.code,
    super.categoryId,
    super.companyName,
    super.labItemType,
    super.shadeName,
  });

  StockModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "";
    count = json['count'] ?? 0;
    categoryId = json['categoryId'];
    code = json['code'];

    if (json['labItemShade'] != null) {
      shadeName = BasicNameIdObjectModel.fromJson(json['labItemShade']).name;
      if (json['labItemShade']['labItemCompany'] != null) {
        companyName = BasicNameIdObjectModel.fromJson(json['labItemShade']['labItemCompany']).name;
        if (json['labItemShade']['labItemCompany']['labItemParent'] != null) {
          labItemType = BasicNameIdObjectModel.fromJson(json['labItemShade']['labItemCompany']['labItemParent']).name;
        }
      }
    }

    category = BasicNameIdObjectModel.fromJson(json['category'] ?? Map<String, dynamic>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['count'] = this.count;
    data['categoryId'] = this.categoryId;
    data['category'] = this.category != null ? BasicNameIdObjectModel.fromEntity(this.category!).toJson() : null;
    return data;
  }
}
