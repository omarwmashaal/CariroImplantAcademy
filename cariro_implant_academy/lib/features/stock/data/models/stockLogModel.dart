import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/data/models/dentalExaminationBaseModel.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockEntity.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockLogEntity.dart';

class StockLogModel extends StockLogEntity {
  StockLogModel({
    super.category,
    super.categoryId,
    super.count,
    super.date,
    super.id,
    super.name,
    super.operator,
    super.operatorID,
    super.status,
  });

  StockLogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "";
    count = json['count'] ?? 0;
    categoryId = json['categoryId'];
    category = BasicNameIdObjectModel.fromJson(json['category'] ?? Map<String, dynamic>());
    date = DateTime.tryParse(json['date']??"");
    status = json['status'];
    operatorID = json['operatorID'];
    operator = BasicNameIdObjectModel.fromJson(json['operator'] ?? Map<String, dynamic>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['count'] = this.count;
    data['categoryId'] = this.categoryId;
    data['category'] = this.category != null ? BasicNameIdObjectModel.fromEntity(this.category!).toJson() : null;
    data['date'] = this.date==null?null:this.date!.toIso8601String();
    data['status'] = this.status;
    data['operatorID'] = this.operatorID;
    data['operator'] = this.operator == null ? null : BasicNameIdObjectModel.fromEntity(this.operator!).toJson();
    return data;
  }
}