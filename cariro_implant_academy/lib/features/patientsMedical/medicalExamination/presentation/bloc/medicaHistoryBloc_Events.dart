import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/domain/entities/medicalExaminationEntity.dart';
import 'package:equatable/equatable.dart';

abstract class MedicalHistoryBloc_Events extends Equatable{}

class MedicalHistoryBloc_GetMedicalHistoryEvent extends MedicalHistoryBloc_Events{
  final int id;
  MedicalHistoryBloc_GetMedicalHistoryEvent({required this.id});
  @override
  List<Object?> get props => [id];

}
class MedicalHistoryBloc_SaveMedicalHistoryEvent extends MedicalHistoryBloc_Events{
  final MedicalExaminationEntity medicalExaminationEntity;
  MedicalHistoryBloc_SaveMedicalHistoryEvent({required this.medicalExaminationEntity});
  @override
  List<Object?> get props => [medicalExaminationEntity];

}