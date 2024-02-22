import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/getComplicationsAfterProsthesisUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/getComplicationsAfterSurgeryUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/getSurgeryTeethForComplicationsUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/udpateComplicationsAfterProsthesisUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/udpateComplicationsAfterSurgeryUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/bloc/complicationsBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/presentation/bloc/complicationsBloc_States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplicationsBloc extends Bloc<ComplicationsBloc_Events, ComplicationsBloc_States> {
  final GetComplicationsAfterProsthesisUseCase getComplicationsAfterProsthesisUseCase;
  final GetComplicationsAfterSurgeryUseCase getComplicationsAfterSurgeryUseCase;
  final UpdateComplicationsAfterProsthesisUseCase updateComplicationsAfterProsthesisUseCase;
  final UpdateComplicationsAfterSurgeryUseCase updateComplicationsAfterSurgeryUseCase;
  final GetSurgeryTeethForComplicationsUseCase getSurgeryTeethForComplicationsUseCase;

  bool isInitialized = false;
  ComplicationsBloc({
    required this.updateComplicationsAfterSurgeryUseCase,
    required this.updateComplicationsAfterProsthesisUseCase,
    required this.getComplicationsAfterSurgeryUseCase,
    required this.getComplicationsAfterProsthesisUseCase,
    required this.getSurgeryTeethForComplicationsUseCase,
  }) : super(ComplicationsBloc_InitialState()) {
    on<ComplicationsBloc_GetComplicationsAfterProsthesisEvent>(
      (event, emit) async {
        emit(ComplicationsBloc_LoadingComplicationsAfterProsthesisState());
        final result = await getComplicationsAfterProsthesisUseCase(event.id);
        result.fold(
          (l) => emit(ComplicationsBloc_LoadingComplicationsAfterProsthesisErrorState(message: l.message ?? "")),
          (r) => emit(ComplicationsBloc_LoadedComplicationsAfterProsthesisSuccessfullyState(data: r)),
        );
      },
    );

    on<ComplicationsBloc_GetComplicationsAfterSurgeryEvent>(
      (event, emit) async {
        emit(ComplicationsBloc_LoadingComplicationsAfterSurgeryState());
        final result = await getComplicationsAfterSurgeryUseCase(event.id);
        List<ComplicationsAfterSurgeryEntity> complications = [];
        result.fold(
          (l) => emit(ComplicationsBloc_LoadingComplicationsAfterSurgeryErrorState(message: l.message ?? "")),
          (r) => complications = r,
        );
        if (result.isRight()) {
          var teeth = await getSurgeryTeethForComplicationsUseCase(event.id);
          teeth.fold(
            (l) => emit(ComplicationsBloc_LoadingComplicationsAfterSurgeryErrorState(message: l.message ?? "")),
            (r) => emit(ComplicationsBloc_LoadedComplicationsAfterSurgerySuccessfullyState(data: complications, teeth: r)),
          );
        }
      },
    );
    on<ComplicationsBloc_UpdateComplicationsAfterSurgeryEvent>(
      (event, emit) async {
        emit(ComplicationsBloc_UpdatingComplicationsAfterSurgeryState());
        final result = await updateComplicationsAfterSurgeryUseCase(event.data);
        result.fold(
          (l) => emit(ComplicationsBloc_UpdatingComplicationsAfterSurgeryErrorState(message: l.message ?? "")),
          (r) => emit(ComplicationsBloc_UpdatedComplicationsAfterSurgerySuccessfullyState()),
        );
      },
    );
    on<ComplicationsBloc_UpdateComplicationsAfterProsthesisEvent>(
      (event, emit) async {
        emit(ComplicationsBloc_UpdatingComplicationsAfterProsthesisState());
        final result = await updateComplicationsAfterProsthesisUseCase(event.data);
        result.fold(
          (l) => emit(ComplicationsBloc_UpdatingComplicationsAfterProsthesisErrorState(message: l.message ?? "")),
          (r) => emit(ComplicationsBloc_UpdatedComplicationsAfterProsthesisSuccessfullyState()),
        );
      },
    );
  }
}
