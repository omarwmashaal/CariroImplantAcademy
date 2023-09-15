import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/teethTreatmentPlan.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/surgicalTreatmentEntity.dart';

abstract class TreatmentBloc_Events extends Equatable {}

class TreatmentBloc_ConsumeImplantEvent extends TreatmentBloc_Events{
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
class TreatmentBloc_GetSurgicalTreatmentDataEvent extends TreatmentBloc_Events {
  final int id;

  TreatmentBloc_GetSurgicalTreatmentDataEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
class TreatmentBloc_GetTreatmentPrices extends TreatmentBloc_Events{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}
class TreatmentBloc_SaveTreatmentPlanDataEvent extends TreatmentBloc_Events {
  final int id;
  final List<TeethTreatmentPlanEntity> data;

  TreatmentBloc_SaveTreatmentPlanDataEvent({required this.id, required this.data});

  @override
  List<Object?> get props => [id, data];
}
class TreatmentBloc_SaveSurgicalTreatmentDataEvent extends TreatmentBloc_Events {
  final int id;
  final SurgicalTreatmentEntity data;

  TreatmentBloc_SaveSurgicalTreatmentDataEvent({required this.id, required this.data});

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
  final List<TeethTreatmentPlanEntity> data;
  TreatmentBloc_SwitchEditAndSummaryViewsEvent({required this.data});
  @override
  List<Object?> get props => [data];
}


class TreatmentBloc_GetTacsEvent extends TreatmentBloc_Events {
  @override
  List<Object?> get props => [];
}


class TreatmentBloc_UpdateTeethStatusEvent extends TreatmentBloc_Events {
  List<TeethTreatmentPlanEntity> teethData;
  final List<int> selectedTeeth;
  final List<String> selectedStatus;
  final int patientId;
  final bool isSurgical;

  TreatmentBloc_UpdateTeethStatusEvent({
    required this.teethData,
    required this.selectedStatus,
    required this.selectedTeeth,
    required this.patientId,
    required this.isSurgical,
  });

  @override
  List<Object?> get props => [
        selectedStatus,
        selectedTeeth,
        teethData,
        patientId,
        isSurgical,
      ];
}
