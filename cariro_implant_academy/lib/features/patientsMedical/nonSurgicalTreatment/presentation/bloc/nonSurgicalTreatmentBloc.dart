import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc_States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '';
import '../../../dentalExamination/domain/useCases/getDentalExaminationUseCsae.dart';
import '../../../dentalExamination/domain/useCases/saveDentalExaminationUseCsae.dart';
import '../../domain/usecases/checkNonSurgicalTreatementTeethStatusUseCase.dart';
import '../../domain/usecases/getAllNonSurgicalTreatmentsUseCase.dart';
import '../../domain/usecases/getNonSurgicalTreatmentUseCase.dart';
import '../../domain/usecases/saveNonSurgicalTreatmentUseCase.dart';

class NonSurgicalTreatmentBloc extends Bloc<NonSurgicalTreatmentBloc_Events, NonSurgicalTreatmentBloc_States> {
  final SaveNonSurgicalTreatmentUseCase saveNonSurgicalTreatmentUseCase;
  final GetAllNonSurgicalTreatmentsUseCase getAllNonSurgicalTreatmentsUseCase;
  final GetNonSurgicalTreatmentUseCase getNonSurgicalTreatmentUseCase;
  final CheckNonSurgicalTreatmentTeethStatusUseCase checkNonSurgicalTreatmentTeethStatusUseCase;
  final GetDentalExaminationUseCase getDentalExaminationUseCase;
  final SaveDentalExaminationUseCase saveDentalExaminationUseCase;
  bool isInitialized = false;

  NonSurgicalTreatmentBloc({
    required this.checkNonSurgicalTreatmentTeethStatusUseCase,
    required this.getNonSurgicalTreatmentUseCase,
    required this.getAllNonSurgicalTreatmentsUseCase,
    required this.saveNonSurgicalTreatmentUseCase,
    required this.getDentalExaminationUseCase,
    required this.saveDentalExaminationUseCase,
  }) : super(NonSurgicalTreatmentBlocInitialState()) {
    on<NonSurgicalTreatmentBloc_GetDataEvent>(
      (event, emit) async {

        String treatment = "";
        emit(NonSurgicalTreatmentBloc_LoadingData());
        final result = await getNonSurgicalTreatmentUseCase(event.id);
        result.fold(
          (l) => emit(NonSurgicalTreatmentBloc_DataLoadingError(message: l.message ?? "")),
          (r) {
            emit(NonSurgicalTreatmentBloc_DataLoadedSuccessfully(nonSurgicalTreatmentEntity: r));
            treatment = r.treatment??"";
          },
        );
        if (result.isRight()) {
          emit(NonSurgicalTreatmentBloc_DentalExaminationLoadingData());
          final result_ = await getDentalExaminationUseCase(event.id);
          result_.fold(
            (l) => emit(NonSurgicalTreatmentBloc_DentalExaminationDataLoadingError(message: l.message ?? "")),
            (r) => emit(NonSurgicalTreatmentBloc_DentalExaminationDataLoadedSuccessfully(dentalExaminationEntity: r)),
          );


          if (result_.isRight()) {
            emit(NonSurgicalTreatmentBloc_CheckingTeethStatus());
            final r_ = await checkNonSurgicalTreatmentTeethStatusUseCase(treatment == null || treatment == "" ? "nodata" : treatment!);
            r_.fold(
              (l) => emit(NonSurgicalTreatmentBloc_CheckingTeethStatusError(message: l.message ?? "")),
              (r) => emit(NonSurgicalTreatmentBloc_TeethStatusLoadedSuccessfully(status: r)),
            );
          }
        }
      },
    );
    on<NonSurgicalTreatmentBloc_CheckTeethStatusEvent>(
      (event, emit) async {
        emit(NonSurgicalTreatmentBloc_CheckingTeethStatus());
        final result = await checkNonSurgicalTreatmentTeethStatusUseCase(event.treatment == null || event.treatment == "" ? "nodata" : event.treatment);
        result.fold(
          (l) => emit(NonSurgicalTreatmentBloc_CheckingTeethStatusError(message: l.message ?? "")),
          (r) => emit(NonSurgicalTreatmentBloc_TeethStatusLoadedSuccessfully(status: r)),
        );
      },
    );
    on<NonSurgicalTreatmentBloc_SaveDataEvent>(
      (event, emit) async {
        emit(NonSurgicalTreatmentBloc_SavingData());
        final result = await saveNonSurgicalTreatmentUseCase(SaveNonSurgicalTreatmentParams(
          patientId: event.patientId,
          nonSurgicalTreatmentEntity: event.nonSurgicalTreatmentEntity,
        ));
        result.fold(
          (l) => emit(NonSurgicalTreatmentBloc_DataSavingError(message: l.message ?? "")),
          (r) async {
            // emit(NonSurgicalTreatmentBloc_DataSavedSuccessfully());

            await saveDentalExaminationUseCase(event.dentalExaminationEntity).then((value) {
              value.fold((l) => emit(NonSurgicalTreatmentBloc_DataSavingError(message: l.message ?? "")),
                  (r) => emit(NonSurgicalTreatmentBloc_DataSavedSuccessfully()));
            });
          },
        );
      },
    );
  }
}
