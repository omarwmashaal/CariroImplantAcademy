import 'package:equatable/equatable.dart';

abstract class PatientVisitsBloc_Events extends Equatable{}

class PatientVisitsBloc_GetVisitsEvent extends PatientVisitsBloc_Events{
  final int? id;
  PatientVisitsBloc_GetVisitsEvent({this.id});
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
  final int id;
  PatientVisitsBloc_PatientEntersClinicEvent({required this.id});
  @override
  List<Object?> get props => [id];
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