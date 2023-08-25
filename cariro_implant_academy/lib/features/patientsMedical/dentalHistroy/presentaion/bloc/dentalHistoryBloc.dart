import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/presentaion/bloc/dentalHistoryBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/presentaion/bloc/dentalHistoryBloc_States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/useCases/getDentalHistoryUseCsae.dart';
import '../../domain/useCases/saveDentalHistoryUseCsae.dart';

class DentalHistoryBloc extends Bloc<DentalHistoryBloc_Events, DentalHistoryBloc_States> {
  final GetDentalHistoryUseCase getDentalHistoryUseCase;
  final SaveDentalHistoryUseCase saveDentalHistoryUseCase;
  bool isInitialized = false;

  DentalHistoryBloc({
    required this.getDentalHistoryUseCase,
    required this.saveDentalHistoryUseCase,
  }) : super(DentalHistoryBloc_InitialState()) {
    on<DentalHistoryBloc_GetDentalHistoryEvent>(
      (event, emit) async {
        emit(DentalHistoryBloc_LoadingDataState());
        final result = await getDentalHistoryUseCase(event.patientId);
        print(result);
        result.fold(
          (l) => emit(DentalHistoryBloc_ErrorState(message: l.message ?? "")),
          (r) => emit(DentalHistoryBloc_DataLoadedSuccessfullyState(dentalHistoryEntity: r)),
        );
      },
    );

    on<DentalHistoryBloc_SaveDentalHistoryEvent>((event, emit) async {
      emit(DentalHistoryBloc_SavingDataState());
      print("got here");
      final result = await saveDentalHistoryUseCase(event.dentalHistoryEntity);
      result.fold(
            (l) {
          print(l);
          emit(DentalHistoryBloc_ErrorState(message: l.message ?? ""));
        },
            (r) {
          print(r);
          emit(DentalHistoryBloc_SavedDataSuccessfullyState());
        },
      );
    },);



  }
}
