import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/coreStock/domain/usecases/consumeItemByName.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTreatmentPricesUseCase.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/presentation/bloc/nonSurgicalTreatmentBloc_States.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/teethTreatmentPlan.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/trearmentPlanPropertyEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/getSurgicalTreatmentUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc_Events.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc_States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/injection_contianer.dart';
import '../../../../../core/features/coreStock/domain/usecases/consumeItemById.dart';
import '../../domain/usecase/consumeImplantUseCase.dart';
import '../../domain/usecase/getTreatmentPlanUseCase.dart';
import '../../domain/usecase/saveSurgicalTreatmentUseCase.dart';
import '../../domain/usecase/saveTreatmentPlanUseCase.dart';

class TreatmentBloc extends Bloc<TreatmentBloc_Events, TreatmentBloc_States> {
  final GetTreatmentPlanUseCase getTreatmentPlanUseCase;
  final SaveTreatmentPlanUseCase saveTreatmentPlanUseCase;
  final GetTreatmentPricesUseCase getTreatmentPricesUseCase;
  final ConsumeImplantUseCase consumeImplantUseCase;

  final GetSurgicalTreatmentUseCase getSurgicalTreatmentUseCase;
  final SaveSurgicalTreatmentUseCase saveSurgicalTreatmentUseCase;
  final ConsumeItemByNameUseCase consumeItemByNameUseCase;
  final ConsumeItemByIdUseCase consumeItemByIdUseCase;
  TreatmentPricesEntity _prices = TreatmentPricesEntity();
  bool editMode = true;

  TreatmentBloc({
    required this.saveTreatmentPlanUseCase,
    required this.getTreatmentPlanUseCase,
    required this.getTreatmentPricesUseCase,
    required this.consumeImplantUseCase,
    required this.saveSurgicalTreatmentUseCase,
    required this.getSurgicalTreatmentUseCase,
    required this.consumeItemByIdUseCase,
    required this.consumeItemByNameUseCase,
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
        await  Future.delayed(Duration(milliseconds: 500));
        final result = await getTreatmentPlanUseCase(event.id);
        result.fold(
          (l) => emit(TreatmentBloc_LoadingTreatmentDataErrorState(message: l.message ?? "")),
          (r) => emit(TreatmentBloc_LoadedTreatmentPlanDataSuccessfullyState(data: r)),
        );
      },
    );
    on<TreatmentBloc_SaveTreatmentPlanDataEvent>(
      (event, emit) async {
        final result = await saveTreatmentPlanUseCase(SaveTreatmentPlanParams(id: event.id, data: event.data));
        result.fold(
          (l) => emit(TreatmentBloc_SavingTreatmentDataErrorState(message: l.message ?? "")),
          (r) => emit(TreatmentBloc_SavedTreatmentDataSuccessfullyState()),
        );
      },
    );
    on<TreatmentBloc_SwitchEditAndSummaryViewsEvent>(
      (event, emit) {
        editMode = !editMode;
        int total = 0;
        if (editMode == false) {
          event.data!.forEach((element) {
            if (element.scaling != null) total += element.scaling!.planPrice ?? 0;
            if (element.crown != null) total += element.crown!.planPrice ?? 0;
            if (element.restoration != null) total += element.restoration!.planPrice ?? 0;
            if (element.rootCanalTreatment != null) total += element.rootCanalTreatment!.planPrice ?? 0;
            if (element.extraction != null) total += element.extraction!.planPrice ?? 0;
          });
        }
        emit(TreatmentBloc_ChangedViewState(edit: editMode, total: total));
      },
    );
    on<TreatmentBloc_UpdateTeethStatusEvent>(
      (event, emit) {
        event.teethData = event.teethData
            .map((e) => TeethTreatmentPlanEntity(
                  id: e.id,
                  patientId: e.patientId,
                  patient: e.patient,
                  tooth: e.tooth,
                  rootCanalTreatment: e.rootCanalTreatment,
                  restoration: e.restoration,
                  pontic: e.pontic,
                  extraction: e.extraction,
                  simpleImplant: e.simpleImplant,
                  immediateImplant: e.immediateImplant,
                  expansionWithImplant: e.expansionWithImplant,
                  splittingWithImplant: e.splittingWithImplant,
                  gbrWithImplant: e.gbrWithImplant,
                  openSinusWithImplant: e.openSinusWithImplant,
                  closedSinusWithImplant: e.closedSinusWithImplant,
                  guidedImplant: e.guidedImplant,
                  expansionWithoutImplant: e.expansionWithoutImplant,
                  splittingWithoutImplant: e.splittingWithoutImplant,
                  gbrWithoutImplant: e.gbrWithoutImplant,
                  openSinusWithoutImplant: e.openSinusWithoutImplant,
                  closedSinusWithoutImplant: e.closedSinusWithoutImplant,
                  scaling: e.scaling,
                  crown: e.crown,
                ))
            .toList();
        for (String status in event.selectedStatus) {
          for (int tooth in event.selectedTeeth) {
            var currentTooth = event.teethData.firstWhereOrNull((element) => element.tooth == tooth);
            if (currentTooth == null) {
              currentTooth = new TeethTreatmentPlanEntity(tooth: tooth, patientId: event.patientId);
              event.teethData.add(currentTooth);
            }
            switch (status) {
              case "Simple Implant":
                {
                  if (currentTooth.simpleImplant == null) currentTooth.simpleImplant = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.simpleImplant!.status = true;
                    currentTooth.simpleImplant!.date = DateTime.now();
                    currentTooth.simpleImplant!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.simpleImplant!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  currentTooth.immediateImplant = null;
                  currentTooth.guidedImplant = null;
                  currentTooth.closedSinusWithImplant = null;
                  currentTooth.openSinusWithImplant = null;
                  currentTooth.gbrWithImplant = null;
                  currentTooth.splittingWithImplant = null;
                  currentTooth.expansionWithImplant = null;
                  break;
                }

              case "Immediate Implant":
                {
                  if (currentTooth.immediateImplant == null) currentTooth.immediateImplant = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.immediateImplant!.status = true;
                    currentTooth.immediateImplant!.date = DateTime.now();
                    currentTooth.immediateImplant!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.immediateImplant!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  currentTooth.simpleImplant = null;
                  currentTooth.guidedImplant = null;
                  currentTooth.closedSinusWithImplant = null;
                  currentTooth.openSinusWithImplant = null;
                  currentTooth.gbrWithImplant = null;
                  currentTooth.splittingWithImplant = null;
                  currentTooth.expansionWithImplant = null;
                  break;
                }
              case "Guided Implant":
                {
                  if (currentTooth.guidedImplant == null) currentTooth.guidedImplant = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.guidedImplant!.status = true;
                    currentTooth.guidedImplant!.date = DateTime.now();
                    currentTooth.guidedImplant!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.guidedImplant!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  currentTooth.immediateImplant = null;
                  currentTooth.gbrWithImplant = null;
                  currentTooth.simpleImplant = null;
                  currentTooth.closedSinusWithImplant = null;
                  currentTooth.openSinusWithImplant = null;
                  currentTooth.splittingWithImplant = null;
                  currentTooth.expansionWithImplant = null;
                  break;
                }
              case "Expansion With Implant":
                {
                  if (currentTooth.expansionWithImplant == null) currentTooth.expansionWithImplant = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.expansionWithImplant!.status = true;
                    currentTooth.expansionWithImplant!.date = DateTime.now();
                    currentTooth.expansionWithImplant!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.expansionWithImplant!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  currentTooth.immediateImplant = null;
                  currentTooth.simpleImplant = null;
                  currentTooth.guidedImplant = null;
                  currentTooth.closedSinusWithImplant = null;
                  currentTooth.openSinusWithImplant = null;
                  currentTooth.gbrWithImplant = null;
                  currentTooth.splittingWithImplant = null;
                  break;
                }
              case "Splitting With Implant":
                {
                  if (currentTooth.splittingWithImplant == null) currentTooth.splittingWithImplant = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.splittingWithImplant!.status = true;
                    currentTooth.splittingWithImplant!.date = DateTime.now();
                    currentTooth.splittingWithImplant!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.splittingWithImplant!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  currentTooth.immediateImplant = null;
                  currentTooth.simpleImplant = null;
                  currentTooth.guidedImplant = null;
                  currentTooth.closedSinusWithImplant = null;
                  currentTooth.openSinusWithImplant = null;
                  currentTooth.gbrWithImplant = null;
                  currentTooth.expansionWithImplant = null;
                  break;
                }
              case "GBR With Implant":
                {
                  if (currentTooth.gbrWithImplant == null) currentTooth.gbrWithImplant = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.gbrWithImplant!.status = true;
                    currentTooth.gbrWithImplant!.date = DateTime.now();
                    currentTooth.gbrWithImplant!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.gbrWithImplant!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  currentTooth.immediateImplant = null;
                  currentTooth.simpleImplant = null;
                  currentTooth.guidedImplant = null;
                  currentTooth.closedSinusWithImplant = null;
                  currentTooth.openSinusWithImplant = null;
                  currentTooth.splittingWithImplant = null;
                  currentTooth.expansionWithImplant = null;
                  break;
                }
              case "Open Sinus With Implant":
                {
                  if (currentTooth.openSinusWithImplant == null) currentTooth.openSinusWithImplant = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.openSinusWithImplant!.status = true;
                    currentTooth.openSinusWithImplant!.date = DateTime.now();
                    currentTooth.openSinusWithImplant!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.openSinusWithImplant!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  currentTooth.immediateImplant = null;
                  currentTooth.simpleImplant = null;
                  currentTooth.guidedImplant = null;
                  currentTooth.closedSinusWithImplant = null;
                  currentTooth.gbrWithImplant = null;
                  currentTooth.splittingWithImplant = null;
                  currentTooth.expansionWithImplant = null;
                  break;
                }
              case "Closed Sinus With Implant":
                {
                  if (currentTooth.closedSinusWithImplant == null) currentTooth.closedSinusWithImplant = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.closedSinusWithImplant!.status = true;
                    currentTooth.closedSinusWithImplant!.date = DateTime.now();
                    currentTooth.closedSinusWithImplant!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.closedSinusWithImplant!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  currentTooth.immediateImplant = null;
                  currentTooth.simpleImplant = null;
                  currentTooth.guidedImplant = null;
                  currentTooth.openSinusWithImplant = null;
                  currentTooth.gbrWithImplant = null;
                  currentTooth.splittingWithImplant = null;
                  currentTooth.expansionWithImplant = null;
                  break;
                }
              case "Expansion Without Implant":
                {
                  if (currentTooth.expansionWithoutImplant == null) currentTooth.expansionWithoutImplant = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.expansionWithoutImplant!.status = true;
                    currentTooth.expansionWithoutImplant!.date = DateTime.now();
                    currentTooth.expansionWithoutImplant!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.expansionWithoutImplant!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  break;
                }
              case "Splitting Without Implant":
                {
                  if (currentTooth.splittingWithoutImplant == null) currentTooth.splittingWithoutImplant = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.splittingWithoutImplant!.status = true;
                    currentTooth.splittingWithoutImplant!.date = DateTime.now();
                    currentTooth.splittingWithoutImplant!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );

                    currentTooth.splittingWithoutImplant!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  break;
                }
              case "GBR Without Implant":
                {
                  if (currentTooth.gbrWithoutImplant == null) currentTooth.gbrWithoutImplant = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.gbrWithoutImplant!.status = true;
                    currentTooth.gbrWithoutImplant!.date = DateTime.now();
                    currentTooth.gbrWithoutImplant!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.gbrWithoutImplant!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  break;
                }
              case "Open Sinus Without Implant":
                {
                  if (currentTooth.openSinusWithoutImplant == null) currentTooth.openSinusWithoutImplant = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.openSinusWithoutImplant!.status = true;
                    currentTooth.openSinusWithoutImplant!.date = DateTime.now();
                    currentTooth.openSinusWithoutImplant!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.openSinusWithoutImplant!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  break;
                }
              case "Closed Sinus Without Implant":
                {
                  if (currentTooth.closedSinusWithoutImplant == null) currentTooth.closedSinusWithoutImplant = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.closedSinusWithoutImplant!.status = true;
                    currentTooth.closedSinusWithoutImplant!.date = DateTime.now();
                    currentTooth.closedSinusWithoutImplant!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.closedSinusWithoutImplant!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  break;
                }

              case "Pontic":
                {
                  if (currentTooth.pontic == null) currentTooth.pontic = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.pontic!.status = true;
                    currentTooth.pontic!.date = DateTime.now();
                    currentTooth.pontic!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.pontic!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  break;
                }
              case "Extraction":
                {
                  if (currentTooth.extraction == null) currentTooth.extraction = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.extraction!.status = true;
                    currentTooth.extraction!.date = DateTime.now();
                    currentTooth.extraction!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.extraction!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  break;
                }
              case "Restoration":
                {
                  if (currentTooth.restoration == null) currentTooth.restoration = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.restoration!.status = true;
                    currentTooth.restoration!.date = DateTime.now();
                    currentTooth.restoration!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.restoration!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  break;
                }
              case "Root Canal Treatment":
                {
                  if (currentTooth.rootCanalTreatment == null) currentTooth.rootCanalTreatment = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.rootCanalTreatment!.status = true;
                    currentTooth.rootCanalTreatment!.date = DateTime.now();
                    currentTooth.rootCanalTreatment!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.rootCanalTreatment!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  break;
                }
              case "Scaling":
                {
                  if (currentTooth.scaling == null) currentTooth.scaling = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.scaling!.status = true;
                    currentTooth.scaling!.date = DateTime.now();
                    currentTooth.scaling!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.scaling!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  break;
                }
              case "Crown":
                {
                  if (currentTooth.crown == null) currentTooth.crown = TreatmentPlanPropertyEntity();
                  if (event.isSurgical) {
                    currentTooth.crown!.status = true;
                    currentTooth.crown!.date = DateTime.now();
                    currentTooth.crown!.doneByAssistant = BasicNameIdObjectEntity(
                      name: sl<SharedPreferences>().getString("userName"),
                      id: sl<SharedPreferences>().getInt("userid"),
                    );
                    currentTooth.crown!.doneByAssistantID = sl<SharedPreferences>().getInt("userid");
                  }
                  break;
                }
            }
          }
        }

        emit(TreatmentBloc_UpdatedToothState(data: event.teethData));
      },
    );

    on<TreatmentBloc_GetSurgicalTreatmentDataEvent>(
      (event, emit) async {
        emit(TreatmentBloc_LoadingTreatmentDataState());
        await  Future.delayed(Duration(milliseconds: 500));
        final result = await getSurgicalTreatmentUseCase(event.id);
        result.fold(
          (l) => emit(TreatmentBloc_LoadingTreatmentDataErrorState(message: l.message ?? "")),
          (r) => emit(TreatmentBloc_LoadedSurgicalTreatmentDataSuccessfullyState(data: r)),
        );
      },
    );

    on<TreatmentBloc_SaveSurgicalTreatmentDataEvent>(
      (event, emit) async {
        emit(TreatmentBloc_SavingTreatmentDataState());
        final result = await saveSurgicalTreatmentUseCase(SaveSurgicalTreatmentParams(id: event.id, data: event.data));
        result.fold(
          (l) => emit(TreatmentBloc_SavingTreatmentDataErrorState(message: l.message ?? "")),
          (r) => emit(TreatmentBloc_SavedTreatmentDataSuccessfullyState()),
        );
      },
    );

    on<TreatmentBloc_ConsumeItemByNameEvent>(
      (event, emit) async {
        emit(TreatmentBloc_ConsumingItemState());
        final result = await consumeItemByNameUseCase(ConsumeItemByNameParams(name: event.name, count: event.count));
        result.fold(
          (l) => emit(TreatmentBloc_ConsumeItemErrorState(message: l.message ?? "")),
          (r) => emit(TreatmentBloc_ConsumedItemSuccessfullyState(message: "${event.name} consumed successfully" )),
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
  }
}
