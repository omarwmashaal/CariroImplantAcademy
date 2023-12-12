import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/features/settings/domain/entities/implantEntity.dart';

class CandidateDetailsEntity extends Equatable {
  final String? patientId;
  final BasicNameIdObjectEntity? patient;
  final String? procedure;
  final DateTime? date;
  final int? implantCount;
  final List<String>? otherProcedures;
  final int? totalImplantCounts;
  final int? tooth;
  final int? implantId;
  final ImplantEntity? implant;

  CandidateDetailsEntity({
    this.patientId,
    this.patient,
    this.procedure,
    this.date,
    this.implantCount,
    this.otherProcedures,
    this.totalImplantCounts,
    this.tooth,
    this.implantId,
    this.implant,
  });

  @override
  List<Object?> get props => [
    patientId,
    patient,
    procedure,
    date,
    implantCount,
    otherProcedures,
    totalImplantCounts,
    tooth,
    implantId,
    implant,
  ];
}
