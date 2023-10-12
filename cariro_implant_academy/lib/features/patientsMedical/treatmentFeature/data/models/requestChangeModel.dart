import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/requestChangeEntity.dart';

class RequestChangeModel extends RequestChangeEntity {
  RequestChangeModel({
    required super.description,
    required super.id,
    required super.patient,
    required super.patientId,
    required super.requestEnum,
    super.user,
    super.userId,
    super.dataId,
    super.dataName,
  });

  factory RequestChangeModel.fromEntity(RequestChangeEntity entity) {
    return RequestChangeModel(
      description: entity.description,
      id: entity.id,
      patient: entity.patient,
      patientId: entity.patientId,
      requestEnum: entity.requestEnum,
      user: entity.user,
      userId: entity.userId,
      dataId: entity.dataId,
      dataName: entity.dataName,
    );
  }

  factory RequestChangeModel.fromJson(Map<String, dynamic> json) {
    return RequestChangeModel(
      description: json["description"],
      id: json["id"],
      dataName: json["dataName"],
      dataId: json["dataId"],
      patient: json['patient'] == null ? null:BasicNameIdObjectModel.fromJson(json['patient'] as Map<String, dynamic>),
      patientId: json["patientId"],
      requestEnum: RequestChangeEnum.values[json['requestEnum']],
      userId: json['userId'],
      user: json['user'] == null ? null : BasicNameIdObjectModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['description'] = description;
    data['dataId'] = dataId;
    data['dataName'] = dataName;
    data['id'] = id;
   // data['patient'] = BasicNameIdObjectModel.fromEntity(patient).toJson();
    data['patientId'] = patientId;
    data['requestEnum'] = requestEnum.index;
    data['userId'] = userId;
    //data['user'] = user == null ? null : BasicNameIdObjectModel.fromEntity(user!).toJson();

    return data;
  }
}
