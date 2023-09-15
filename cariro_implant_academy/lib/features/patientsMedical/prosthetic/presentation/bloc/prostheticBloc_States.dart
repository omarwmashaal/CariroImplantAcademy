import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/biteEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/diagnosticImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/scanApplianceEntity.dart';
import 'package:equatable/equatable.dart';

abstract class ProstheticBloc_States extends Equatable{}

class ProstheticBloc_LoadingDataState extends ProstheticBloc_States{
  @override
  List<Object?> get props => [];
}
class ProstheticBloc_DiagnosticDataLoadedSuccessfullyState extends ProstheticBloc_States{
  final ProstheticTreatmentEntity data;
  ProstheticBloc_DiagnosticDataLoadedSuccessfullyState({required this.data});
  @override
  List<Object?> get props => [data];
}
class ProstheticBloc_SingleAndBridgeDataLoadedSuccessfullyState extends ProstheticBloc_States{
  final ProstheticTreatmentEntity data;
  ProstheticBloc_SingleAndBridgeDataLoadedSuccessfullyState({required this.data});
  @override
  List<Object?> get props => [data];
}
class ProstheticBloc_FullArchDataLoadedSuccessfullyState extends ProstheticBloc_States{
  final ProstheticTreatmentEntity data;
  ProstheticBloc_FullArchDataLoadedSuccessfullyState({required this.data});
  @override
  List<Object?> get props => [data];
}
class ProstheticBloc_DataLoadingErrorState extends ProstheticBloc_States{
  final String message;
  ProstheticBloc_DataLoadingErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}
class ProstheticBloc_DataUpdatingErrorState extends ProstheticBloc_States{
  final String message;
  ProstheticBloc_DataUpdatingErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}
class ProstheticBloc_UpdateDiagnosticImpressionViewState extends ProstheticBloc_States{
  final List<DiagnosticImpressionEntity> data;
  ProstheticBloc_UpdateDiagnosticImpressionViewState({required this.data});
  @override
  List<Object?> get props => [data];
}
class ProstheticBloc_UpdateBiteViewState extends ProstheticBloc_States{
  final List<BiteEntity> data;
  ProstheticBloc_UpdateBiteViewState({required this.data});
  @override
  List<Object?> get props => [data];
}
class ProstheticBloc_UpdateScanApplianceViewState extends ProstheticBloc_States{
  final List<ScanApplianceEntity> data;
  ProstheticBloc_UpdateScanApplianceViewState({required this.data});
  @override
  List<Object?> get props => [data];
}