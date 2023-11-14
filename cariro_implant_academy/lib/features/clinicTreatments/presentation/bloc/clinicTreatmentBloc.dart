import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTeethClinicPrice.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_States.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicImplantEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/orthoTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/pedoEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/restorationEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/rootCanalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/scalingEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/tmdEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/useCases/getTreatmentsUseCase.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/useCases/updateTreatmentsUseCase.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/presentation/bloc/clinicTreatmentBloc_States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClinicTreatmentBloc extends Bloc<ClinicTreatmentBloc_Events, ClinicTreatmentBloc_States> {
  final GetClinicTreatmentsUseCase getClinicTreatmentsUseCase;
  final UpdateClinicTreatmentsUseCase updateClinicTreatmentsUseCase;
  final GetTeethClinicPricesUseCase getTeethClinicPricesUseCase;

  bool isInitialized = false;

  ClinicTreatmentBloc({
    required this.updateClinicTreatmentsUseCase,
    required this.getClinicTreatmentsUseCase,
    required this.getTeethClinicPricesUseCase,
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

    on<ClinicTreatmentBloc_GetPriceEvent>(
      (event, emit) async {
        emit(ClinicTreatmentBloc_LoadingPricesState(key: event.key));
        var result = await getTeethClinicPricesUseCase(event.params);
        result.fold(
          (l) => emit(ClinicTreatmentBloc_LoadingPricesErrorState(message: l.message ?? "", key: event.key)),
          (r) => emit(ClinicTreatmentBloc_LoadedPricesSuccessfullyState(key: event.key, prices: r)),
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
                int number = 1;
                if (event.data.rootCanalTreatments!.where((element) => element.tooth == tooth).toList().isEmpty) {
                  switch (tooth % 10) {
                    case 1:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                        ];
                        break;
                      }
                    case 2:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                        ];
                        break;
                      }
                    case 3:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                        ];
                        break;
                      }
                    case 4:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 2),
                        ];
                        break;
                      }
                    case 5:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 2),
                        ];
                        break;
                      }
                    case 6:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 2),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 3),
                        ];
                        break;
                      }
                    case 7:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 2),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 3),
                        ];
                        break;
                      }
                    case 8:
                      {
                        event.data.rootCanalTreatments = [
                          ...event.data.rootCanalTreatments!,
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 1),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 2),
                          RootCanalTreatmentEntity(patientId: event.data.patientId, tooth: tooth, canalNumber: 3),
                        ];
                        break;
                      }
                  }
                }
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
          case SelectedTreatmentEnum.scaling:
            {
              for (var tooth in event.selectedTeeth) {
                if (event.data.scalings!.where((element) => element.tooth == tooth).toList().isEmpty)
                  event.data.scalings = [
                    ...event.data.scalings!,
                    ScalingEntity(
                      patientId: event.data.patientId,
                      tooth: tooth,
                      stepNumber: 1,
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
    on<ClinicTreatmentBloc_CalculateTotalPriceEvent>(
      (event, emit) {
        var price = 0;
        for (var rest in event.params.restorations!) price += rest.price ?? 0;
        for (var rest in event.params.clinicImplants!) price += rest.price ?? 0;
        for (var rest in event.params.orthoTreatments!) price += rest.price ?? 0;
        for (var rest in event.params.tmds!) price += rest.price ?? 0;
        for (var rest in event.params.pedos!) price += rest.price ?? 0;
        for (var rest in event.params.rootCanalTreatments!) price += rest.price ?? 0;
        for (var rest in event.params.scalings!) price += rest.price ?? 0;
        emit(ClinicTreatmentBloc_TotalPriceChangedState(price: price));
      },
    );
  }
}
