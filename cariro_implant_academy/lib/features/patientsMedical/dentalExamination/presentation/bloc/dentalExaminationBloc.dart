import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/presentaion/bloc/dentalHistoryBloc_States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/useCases/getDentalExaminationUseCsae.dart';
import '../../domain/useCases/saveDentalExaminationUseCsae.dart';
import 'dentalExaminationBloc_Events.dart';
import 'dentalExaminationBloc_States.dart';

class DentalExaminationBloc extends Bloc<DentalExaminationBloc_Events, DentalExaminationBloc_States> {
  bool isInitialized = false;
  final GetDentalExaminationUseCase getDentalExaminationUseCase;
  final SaveDentalExaminationUseCase saveDentalExaminationUseCase;

  DentalExaminationBloc({
    required this.getDentalExaminationUseCase,
    required this.saveDentalExaminationUseCase,
  }) : super(DentalExaminationBloc_InitState()) {
    onChange(Change c){
      print("current ${c.currentState}");
      print("next ${c.nextState}");
    }
    on<DentalExaminationBloc_GetDataEvent>(
      (event, emit) async {
        emit(DentalExaminationBloc_LoadingDataState());
        final result = await getDentalExaminationUseCase(event.patientId);
        result.fold(
          (l) => emit(DentalExaminationBloc_ErrorState(message: l.message ?? "")),
          (r) => emit(DentalExaminationBloc_LoadedSuccessfullyState(dentalExaminationEntity: r)),
        );
      },
    );
    on<DentalExaminationBloc_SaveDataEvent>(
      (event, emit) async {
        emit(DentalExaminationBloc_SavingingDataState());
        final result = await saveDentalExaminationUseCase(event.dentalExaminationEntity);
        result.fold(
          (l) => emit(DentalExaminationBloc_ErrorState(message: l.message ?? "")),
          (r) => emit(DentalExaminationBloc_SavedDataSuccessfullyState()),
        );
      },
    );
  }
}
