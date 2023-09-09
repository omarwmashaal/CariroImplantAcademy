import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/teethTreatmentPlan.dart';
import 'package:equatable/equatable.dart';

abstract class TreatmentPlanBloc_Events extends Equatable {}

class TreatmentPlanBloc_GetDataEvent extends TreatmentPlanBloc_Events {
  final int id;

  TreatmentPlanBloc_GetDataEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
class TreatmentPlanBloc_GetTreatmentPrices extends TreatmentPlanBloc_Events{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}
class TreatmentPlanBloc_SaveDataEvent extends TreatmentPlanBloc_Events {
  final int id;
  final List<TeethTreatmentPlanEntity> data;

  TreatmentPlanBloc_SaveDataEvent({required this.id, required this.data});

  @override
  List<Object?> get props => [id, data];
}

class TreatmentPlanBloc_SwitchEditAndSummaryViewsEvent extends TreatmentPlanBloc_Events {
  final List<TeethTreatmentPlanEntity> data;
  TreatmentPlanBloc_SwitchEditAndSummaryViewsEvent({required this.data});
  @override
  List<Object?> get props => [data];
}

class TreatmentPlanBloc_UpdateTeethStatusEvent extends TreatmentPlanBloc_Events {
  List<TeethTreatmentPlanEntity> teethData;
  final List<int> selectedTeeth;
  final List<String> selectedStatus;
  final int patientId;
  final bool isSurgical;

  TreatmentPlanBloc_UpdateTeethStatusEvent({
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
