import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums/enums.dart';

class RequestChangeEntity extends Equatable {
  int? id;
  String description;
  RequestChangeEnum requestEnum;
  int? userId;
  BasicNameIdObjectEntity? user;
  int patientId;
  BasicNameIdObjectEntity? patient;
  int? dataId;
  String? dataName;

  RequestChangeEntity({
    this.id,
    required this.description,
    required this.requestEnum,
    this.user,
    this.userId,
    required this.patientId,
     this.patient,
     this.dataId,
     this.dataName,
  });

  @override
  List<Object?> get props => [
        id,
        description,
        requestEnum,
        userId,
        user,
        patientId,
        patient,
    dataId,
    dataName,
      ];
}
