import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/teethTreatmentPlan.dart';

abstract class TreatmentPlanBloc_States extends Equatable {}

class TreatmentPlanBloc_LoadingTreatmentPlanDataState extends TreatmentPlanBloc_States {
  @override
  List<Object?> get props => [];
}

class TreatmentPlanBloc_LoadedTreatmentPlanDataSuccessfullyState extends TreatmentPlanBloc_States {
  final TreatmentPlanEntity data;

  TreatmentPlanBloc_LoadedTreatmentPlanDataSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [data];
}

class TreatmentPlanBloc_LoadingTreatmentPlanDataErrorState extends TreatmentPlanBloc_States {
  final String message;

  TreatmentPlanBloc_LoadingTreatmentPlanDataErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class TreatmentPlanBloc_SavingTreatmentPlanDataState extends TreatmentPlanBloc_States {
  @override
  List<Object?> get props => [];
}

class TreatmentPlanBloc_SavedTreatmentPlanDataSuccessfullyState extends TreatmentPlanBloc_States {

  @override
  List<Object?> get props => [];
}

class TreatmentPlanBloc_SavingTreatmentPlanDataErrorState extends TreatmentPlanBloc_States {
  final String message;

  TreatmentPlanBloc_SavingTreatmentPlanDataErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class TreatmentPlanBloc_LoadedTreatmentPricesState extends TreatmentPlanBloc_States {
  final TreatmentPricesEntity prices;

  TreatmentPlanBloc_LoadedTreatmentPricesState({
    required this.prices,
  });

  @override
  List<Object?> get props => [prices];
}

class TreatmentPlanBloc_ChangedViewState extends TreatmentPlanBloc_States {
  final bool edit;
  final int total;

  TreatmentPlanBloc_ChangedViewState({required this.edit, required this.total});

  @override
  List<Object?> get props => [edit, total];
}

class TreatmentPlanBloc_UpdatedToothState extends TreatmentPlanBloc_States {
  final List<TeethTreatmentPlanEntity> data;

  TreatmentPlanBloc_UpdatedToothState({required this.data});
  @override
  List<Object?> get props => [data];
}


class TreatmentPlanBloc_TeethSelectedState extends TreatmentPlanBloc_States {
  @override
  List<Object?> get props => [];
}

class TreatmentPlanBloc_SelectedStatusState extends TreatmentPlanBloc_States {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
class TreatmentPlanBloc_ShowTickState extends TreatmentPlanBloc_States {
  final bool showTick;
  TreatmentPlanBloc_ShowTickState({required this.showTick});
  @override
  List<Object?> get props => [showTick];
}
