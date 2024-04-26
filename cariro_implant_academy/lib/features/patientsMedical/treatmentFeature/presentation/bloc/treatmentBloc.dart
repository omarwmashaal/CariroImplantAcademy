import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/coreStock/domain/usecases/consumeItemByName.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTacsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTreatmentPricesUseCase.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/acceptChangesUseCASE.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/getSurgicalTreatmentUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/getTreatmentDetailsUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/saveTreatmentPlanUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc_States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/injection_contianer.dart';
import '../../../../../Constants/Controllers.dart';
import '../../../../../core/features/coreStock/domain/usecases/consumeItemById.dart';
import '../../domain/usecase/consumeImplantUseCase.dart';
import '../../domain/usecase/getTreatmentPlanUseCase.dart';
import '../../domain/usecase/saveTreatmentDetailsUseCase.dart';

class TreatmentBloc extends Bloc<TreatmentBloc_Events, TreatmentBloc_States> {
  final GetTreatmentPlanUseCase getTreatmentPlanUseCase;
  final GetTreatmentDetailsUseCase getTreatmentDetailsUseCase;
  final SaveTreatmentDetailsUseCase saveTreatmentDetailsUseCase;
  final SaveTreatmentPlanUseCase saveTreatmentPlanUseCase;
  final GetTreatmentPricesUseCase getTreatmentPricesUseCase;
  final ConsumeImplantUseCase consumeImplantUseCase;

  final GetSurgicalTreatmentUseCase getSurgicalTreatmentUseCase;
  final ConsumeItemByNameUseCase consumeItemByNameUseCase;
  final ConsumeItemByIdUseCase consumeItemByIdUseCase;
  final GetTacsUseCase getTacsUseCase;
  final AcceptChangesUseCase acceptChangesUseCase;
  TreatmentPricesEntity _prices = TreatmentPricesEntity();
  bool editMode = true;
  BasicNameIdObjectEntity? tempCandidate;
  BasicNameIdObjectEntity? tempSuperVisor;
  BasicNameIdObjectEntity? tempCandidateBatch;

  TreatmentBloc({
    required this.saveTreatmentDetailsUseCase,
    required this.saveTreatmentPlanUseCase,
    required this.getTreatmentPlanUseCase,
    required this.getTreatmentPricesUseCase,
    required this.consumeImplantUseCase,
    required this.getSurgicalTreatmentUseCase,
    required this.consumeItemByIdUseCase,
    required this.consumeItemByNameUseCase,
    required this.getTacsUseCase,
    required this.getTreatmentDetailsUseCase,
    required this.acceptChangesUseCase,
  }) : super(TreatmentBloc_LoadingTreatmentDataState()) {
    on<TreatmentBloc_ConsumeImplantEvent>(
      (event, emit) async {
        emit(TreatmentBloc_ConsumingItemState());
        final result = await consumeImplantUseCase(event.id);
        result.fold(
          (l) => emit(TreatmentBloc_ConsumeItemErrorState(message: l.message ?? "")),
          (r) => emit(TreatmentBloc_ConsumedItemSuccessfullyState()),
        );
      },
    );

    on<TreatmentBloc_GetTreatmentPrices>(
      (event, emit) async {
        final pricesResult = await getTreatmentPricesUseCase(NoParams());
        pricesResult.fold(
          (l) => null,
          (r) {
            _prices = r;
            emit(TreatmentBloc_LoadedTreatmentPricesState(prices: _prices));
          },
        );
      },
    );
    on<TreatmentBloc_GetTreatmentPlanDataEvent>(
      (event, emit) async {
        emit(TreatmentBloc_LoadingTreatmentDataState());
        await Future.delayed(Duration(milliseconds: 500));
        final result = await getTreatmentPlanUseCase(event.id);
        final treatmentDetails = await getTreatmentDetailsUseCase(event.id);

        if (result.isLeft() || treatmentDetails.isLeft()) {
          emit(TreatmentBloc_LoadingTreatmentDataErrorState(message: "Error"));
        }
        List<TreatmentDetailsEntity> data = [];
        treatmentDetails.fold((l) => null, (r) => data = r);
        result.fold(
          (l) => emit(TreatmentBloc_LoadingTreatmentDataErrorState(message: l.message ?? "")),
          (r) => emit(TreatmentBloc_LoadedTreatmentPlanDataSuccessfullyState(details: data, data: r)),
        );
      },
    );
    on<TreatmentBloc_SaveTreatmentDetailsEvent>(
      (event, emit) async {
        emit(TreatmentBloc_SavingTreatmentDataState());
        final result = await saveTreatmentDetailsUseCase(SaveTreatmentDetailsParams(id: event.id, data: event.data));
        var generalResult = await saveTreatmentPlanUseCase(SaveTreatmentPlanParams(id: event.id, data: event.generalData));

        result.fold(
          (l) => emit(TreatmentBloc_SavingTreatmentDataErrorState(message: l.message ?? "")),
          (r) {
            if (generalResult.isRight())
              emit(TreatmentBloc_SavedTreatmentDataSuccessfullyState());
            else
              emit(TreatmentBloc_SavingTreatmentDataErrorState(message: "error"));
          },
        );
      },
    );
    on<TreatmentBloc_SwitchEditAndSummaryViewsEvent>(
      (event, emit) {
        editMode = !editMode;
        int total = 0;
        if (editMode == false) {
          event.data.forEach((element) {
            total += element.planPrice ?? 0;
          });
        }
        emit(TreatmentBloc_ChangedViewState(edit: editMode, total: total));
      },
    );

    on<TreatmentBloc_UpdateTeethStatusEvent>(
      (event, emit) {
        for (String name in event.selectedName) {
          for (int tooth in event.selectedTeeth) {
            var currentToothData = TreatmentDetailsEntity.getTreatment(
              data: event.teethData,
              query: name,
              tooth: tooth,
            );
            if (currentToothData == null) {
              currentToothData = TreatmentDetailsEntity(
                tooth: tooth,
                patientId: event.patientId,
                name: name,
              );
              event.teethData = [...event.teethData, currentToothData];
            }
            currentToothData.status = event.isSurgical;
            currentToothData.date = event.isSurgical ? DateTime.now() : null;
            currentToothData.doneByAssistant = event.isSurgical
                ? BasicNameIdObjectEntity(
                    name: siteController.getUserName(),
                    id: sl<SharedPreferences>().getInt("userid"),
                  )
                : null;
            currentToothData.doneByAssistantID = event.isSurgical ? sl<SharedPreferences>().getInt("userid") : null;
          }
        }

        event.teethData.sort(
          (a, b) {
            return (a.tooth ?? 0).compareTo(b.tooth ?? 0);
          },
        );

        emit(TreatmentBloc_UpdatedToothState(data: event.teethData));
      },
    );

    on<TreatmentBloc_ConsumeItemByNameEvent>(
      (event, emit) async {
        emit(TreatmentBloc_ConsumingItemState());
        final result = await consumeItemByNameUseCase(ConsumeItemByNameParams(name: event.name, count: event.count));
        result.fold(
          (l) => emit(TreatmentBloc_ConsumeItemErrorState(message: l.message ?? "")),
          (r) => emit(TreatmentBloc_ConsumedItemSuccessfullyState(message: "${event.name} consumed successfully")),
        );
      },
    );

    on<TreatmentBloc_ConsumeItemByIdEvent>(
      (event, emit) async {
        emit(TreatmentBloc_ConsumingItemState());
        final result = await consumeItemByIdUseCase(ConsumeItemByIdParams(id: event.id, count: event.count));
        result.fold(
          (l) => emit(TreatmentBloc_ConsumeItemErrorState(message: l.message ?? "")),
          (r) => emit(TreatmentBloc_ConsumedItemSuccessfullyState(message: "Item consumed Successfully")),
        );
      },
    );

    on<TreatmentBloc_GetTacsEvent>(
      (event, emit) async {
        final result = await getTacsUseCase(NoParams());
        result.fold((l) => null, (r) => emit(TreatmentBloc_LoadedTacsState(tacs: r)));
      },
    );
    on<TreatmentBloc_AcceptChangesEvent>(
      (event, emit) async {
        emit(TreatmentBloc_AcceptingChangesState());
        final result = await acceptChangesUseCase(event.requestChangeEntity);
        result.fold(
          (l) => emit(TreatmentBloc_AcceptingChangesErrorState(message: l.message ?? "")),
          (r) =>
              emit(TreatmentBloc_AcceptedChangesSuccessfullyState(id: event.requestChangeEntity.id!, requestChangeEntity: event.requestChangeEntity)),
        );
      },
    );
  }
}
