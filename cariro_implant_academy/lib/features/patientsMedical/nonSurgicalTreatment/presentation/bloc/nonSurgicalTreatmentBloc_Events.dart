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
  final DentalExaminationBaseEntity dentalExaminationEntity;
  final int patientId;

  NonSurgicalTreatmentBloc_SaveDataEvent({
    required this.nonSurgicalTreatmentEntity,
    required this.dentalExaminationEntity,
    required this.patientId,
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
