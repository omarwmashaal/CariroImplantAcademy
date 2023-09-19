import 'package:cariro_implant_academy/features/patient/domain/entities/complainEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:equatable/equatable.dart';

abstract class ComplainsBloc_States extends Equatable {}

class ComplainsBloc_LoadingDataState extends ComplainsBloc_States {
  @override
  List<Object?> get props => [];
}

class ComplainsBloc_ProcessingDataState extends ComplainsBloc_States {
  @override
  List<Object?> get props => [];
}

class ComplainsBloc_LoadingDataErrorState extends ComplainsBloc_States {
  final String message;

  ComplainsBloc_LoadingDataErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ComplainsBloc_ProcessingDataErrorState extends ComplainsBloc_States {
  final String message;

  ComplainsBloc_ProcessingDataErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ComplainsBloc_ProcessingDataSuccessState extends ComplainsBloc_States {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class ComplainsBloc_LoadingDataSuccessState extends ComplainsBloc_States {
  final List<ComplainsEntity> complains;
  final PatientInfoEntity? patient;
  final List<NonSurgicalTreatmentEntity>? nonSurgicalTreatments;

  ComplainsBloc_LoadingDataSuccessState({
    required this.complains,
    this.patient,
    this.nonSurgicalTreatments,
  });

  @override
  List<Object?> get props => [
        complains,
        patient,
        nonSurgicalTreatments,
        identityHashCode(this),
      ];
}
