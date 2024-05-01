import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/requestChangeEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/postSurgicalTreatmentEntity.dart';

abstract class TreatmentBloc_Events extends Equatable {}

class TreatmentBloc_ConsumeImplantEvent extends TreatmentBloc_Events {
  final int id;

  TreatmentBloc_ConsumeImplantEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class TreatmentBloc_GetTreatmentPlanDataEvent extends TreatmentBloc_Events {
  final int id;

  TreatmentBloc_GetTreatmentPlanDataEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class TreatmentBloc_GetPostSurgicalTreatmentDataEvent extends TreatmentBloc_Events {
  final int id;

  TreatmentBloc_GetPostSurgicalTreatmentDataEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class TreatmentBloc_SavePostSurgicalTreatmentDataEvent extends TreatmentBloc_Events {
  final PostSurgicalTreatmentEntity data;

  TreatmentBloc_SavePostSurgicalTreatmentDataEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class TreatmentBloc_GetTreatmentPrices extends TreatmentBloc_Events {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TreatmentBloc_SaveTreatmentDetailsEvent extends TreatmentBloc_Events {
  final int id;
  final List<TreatmentDetailsEntity> data;
  final TreatmentPlanEntity generalData;

  TreatmentBloc_SaveTreatmentDetailsEvent({required this.id, required this.data, required this.generalData});

  @override
  List<Object?> get props => [id, data];
}

class TreatmentBloc_ConsumeItemByNameEvent extends TreatmentBloc_Events {
  final String name;
  final int count;

  TreatmentBloc_ConsumeItemByNameEvent({required this.name, required this.count});

  @override
  List<Object?> get props => [name, count];
}

class TreatmentBloc_ConsumeItemByIdEvent extends TreatmentBloc_Events {
  final int id;
  final int count;

  TreatmentBloc_ConsumeItemByIdEvent({required this.id, required this.count});

  @override
  List<Object?> get props => [id, count];
}

class TreatmentBloc_SwitchEditAndSummaryViewsEvent extends TreatmentBloc_Events {
  final List<TreatmentDetailsEntity> data;

  TreatmentBloc_SwitchEditAndSummaryViewsEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class TreatmentBloc_GetTacsEvent extends TreatmentBloc_Events {
  @override
  List<Object?> get props => [];
}

class TreatmentBloc_AcceptChangesEvent extends TreatmentBloc_Events {
  final RequestChangeEntity requestChangeEntity;
  final int patientId;

  TreatmentBloc_AcceptChangesEvent({
    required this.requestChangeEntity,
    required this.patientId,
  });

  @override
  List<Object?> get props => [requestChangeEntity];
}

class TreatmentBloc_UpdateTeethStatusEvent extends TreatmentBloc_Events {
  List<TreatmentDetailsEntity> teethData;
  final List<int> selectedTeeth;
  final List<int> selectedTreatmentItemId;
  final int patientId;
  final bool isSurgical;
  final BasicNameIdObjectEntity? patientsDoctor;

  TreatmentBloc_UpdateTeethStatusEvent({
    required this.teethData,
    required this.selectedTreatmentItemId,
    required this.selectedTeeth,
    required this.patientId,
    required this.isSurgical,
    required this.patientsDoctor,
  });

  @override
  List<Object?> get props => [
        selectedTreatmentItemId,
        selectedTeeth,
        teethData,
        patientId,
        isSurgical,
        patientsDoctor,
      ];
}
