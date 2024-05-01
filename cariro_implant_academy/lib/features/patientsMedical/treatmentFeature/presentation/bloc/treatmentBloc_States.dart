import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/requestChangeEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/postSurgicalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';
import 'package:equatable/equatable.dart';

abstract class TreatmentBloc_States extends Equatable {}

class TreatmentBloc_LoadingTreatmentDataState extends TreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class TreatmentBloc_LoadedTreatmentPlanDataSuccessfullyState extends TreatmentBloc_States {
  final List<TreatmentDetailsEntity> details;
  final List<TreatmentItemEntity> treatmentItems;
  final TreatmentPlanEntity data;

  TreatmentBloc_LoadedTreatmentPlanDataSuccessfullyState({required this.details, required this.data,required this.treatmentItems});

  @override
  List<Object?> get props => [details];
}

class TreatmentBloc_LoadedPostSurgicalTreatmentDataSuccessfullyState extends TreatmentBloc_States {
  final PostSurgicalTreatmentEntity data;

  TreatmentBloc_LoadedPostSurgicalTreatmentDataSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [data];
}

class TreatmentBloc_LoadingPostSurgicalTreatmentDataErrorState extends TreatmentBloc_States {
  final String message;

  TreatmentBloc_LoadingPostSurgicalTreatmentDataErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class TreatmentBloc_LoadingPostSurgicalTreatmentDataState extends TreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class TreatmentBloc_SavedPostSurgicalTreatmentDataSuccessfullyState extends TreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class TreatmentBloc_SavingPostSurgicalTreatmentDataErrorState extends TreatmentBloc_States {
  final String message;

  TreatmentBloc_SavingPostSurgicalTreatmentDataErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class TreatmentBloc_SavingPostSurgicalTreatmentDataState extends TreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class TreatmentBloc_LoadingTreatmentDataErrorState extends TreatmentBloc_States {
  final String message;

  TreatmentBloc_LoadingTreatmentDataErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class TreatmentBloc_ConsumingItemState extends TreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class TreatmentBloc_ConsumedItemSuccessfullyState extends TreatmentBloc_States {
  final String message;
  TreatmentBloc_ConsumedItemSuccessfullyState({this.message = ""});
  @override
  List<Object?> get props => [message];
}

class TreatmentBloc_ConsumeItemErrorState extends TreatmentBloc_States {
  final String message;

  TreatmentBloc_ConsumeItemErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class TreatmentBloc_SavingTreatmentDataState extends TreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class TreatmentBloc_SavedTreatmentDataSuccessfullyState extends TreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class TreatmentBloc_SavingTreatmentDataErrorState extends TreatmentBloc_States {
  final String message;

  TreatmentBloc_SavingTreatmentDataErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class TreatmentBloc_AcceptingChangesState extends TreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class TreatmentBloc_AcceptedChangesSuccessfullyState extends TreatmentBloc_States {
  final int id;
  final RequestChangeEntity? requestChangeEntity;
  TreatmentBloc_AcceptedChangesSuccessfullyState({required this.id, this.requestChangeEntity});
  @override
  List<Object?> get props => [id];
}

class TreatmentBloc_AcceptingChangesErrorState extends TreatmentBloc_States {
  final String message;

  TreatmentBloc_AcceptingChangesErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class TreatmentBloc_LoadedTreatmentPricesState extends TreatmentBloc_States {
  final TreatmentPricesEntity prices;

  TreatmentBloc_LoadedTreatmentPricesState({
    required this.prices,
  });

  @override
  List<Object?> get props => [prices];
}

class TreatmentBloc_ChangedViewState extends TreatmentBloc_States {
  final bool edit;
  final int total;

  TreatmentBloc_ChangedViewState({required this.edit, required this.total});

  @override
  List<Object?> get props => [edit, total];
}

class TreatmentBloc_UpdatedToothState extends TreatmentBloc_States {
  final List<TreatmentDetailsEntity> data;

  TreatmentBloc_UpdatedToothState({required this.data});
  @override
  List<Object?> get props => [data];
}

class TreatmentBloc_TeethSelectedState extends TreatmentBloc_States {
  @override
  List<Object?> get props => [];
}

class TreatmentBloc_SelectedStatusState extends TreatmentBloc_States {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class TreatmentBloc_ShowTickState extends TreatmentBloc_States {
  final bool showTick;
  TreatmentBloc_ShowTickState({required this.showTick});
  @override
  List<Object?> get props => [showTick];
}

class TreatmentBloc_UpdateAvailableTacsState extends TreatmentBloc_States {
  final int count;
  TreatmentBloc_UpdateAvailableTacsState({required this.count});
  @override
  List<Object?> get props => [count];
}

class TreatmentBloc_LoadedTacsState extends TreatmentBloc_States {
  final List<TacCompanyEntity> tacs;
  TreatmentBloc_LoadedTacsState({required this.tacs});
  @override
  List<Object?> get props => [tacs];
}
