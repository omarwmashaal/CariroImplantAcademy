import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/visitEntity.dart';

abstract class PatientVisitsBloc_States extends Equatable{}

class PatientVisitsBloc_LoadingVisitsState extends PatientVisitsBloc_States{
  @override
  List<Object?> get props => [];
}
class PatientVisitsBloc_LoadedVisitsSuccessfullyState extends PatientVisitsBloc_States{
  final List<VisitEntity> visits;
  PatientVisitsBloc_LoadedVisitsSuccessfullyState({required this.visits});
  @override
  List<Object?> get props => [];
}
class PatientVisitsBloc_LoadedPatientDataSuccessfullyState extends PatientVisitsBloc_States{
  final PatientInfoEntity data;
  PatientVisitsBloc_LoadedPatientDataSuccessfullyState({required this.data});
  @override
  List<Object?> get props => [data];
}
class PatientVisitsBloc_VisitProcedureSuccessState extends PatientVisitsBloc_States{
  @override
  List<Object?> get props => [identityHashCode(this)];
}
class PatientVisitsBloc_LoadingErrorState extends PatientVisitsBloc_States{
  final String message;
  PatientVisitsBloc_LoadingErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}
class PatientVisitsBloc_VisitProcedureErrorState extends PatientVisitsBloc_States{
  final String message;
  PatientVisitsBloc_VisitProcedureErrorState({required this.message});
  @override
  List<Object?> get props => [message,identityHashCode(this)];
}