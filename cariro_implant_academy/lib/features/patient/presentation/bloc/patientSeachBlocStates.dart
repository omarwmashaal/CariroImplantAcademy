import 'package:equatable/equatable.dart';

import '../../domain/entities/patientInfoEntity.dart';

abstract class PatientSearchBloc_States extends Equatable {}

class LoadingPatientSearchState extends PatientSearchBloc_States {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedPatientSearchState extends PatientSearchBloc_States {
  final List<PatientInfoEntity> result;

  LoadedPatientSearchState(this.result);

  @override
  // TODO: implement props
  List<Object?> get props => [this.result];
}


class InitialPatientSearchState extends PatientSearchBloc_States {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoadingError extends PatientSearchBloc_States {
  final String message;
  LoadingError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
