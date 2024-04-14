import 'dart:convert';

import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/ImplantModel.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/implantEntity.dart';
import 'package:cariro_implant_academy/features/patient/data/models/patientInfoModel.dart';
import 'package:equatable/equatable.dart';

import '../../../Models/CandidateDetails.dart';
import '../../../Models/ImplantModel.dart';
import '../../../core/data/models/BasicNameIdObjectModel.dart';
import '../domain/entities/canidateDetailsEntity.dart';


class CandidateDetailsModel extends CandidateDetailsEntity {
  CandidateDetailsModel({
    String? patientId,
    BasicNameIdObjectModel? patient,
    String? procedure,
    DateTime? date,
    int? implantCount,
    List<String>? otherProcedures,
    int? totalImplantCounts,
    int? tooth,
    int? implantId,
    ImplantEntity? implant,
  }) : super(
    patientId: patientId,
    patient: patient,
    procedure: procedure,
    date: date,
    implantCount: implantCount,
    otherProcedures: otherProcedures,
    totalImplantCounts: totalImplantCounts,
    tooth: tooth,
    implantId: implantId,
    implant: implant,
  );

  factory CandidateDetailsModel.fromJson(String source) =>
      CandidateDetailsModel.fromMap(json.decode(source));

  factory CandidateDetailsModel.fromMap(Map<String, dynamic> map) {
    return CandidateDetailsModel(
      patientId:map['patient']==null?null: (PatientInfoModel.fromMap(map['patient']).secondaryId),
      patient:map['patient']==null?null: BasicNameIdObjectModel.fromJson(map['patient']),
      procedure: map['procedure'],
      date: DateTime.tryParse(map['date']),
      implantCount: map['implantCount'],
      otherProcedures:(map['otherProcedures'])?.map((e)=>e as String).toList(),
      totalImplantCounts: map['totalImplantCounts'],
      tooth: map['tooth'],
      implantId: map['implantId'],
      implant:map['implant']==null?null: ImplantModel.fromJson(map['implant']),
    );
  }
}
