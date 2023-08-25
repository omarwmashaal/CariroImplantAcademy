import 'package:equatable/equatable.dart';

abstract class PatientSearchBloc_Events extends Equatable {
  late bool myPatients;
  PatientSearchBloc_Events({this.myPatients=false});
}

class PatientSearchEvent extends PatientSearchBloc_Events {
  final String? query;
  PatientSearchEvent({this.query}) : super(myPatients: false);

  @override
  // TODO: implement props
  List<Object?> get props => [this.query];
}

class MyPatientSearchEvent extends PatientSearchBloc_Events {
  final String query;
  final SearchPatientFilterEnum filter;

  MyPatientSearchEvent({required this.query, required this.filter}) : super(myPatients: true);

  @override
  // TODO: implement props
  List<Object?> get props => [this.filter, this.query, this.myPatients];
}
class PatientSearchFilterChangedEvent extends PatientSearchBloc_Events {
  final String filter;
  PatientSearchFilterChangedEvent(this.filter);
  @override
  // TODO: implement props
  List<Object?> get props => [this.filter];
}
enum SearchPatientFilterEnum { byName, byPhone, all }
