import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import 'package:equatable/equatable.dart';

abstract class AdvancedSearchBloc_States extends Equatable {}

class AdvancedSearchBloc_LoadingState extends AdvancedSearchBloc_States {
  @override
  List<Object?> get props => [];
}

class AdvancedSearchBloc_LoadingErrorState extends AdvancedSearchBloc_States {
  final String message;

  AdvancedSearchBloc_LoadingErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class AdvancedSearchBloc_LoadedPatientsSuccessfullyState extends AdvancedSearchBloc_States {
  final List<AdvancedPatientSearchEntity> data;

  AdvancedSearchBloc_LoadedPatientsSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [data];
}

class AdvancedSearchBloc_LoadedProstheticSuccessfullyState extends AdvancedSearchBloc_States {
  final List<ProstheticTreatmentEntity> data;

  AdvancedSearchBloc_LoadedProstheticSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [data];
}

class AdvancedSearchBloc_LoadedTreatmentsSuccessfullyState extends AdvancedSearchBloc_States {
  final List<AdvancedTreatmentSearchEntity> data;

  AdvancedSearchBloc_LoadedTreatmentsSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [data];
}
