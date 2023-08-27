import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/domain/entities/dentalExaminationEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../dentalExamination/domain/entities/dentalExaminationBaseEntity.dart';

abstract class NonSurgicalTreatmentBloc_States extends Equatable {}

class NonSurgicalTreatmentBlocInitialState extends NonSurgicalTreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class NonSurgicalTreatmentBloc_LoadingData extends NonSurgicalTreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class NonSurgicalTreatmentBloc_DataLoadedSuccessfully extends NonSurgicalTreatmentBloc_States {
  final NonSurgicalTreatmentEntity nonSurgicalTreatmentEntity;

  NonSurgicalTreatmentBloc_DataLoadedSuccessfully({required this.nonSurgicalTreatmentEntity});

  @override
  List<Object?> get props => [nonSurgicalTreatmentEntity];
}

class NonSurgicalTreatmentBloc_DataLoadingError extends NonSurgicalTreatmentBloc_States {
  final String message;

  NonSurgicalTreatmentBloc_DataLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NonSurgicalTreatmentBloc_LoadingAllData extends NonSurgicalTreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class NonSurgicalTreatmentBloc_DentalExaminationLoadingData extends NonSurgicalTreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class NonSurgicalTreatmentBloc_DentalExaminationDataLoadedSuccessfully extends NonSurgicalTreatmentBloc_States {
  final DentalExaminationBaseEntity dentalExaminationEntity;

  NonSurgicalTreatmentBloc_DentalExaminationDataLoadedSuccessfully({required this.dentalExaminationEntity});

  @override
  List<Object?> get props => [dentalExaminationEntity];
}

class NonSurgicalTreatmentBloc_DentalExaminationDataLoadingError extends NonSurgicalTreatmentBloc_States {
  final String message;

  NonSurgicalTreatmentBloc_DentalExaminationDataLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NonSurgicalTreatmentBloc_AllDataLoadedSuccessfully extends NonSurgicalTreatmentBloc_States {
  final NonSurgicalTreatmentEntity nonSurgicalTreatmentEntity;

  NonSurgicalTreatmentBloc_AllDataLoadedSuccessfully({required this.nonSurgicalTreatmentEntity});

  @override
  List<Object?> get props => [nonSurgicalTreatmentEntity];
}

class NonSurgicalTreatmentBloc_AllDataLoadingError extends NonSurgicalTreatmentBloc_States {
  final String message;

  NonSurgicalTreatmentBloc_AllDataLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NonSurgicalTreatmentBloc_CheckingTeethStatus extends NonSurgicalTreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class NonSurgicalTreatmentBloc_TeethStatusLoadedSuccessfully extends NonSurgicalTreatmentBloc_States {
  final List<int> status;

  NonSurgicalTreatmentBloc_TeethStatusLoadedSuccessfully({required this.status});

  @override
  List<Object?> get props => [status];
}

class NonSurgicalTreatmentBloc_CheckingTeethStatusError extends NonSurgicalTreatmentBloc_States {
  final String message;

  NonSurgicalTreatmentBloc_CheckingTeethStatusError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NonSurgicalTreatmentBloc_SavingData extends NonSurgicalTreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class NonSurgicalTreatmentBloc_DataSavedSuccessfully extends NonSurgicalTreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class NonSurgicalTreatmentBloc_DataSavingError extends NonSurgicalTreatmentBloc_States {
  final String message;

  NonSurgicalTreatmentBloc_DataSavingError({required this.message});

  @override
  List<Object?> get props => [message];
}
