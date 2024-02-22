import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/usecases/getPatientProstheticTreatmentDiagnosticUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/usecases/getPatientProstheticTreatmentFinalProthesisFullArchUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/usecases/getPatientProstheticTreatmentFinalProthesisSingleBridge.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/usecases/updatePatientProstheticTreatmentDiagnosticUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/usecases/updatePatientProstheticTreatmentFinalProthesisFullArchUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/usecases/updatePatientProstheticTreatmentFinalProthesisSingleBridgeUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/presentation/bloc/prostheticBloc_States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProstheticBloc extends Bloc<ProstheticBloc_Event, ProstheticBloc_States> {
  final GetPatientProstheticTreatmentDiagnosticUseCase getPatientProstheticTreatmentDiagnosticUseCase;
  final GetPatientProstheticTreatmentFinalProthesisFullArchUseCase getPatientProstheticTreatmentFinalProthesisFullArchUseCase;
  final GetPatientProstheticTreatmentFinalProthesisSingleBridgeUseCase getPatientProstheticTreatmentFinalProthesisSingleBridgeUseCase;
  final UpdatePatientProstheticTreatmentDiagnosticUseCase updatePatientProstheticTreatmentDiagnosticUseCase;
  final UpdatePatientProstheticTreatmentFinalProthesisFullArchUseCase updatePatientProstheticTreatmentFinalProthesisFullArchUseCase;
  final UpdatePatientProstheticTreatmentFinalProthesisSingleBridgeUseCase updatePatientProstheticTreatmentFinalProthesisSingleBridgeUseCase;

  ProstheticBloc({
    required this.getPatientProstheticTreatmentFinalProthesisSingleBridgeUseCase,
    required this.getPatientProstheticTreatmentFinalProthesisFullArchUseCase,
    required this.getPatientProstheticTreatmentDiagnosticUseCase,
    required this.updatePatientProstheticTreatmentFinalProthesisSingleBridgeUseCase,
    required this.updatePatientProstheticTreatmentFinalProthesisFullArchUseCase,
    required this.updatePatientProstheticTreatmentDiagnosticUseCase,
  }) : super(ProstheticBloc_InitState()) {

    on<ProstheticBloc_GetPatientProstheticTreatmentDiagnosticEvent>(
      (event, emit) async {
        emit(ProstheticBloc_LoadingDataState());
        final result = await getPatientProstheticTreatmentDiagnosticUseCase(event.id);
        result.fold(
          (l) => emit(ProstheticBloc_DataLoadingErrorState(message: l.message ?? "")),
          (r) => emit(ProstheticBloc_DiagnosticDataLoadedSuccessfullyState(data: r)),
        );
      },
    );
    on<ProstheticBloc_GetPatientProstheticTreatmentFinalProthesisSingleBridgeEvent>(
      (event, emit) async {
        emit(ProstheticBloc_LoadingDataState());
        final result = await getPatientProstheticTreatmentFinalProthesisSingleBridgeUseCase(event.id);
        result.fold(
          (l) => emit(ProstheticBloc_DataLoadingErrorState(message: l.message ?? "")),
          (r) => emit(ProstheticBloc_SingleAndBridgeDataLoadedSuccessfullyState(data: r),),
        );
      },
    );
    on<ProstheticBloc_GetPatientProstheticTreatmentFinalProthesisFullArchEvent>(
      (event, emit) async {
        emit(ProstheticBloc_LoadingDataState());
        final result = await getPatientProstheticTreatmentFinalProthesisFullArchUseCase(event.id);
        result.fold(
          (l) => emit(ProstheticBloc_DataLoadingErrorState(message: l.message ?? "")),
          (r) => emit(ProstheticBloc_FullArchDataLoadedSuccessfullyState(data: r)),
        );
      },
    );
    on<ProstheticBloc_UpdatePatientProstheticTreatmentDiagnosticEvent>(
      (event, emit) async {
        emit(ProstheticBloc_UpdatingProstheticDiagnosticState());
        final result = await updatePatientProstheticTreatmentDiagnosticUseCase(event.data);
        result.fold(
          (l) => emit(ProstheticBloc_DataUpdatingErrorState(message: l.message ?? "")),
          (r) => emit(ProstheticBloc_UpdatedProstheticDiagnosticSuccessfullyState()),
        );
      },
    );
    on<ProstheticBloc_UpdatePatientProstheticTreatmentFinalProthesisFullArchEvent>(
      (event, emit) async {
        emit(ProstheticBloc_UpdatingProstheticFullArchState());
        final result = await updatePatientProstheticTreatmentFinalProthesisFullArchUseCase(event.data);
        result.fold(
          (l) => emit(ProstheticBloc_DataUpdatingErrorState(message: l.message ?? "")),
          (r) => emit(ProstheticBloc_UpdatedProstheticFullArchSuccessfullyState()),
        );
      },
    );
    on<ProstheticBloc_UpdatePatientProstheticTreatmentFinalProthesisSingleBridgeEvent>(
      (event, emit) async {
        emit(ProstheticBloc_UpdatingProstheticSinlgeBridgeState());
        final result = await updatePatientProstheticTreatmentFinalProthesisSingleBridgeUseCase(event.data);
        result.fold(
          (l) => emit(ProstheticBloc_DataUpdatingErrorState(message: l.message ?? "")),
          (r) => emit(ProstheticBloc_UpdatedProstheticSinlgeBridgeSuccessfullyState()),
        );
      },
    );
  }
}
