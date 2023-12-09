import 'package:cariro_implant_academy/features/patient/domain/usecases/patientEntersClinicUseCase.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/updateVisit.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/getVisitsUseCase.dart';

abstract class PatientVisitsBloc_Events extends Equatable{}

class PatientVisitsBloc_GetVisitsEvent extends PatientVisitsBloc_Events{
  final GetVisitsParams params;
  PatientVisitsBloc_GetVisitsEvent({required this.params});
  @override
  List<Object?> get props => [];

}
class PatientVisitsBloc_UpdateVisitsEvent extends PatientVisitsBloc_Events{
  final UpdateVisitParams params;
  PatientVisitsBloc_UpdateVisitsEvent({required this.params});
  @override
  List<Object?> get props => [];

}
class PatientVisitsBloc_PatientVisitsEvent extends PatientVisitsBloc_Events{
  final int id;
  PatientVisitsBloc_PatientVisitsEvent({required this.id});
  @override
  List<Object?> get props => [id];
}
class PatientVisitsBloc_PatientEntersClinicEvent extends PatientVisitsBloc_Events{
  final PatientEntersClinicParams params;
  PatientVisitsBloc_PatientEntersClinicEvent({required this.params});
  @override
  List<Object?> get props => [params];
}
class PatientVisitsBloc_PatientLeavesClinicEvent extends PatientVisitsBloc_Events{
  final int id;
  PatientVisitsBloc_PatientLeavesClinicEvent({required this.id});
  @override
  List<Object?> get props => [id];
}
class PatientVisitsBloc_GetPatientDataEvent extends PatientVisitsBloc_Events{
  final int id;
  PatientVisitsBloc_GetPatientDataEvent({required this.id});
  @override
  List<Object?> get props => [id];
}