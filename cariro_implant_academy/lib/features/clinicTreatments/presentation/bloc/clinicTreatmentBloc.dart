import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicImplantEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/orthoTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/pedoEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/restorationEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/rootCanalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/tmdEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/useCases/getTreatmentsUseCase.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/useCases/updateTreatmentsUseCase.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClinicTreatmentBloc extends Bloc<ClinicTreatmentBloc_Events, ClinicTreatmentBloc_States> {
  final GetClinicTreatmentsUseCase getClinicTreatmentsUseCase;
  final UpdateClinicTreatmentsUseCase updateClinicTreatmentsUseCase;

  ClinicTreatmentBloc({
    required this.updateClinicTreatmentsUseCase,
    required this.getClinicTreatmentsUseCase,
  }) : super(ClinicTreatmentBloc_InitState()) {

    on<ClinicTreatmentBloc_LoadTreatmentsEvent>(
      (event, emit) async {
        emit(ClinicTreatmentBloc_LoadingTreatmentsState());
        var result = await getClinicTreatmentsUseCase(event.id);
        result.fold(
          (l) => emit(ClinicTreatmentBloc_LoadingTreatmentsErrorState(message: l.message ?? "")),
          (r) => emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: r)),
        );
      },
    );



    on<ClinicTreatmentBloc_UpdateTreatmentsEvent>(
      (event, emit) async {
        emit(ClinicTreatmentBloc_UpdatingTreatmentsState());
        var result = await updateClinicTreatmentsUseCase(event.data);
        result.fold(
          (l) => emit(ClinicTreatmentBloc_UpdatingTreatmentsErrorState(message: l.message ?? "")),
          (r) => emit(ClinicTreatmentBloc_UpdatedTreatmentsSuccessfullyState()),
        );
      },
    );

    on<ClinicTreatmentBloc_BuildPageEvent>(
      (event, emit) {
        emit(ClinicTreatmentBloc_LoadingTreatmentsState());
        switch (event.selectedTreatmentEnum) {
          case SelectedTreatmentEnum.restoration:
            {
              for (var tooth in event.selectedTeeth) {
                if (event.data.restorations!.where((element) => element.tooth == tooth).toList().isEmpty)
                  event.data.restorations = [
                    ...event.data.restorations!,
                    RestorationEntity(
                      patientId: event.data.patientId,
                      tooth: tooth,
                    )
                  ];
              }

              break;
            }
          case SelectedTreatmentEnum.rootCanalTreatment:
            {
              for (var tooth in event.selectedTeeth) {
                if (event.data.rootCanalTreatments!.where((element) => element.tooth == tooth).toList().isEmpty)
                  event.data.rootCanalTreatments = [
                    ...event.data.rootCanalTreatments!,
                    RootCanalTreatmentEntity(
                      patientId: event.data.patientId,
                      tooth: tooth,
                    )
                  ];
              }

              break;
            }
          case SelectedTreatmentEnum.pedo:
            {
              for (var tooth in event.selectedTeeth) {
                if (event.data.pedos!.where((element) => element.tooth == tooth).toList().isEmpty)
                  event.data.pedos = [
                    ...event.data.pedos!,
                    PedoEntity(
                      patientId: event.data.patientId,
                      tooth: tooth,
                    )
                  ];
              }
              for (var tooth in event.selectedPedoTeeth ?? []) {
                if (event.data.pedos!.where((element) => element.tooth == tooth).toList().isEmpty)
                  event.data.pedos = [
                    ...event.data.pedos!,
                    PedoEntity(
                      patientId: event.data.patientId,
                      toothPedo: tooth,
                    )
                  ];
              }

              break;
            }
          case SelectedTreatmentEnum.tmd:
            {
              for (var tooth in event.selectedTeeth) {
                if (event.data.tmds!.where((element) => element.tooth == tooth).toList().isEmpty)
                  event.data.tmds = [
                    ...event.data.tmds!,
                    TMDEntity(
                      patientId: event.data.patientId,
                      tooth: tooth,
                    )
                  ];
              }

              break;
            }
          case SelectedTreatmentEnum.implants:
            {
              for (var tooth in event.selectedTeeth) {
                if (event.data.clinicImplants!.where((element) => element.tooth == tooth).toList().isEmpty)
                  event.data.clinicImplants = [
                    ...event.data.clinicImplants!,
                    ClinicImplantEntity(
                      patientId: event.data.patientId,
                      tooth: tooth,
                      type: event.implantType,
                    )
                  ];
              }

              break;
            }
          case SelectedTreatmentEnum.ortho:
            {
              for (var tooth in event.selectedTeeth) {
                if (event.data.orthoTreatments!.where((element) => element.tooth == tooth).toList().isEmpty)
                  event.data.orthoTreatments = [
                    ...event.data.orthoTreatments!,
                    OrthoTreatmentEntity(
                      patientId: event.data.patientId,
                      tooth: tooth,
                    )
                  ];
              }

              break;
            }
        }
        emit(ClinicTreatmentBloc_LoadedTreatmentsSuccessfullyState(data: event.data));
      },
    );
  }


}
