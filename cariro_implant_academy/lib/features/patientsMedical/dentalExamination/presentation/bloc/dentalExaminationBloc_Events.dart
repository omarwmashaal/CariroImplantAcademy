import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/domain/entities/dentalExaminationEntity.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/dentalExaminationBaseEntity.dart';
import 'bloc_constants.dart';

abstract class DentalExaminationBloc_Events extends Equatable {}

class DentalExaminationBloc_GetDataEvent extends DentalExaminationBloc_Events {
  final int patientId;

  DentalExaminationBloc_GetDataEvent({required this.patientId});

  @override
  // TODO: implement props
  List<Object?> get props => [patientId];
}

class DentalExaminationBloc_SaveDataEvent extends DentalExaminationBloc_Events {
  final DentalExaminationBaseEntity dentalExaminationEntity;

  DentalExaminationBloc_SaveDataEvent({required this.dentalExaminationEntity});

  @override
  // TODO: implement props
  List<Object?> get props => [dentalExaminationEntity];
}

