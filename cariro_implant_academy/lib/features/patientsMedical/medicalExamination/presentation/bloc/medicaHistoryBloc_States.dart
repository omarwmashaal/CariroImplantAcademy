import 'package:equatable/equatable.dart';

import '../../domain/entities/medicalExaminationEntity.dart';

abstract class MedicalHistoryBloc_States extends Equatable{}


class MedicalHistoryBloc_InitialState extends MedicalHistoryBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}class MedicalHistoryBloc_SavedSuccessfully extends MedicalHistoryBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class MedicalHistoryBloc_ErrorState extends MedicalHistoryBloc_States{
  final String message;
  MedicalHistoryBloc_ErrorState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];

}
class MedicalHistoryBloc_LoadingState extends MedicalHistoryBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
// Medical History
class MedicalHistoryBloc_DataLoaded extends MedicalHistoryBloc_States {
  final MedicalExaminationEntity medicalExaminationEntity;

  MedicalHistoryBloc_DataLoaded({required this.medicalExaminationEntity});

  @override
  // TODO: implement props
  List<Object?> get props => [medicalExaminationEntity];
}

class MedicalHistoryBloc_ChangedHBA1CState extends MedicalHistoryBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [identityHashCode(this)];
}