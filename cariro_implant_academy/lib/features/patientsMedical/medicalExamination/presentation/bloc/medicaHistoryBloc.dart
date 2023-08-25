import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/domain/usecases/getMedicalExaminationUseCsae.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/presentation/bloc/medicaHistoryBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/presentation/bloc/medicaHistoryBloc_States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/saveMedicalExaminationUseCsae.dart';

class MedicalHistoryBloc extends Bloc<MedicalHistoryBloc_Events, MedicalHistoryBloc_States> {
  final GetMedicalExaminationUseCase getMedicalExaminationUseCase;
  final SaveMedicalExaminationUseCase saveMedicalExaminationUseCase;
  bool isInitialized = false;
  MedicalHistoryBloc({
    required this.getMedicalExaminationUseCase,
    required this.saveMedicalExaminationUseCase,
  }) : super(MedicalHistoryBloc_InitialState()) {
    on<MedicalHistoryBloc_GetMedicalHistoryEvent>(
      (event, emit) async {
        emit(MedicalHistoryBloc_LoadingState());
        final result = await getMedicalExaminationUseCase(event.id);
        result.fold(
          (l) => emit(MedicalHistoryBloc_ErrorState(message: l.message ?? "")),
          (r) => emit(MedicalHistoryBloc_DataLoaded(medicalExaminationEntity: r)),
        );
      },
    );

    on<MedicalHistoryBloc_SaveMedicalHistoryEvent>(
      (event, emit) async {
        emit(MedicalHistoryBloc_LoadingState());
        print("got here");
        final result = await saveMedicalExaminationUseCase(event.medicalExaminationEntity);
        result.fold(
          (l) {
            print(l);
            emit(MedicalHistoryBloc_ErrorState(message: l.message ?? ""));
          },
          (r) {
            print(r);
            emit(MedicalHistoryBloc_SavedSuccessfully());
          },
        );
      },
    );
  }
}
