import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticStepEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/usecases/updatePatientProstheticTreatmentDiagnosticUseCase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/prostheticFinalEntity.dart';

abstract class ProstheticBloc_Event extends Equatable {}

class ProstheticBloc_GetPatientProstheticTreatmentDiagnosticEvent extends ProstheticBloc_Event {
  final int id;
  ProstheticBloc_GetPatientProstheticTreatmentDiagnosticEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class ProstheticBloc_GetPatientProstheticTreatmentFinalProthesisSingleBridgeEvent extends ProstheticBloc_Event {
  final int id;
  ProstheticBloc_GetPatientProstheticTreatmentFinalProthesisSingleBridgeEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class ProstheticBloc_GetPatientProstheticTreatmentFinalProthesisFullArchEvent extends ProstheticBloc_Event {
  final int id;
  ProstheticBloc_GetPatientProstheticTreatmentFinalProthesisFullArchEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class ProstheticBloc_UpdatePatientProstheticTreatmentDiagnosticEvent extends ProstheticBloc_Event {
  final UpdateProsthParams data;
  ProstheticBloc_UpdatePatientProstheticTreatmentDiagnosticEvent({required this.data});
  @override
  List<Object?> get props => [data];
}

class ProstheticBloc_UpdatePatientProstheticTreatmentFinalProthesisSingleBridgeEvent extends ProstheticBloc_Event {
  final UpdateProsthParams  data;
  ProstheticBloc_UpdatePatientProstheticTreatmentFinalProthesisSingleBridgeEvent({required this.data});
  @override
  List<Object?> get props => [data];
}

class ProstheticBloc_UpdatePatientProstheticTreatmentFinalProthesisFullArchEvent extends ProstheticBloc_Event {
  final UpdateProsthParams data;
  ProstheticBloc_UpdatePatientProstheticTreatmentFinalProthesisFullArchEvent({required this.data});
  @override
  List<Object?> get props => [data];
}


