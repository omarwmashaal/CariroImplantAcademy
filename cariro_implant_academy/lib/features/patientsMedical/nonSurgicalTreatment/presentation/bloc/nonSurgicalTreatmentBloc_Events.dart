import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/domain/entities/dentalExaminationBaseEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/domain/entities/dentalExaminationEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:equatable/equatable.dart';

abstract class NonSurgicalTreatmentBloc_Events extends Equatable {}

class NonSurgicalTreatmentBloc_GetDataEvent extends NonSurgicalTreatmentBloc_Events {
  final int id;

  NonSurgicalTreatmentBloc_GetDataEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class NonSurgicalTreatmentBloc_GetAllDataEvent extends NonSurgicalTreatmentBloc_Events {
  final int id;

  NonSurgicalTreatmentBloc_GetAllDataEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class NonSurgicalTreatmentBloc_SaveDataEvent extends NonSurgicalTreatmentBloc_Events {
  final NonSurgicalTreatmentEntity nonSurgicalTreatmentEntity;
  final DentalExaminationBaseEntity? dentalExaminationEntity;
  final int patientId;
  final bool delete;

  NonSurgicalTreatmentBloc_SaveDataEvent({
    required this.nonSurgicalTreatmentEntity,
    this.dentalExaminationEntity,
    required this.patientId,
    this.delete = false,
  });

  @override
  List<Object?> get props => [
        nonSurgicalTreatmentEntity,
        dentalExaminationEntity,
      ];
}

class NonSurgicalTreatmentBloc_CheckTeethStatusEvent extends NonSurgicalTreatmentBloc_Events {
  final String treatment;

  NonSurgicalTreatmentBloc_CheckTeethStatusEvent({required this.treatment});

  @override
  List<Object?> get props => [treatment];
}

class NonSurgicalTreatmentBloc_GetPaidTreatmentPlanItemEvent extends NonSurgicalTreatmentBloc_Events {
  final int patientId;
  final int tooth;
  final String action;

  NonSurgicalTreatmentBloc_GetPaidTreatmentPlanItemEvent({
    required this.patientId,
    required this.tooth,
    required this.action,
  });

  @override
  List<Object?> get props => [
        patientId,
        tooth,
      ];
}

class NonSurgicalTreatmentBloc_AddPatientReceiptEvent extends NonSurgicalTreatmentBloc_Events {
  final int patientId;
  final int tooth;
  final String action;
  final int? price;

  NonSurgicalTreatmentBloc_AddPatientReceiptEvent({
    required this.patientId,
    required this.tooth,
    required this.action,
    this.price,
  });

  @override
  List<Object?> get props => [
        patientId,
        tooth,
        action,
        price,
      ];
}
