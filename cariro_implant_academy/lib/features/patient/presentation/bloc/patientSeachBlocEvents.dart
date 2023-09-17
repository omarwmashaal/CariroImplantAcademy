import 'package:equatable/equatable.dart';

abstract class PatientSearchBloc_Events extends Equatable {
  late bool myPatients;
  PatientSearchBloc_Events({this.myPatients=false});
}

class PatientSearchEvent extends PatientSearchBloc_Events {
  final String? query;
  final bool myPatients;
  PatientSearchEvent({this.query,required this.myPatients }) : super(myPatients: myPatients);

  @override
  // TODO: implement props
  List<Object?> get props => [this.query];
}


class PatientSearchFilterChangedEvent extends PatientSearchBloc_Events {
  final String filter;
  PatientSearchFilterChangedEvent(this.filter);
  @override
  // TODO: implement props
  List<Object?> get props => [this.filter];
}
enum SearchPatientFilterEnum { byName, byPhone, all }
