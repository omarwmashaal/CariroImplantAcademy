import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addLabItemCompaniesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addLabItemShadesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addLabItemsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getImplantSizesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemsCompaniesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getProstheticItemsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getProstheticNextVisitUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getProstheticStatusUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getStockCategoriesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTeethClinicPrice.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/updateLabItemParentsPriceUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/updateProstheticItemsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/updateProstheticNextVisitUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/updateProstheticStatusUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/updateTeethClinicPrice.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_Events.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/bloc/settingsBloc_States.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/getRoomsUsecase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/usecase/getTreatmentItemUseCase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/useCases/addExpensesCategoriesUseCase.dart';
import '../../domain/useCases/addImplantCompaniesUseCase.dart';
import '../../domain/useCases/addImplantLinesUseCase.dart';
import '../../domain/useCases/addImplantsUseCase.dart';
import '../../domain/useCases/addIncomeCategoriesUseCase.dart';
import '../../domain/useCases/addMembraneCompaniesUseCase.dart';
import '../../domain/useCases/addMembranesUseCase.dart';
import '../../domain/useCases/addPaymentMethodsUseCase.dart';
import '../../domain/useCases/addStockCategoriesUseCase.dart';
import '../../domain/useCases/addSuppliersUseCase.dart';
import '../../domain/useCases/addTacsCompaniesUseCase.dart';
import '../../domain/useCases/changeImplantCompanyNameUseCase.dart';
import '../../domain/useCases/changeImplantLineNameUseCase.dart';
import '../../domain/useCases/editRoomsUseCase.dart';
import '../../domain/useCases/editTreatmentPricesUseCase.dart';
import '../../domain/useCases/getExpensesCategoriesUseCase.dart';
import '../../domain/useCases/getImplantCompaniesUseCase.dart';
import '../../domain/useCases/getImplantLinesUseCase.dart';
import '../../domain/useCases/getIncomeCategoriesUseCase.dart';
import '../../domain/useCases/getLabItemParentsUseCase.dart';
import '../../domain/useCases/getLabItemsLinesUseCase.dart';
import '../../domain/useCases/getMedicalExpensesCategoriesUseCase.dart';
import '../../domain/useCases/getMembraneCompaniesUseCase.dart';
import '../../domain/useCases/getMembranesUseCase.dart';
import '../../domain/useCases/getNonMedicalNonStockExpensesCategories.dart';
import '../../domain/useCases/getNonMedicalStockCategories.dart';
import '../../domain/useCases/getPaymentMethodsUseCase.dart';
import '../../domain/useCases/getSuppliersUseCase.dart';
import '../../domain/useCases/getTacsUseCase.dart';

class SettingsBloc extends Bloc<SettingsBloc_Events, SettingsBloc_States> {
  final GetProstheticItemsUseCase getProstheticItemsUseCase;
  final GetProstheticStatusUseCase getProstheticStatusUseCase;
  final GetProstheticNextVisitUseCase getProstheticNextVisitUseCase;
  final GetImplantCompaniesUseCase getImplantCompaniesUseCase;
  final GetImplantLinesUseCase getImplantLinesUseCase;
  final GetImplantSizesUseCase getImplantSizesUseCase;
  final GetTreatmentItemsUseCase getTreatmentItemsUseCase;
  final GetTacsUseCase getTacsUseCase;
  final GetMembraneCompaniesUseCase getMembraneCompaniesUseCase;
  final GetMembranesUseCase getMembranesUseCase;
  final GetIncomeCategoriesUseCase getIncomeCategoriesUseCase;
  final GetExpensesCategoriesUseCase getExpensesCategoriesUseCase;
  final GetPaymentMethodsUseCase getPaymentMethodsUseCase;
  final GetMedicalExpensesCategoriesUseCase getMedicalExpensesCategoriesUseCase;
  final GetNonMedicalNonStockExpensesCategoriesUseCase getNonMedicalNonStockExpensesCategoriesUseCase;
  final GetNonMedicalStockCategoriesUseCase getNonMedicalStockCategoriesUseCase;
  final GetSuppliersUseCase getSuppliersUseCase;
  final ChangeImplantCompanyNameUseCase changeImplantCompanyNameUseCase;
  final ChangeImplantLineNameUseCase changeImplantLineNameUseCase;
  final AddImplantsUseCase addImplantsUseCase;
  final AddImplantLinesUseCase addImplantLinesUseCase;
  final AddImplantCompaniesUseCase addImplantCompaniesUseCase;
  final AddMembranesUseCase addMembranesUseCase;
  final AddTacsCompaniesUseCase addTacsCompaniesUseCase;
  final AddMembraneCompaniesUseCase addMembraneCompaniesUseCase;
  final AddExpensesCategoriesUseCase addExpensesCategoriesUseCase;
  final AddIncomeCategoriesUseCase addIncomeCategoriesUseCase;
  final AddSuppliersUseCase addSuppliersUseCase;
  final AddStockCategoriesUseCase addStockCategoriesUseCase;
  final AddPaymentMethodsUseCase addPaymentMethodsUseCase;
  final EditRoomsUseCase editRoomsUseCase;
  final EditTreatmentPricesUseCase editTreatmentPricesUseCase;
  final GetStockCategoriesUseCase getStockCategoriesUseCase;
  final GetRoomsUseCase getRoomsUseCase;
  final GetTeethClinicPricesUseCase getTeethClinicPricesUseCase;
  final UpdateTeethClinicPricesUseCase updateTeethClinicPricesUseCase;
  final GetLabItemParentsUseCase getLabItemParentsUseCase;
  final GetLabItemsCompaniesUseCase getLabItemsCompaniesUseCase;
  final GetLabItemsLinesUseCase getLabItemsLinesUseCase;
  final GetLabItemsUseCase getLabItemsUseCase;
  final UpdateLabItemsCompaniesUseCase updateLabItemsCompaniesUseCase;
  final UpdateLabItemsShadesUseCase updateLabItemsShadesUseCase;
  final UpdateLabItemsUseCase updateLabItemsUseCase;
  final UpdateLabItemsParentsPriceUseCase updateLabItemsParentsPriceUseCase;
  final UpdateProstheticItemsUseCase updateProstheticItemsUseCase;
  final UpdateProstheticStatusUseCase updateProstheticStatusUseCase;
  final UpdateProstheticNextVisitUseCase updateProstheticNextVisitUseCase;

  SettingsBloc({
    required this.getProstheticStatusUseCase,
    required this.getProstheticNextVisitUseCase,
    required this.getProstheticItemsUseCase,
    required this.getImplantCompaniesUseCase,
    required this.getImplantLinesUseCase,
    required this.getImplantSizesUseCase,
    required this.getTreatmentItemsUseCase,
    required this.getTacsUseCase,
    required this.getMembraneCompaniesUseCase,
    required this.getMembranesUseCase,
    required this.getIncomeCategoriesUseCase,
    required this.getExpensesCategoriesUseCase,
    required this.getPaymentMethodsUseCase,
    required this.getMedicalExpensesCategoriesUseCase,
    required this.getNonMedicalNonStockExpensesCategoriesUseCase,
    required this.getNonMedicalStockCategoriesUseCase,
    required this.getSuppliersUseCase,
    required this.changeImplantCompanyNameUseCase,
    required this.changeImplantLineNameUseCase,
    required this.addImplantsUseCase,
    required this.addImplantLinesUseCase,
    required this.addImplantCompaniesUseCase,
    required this.addMembranesUseCase,
    required this.addTacsCompaniesUseCase,
    required this.addMembraneCompaniesUseCase,
    required this.addExpensesCategoriesUseCase,
    required this.addIncomeCategoriesUseCase,
    required this.addSuppliersUseCase,
    required this.addStockCategoriesUseCase,
    required this.addPaymentMethodsUseCase,
    required this.editRoomsUseCase,
    required this.getStockCategoriesUseCase,
    required this.getRoomsUseCase,
    required this.editTreatmentPricesUseCase,
    required this.updateTeethClinicPricesUseCase,
    required this.getTeethClinicPricesUseCase,
    required this.getLabItemParentsUseCase,
    required this.getLabItemsUseCase,
    required this.getLabItemsLinesUseCase,
    required this.getLabItemsCompaniesUseCase,
    required this.updateLabItemsUseCase,
    required this.updateLabItemsCompaniesUseCase,
    required this.updateLabItemsShadesUseCase,
    required this.updateLabItemsParentsPriceUseCase,
    required this.updateProstheticItemsUseCase,
    required this.updateProstheticNextVisitUseCase,
    required this.updateProstheticStatusUseCase,
  }) : super(SettingsBloc_LoadingImplantCompaniesState()) {
    on<SettingsBloc_LoadImplantCompaniesEvent>(
      (event, emit) async {
        emit(SettingsBloc_LoadingImplantCompaniesState());
        final result = await getImplantCompaniesUseCase(NoParams());
        result.fold(
          (l) => emit(SettingsBloc_LoadingImplantCompaniesErrorState(message: l.message ?? "")),
          (r) => emit(SettingsBloc_LoadedImplantCompaniesSuccessfullyState(data: r)),
        );
      },
    );
    on<SettingsBloc_LoadImplantLinesEvent>(
      (event, emit) async {
        emit(SettingsBloc_LoadingImplantLinesState());
        final result = await getImplantLinesUseCase(event.companyId);
        result.fold(
          (l) => emit(SettingsBloc_LoadingImplantLinesErrorState(message: l.message ?? "")),
          (r) => emit(SettingsBloc_LoadedImplantLinesSuccessfullyState(data: r)),
        );
      },
    );
    on<SettingsBloc_LoadImplantsEvent>(
      (event, emit) async {
        emit(SettingsBloc_LoadingImplantsState());
        final result = await getImplantSizesUseCase(event.lineId);
        result.fold(
          (l) => emit(SettingsBloc_LoadingImplantsErrorState(message: l.message ?? "")),
          (r) => emit(SettingsBloc_LoadedImplantsSuccessfullyState(data: r)),
        );
      },
    );
    on<SettingsBloc_LoadTacsEvent>((event, emit) async {
      emit(SettingsBloc_LoadingTacsState());
      final result = await getTacsUseCase(NoParams());
      result.fold(
        (l) => emit(SettingsBloc_LoadingTacsErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedTacsSuccessfullyState(data: r)),
      );
    });
    on<SettingsBloc_LoadMembranesEvent>((event, emit) async {
      emit(SettingsBloc_LoadingMembranesState());
      final result = await getMembranesUseCase(event.id);
      result.fold(
        (l) => emit(SettingsBloc_LoadingMembranesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedMembranesSuccessfullyState(data: r)),
      );
    });
    on<SettingsBloc_LoadExpensesCategoriesEvent>((event, emit) async {
      emit(SettingsBloc_LoadingExpensesCategoriesState());
      final result = await getExpensesCategoriesUseCase(event.website);
      result.fold(
        (l) => emit(SettingsBloc_LoadingExpensesCategoriesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedExpensesCategoriesSuccessfullyState(data: r)),
      );
    });
    on<SettingsBloc_LoadMedicalExpensesCategoriesEvent>((event, emit) async {
      emit(SettingsBloc_LoadingMedicalExpensesCategoriesState());
      final result = await getMedicalExpensesCategoriesUseCase(event.website);
      result.fold(
        (l) => emit(SettingsBloc_LoadingMedicalExpensesCategoriesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedMedicalExpensesCategoriesSuccessfullyState(data: r)),
      );
    });
    on<SettingsBloc_LoadNonMedicalStockCategoriesEvent>((event, emit) async {
      emit(SettingsBloc_LoadingNonMedicalStockCategoriesState());
      final result = await getNonMedicalStockCategoriesUseCase(event.website);
      result.fold(
        (l) => emit(SettingsBloc_LoadingNonMedicalStockCategoriesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedNonMedicalStockCategoriesSuccessfullyState(data: r)),
      );
    });
    on<SettingsBloc_ChangeImplantCompanyNameEvent>((event, emit) async {
      emit(SettingsBloc_ChangingImplantCompanyNameState());
      final result = await changeImplantCompanyNameUseCase(event.value);
      result.fold(
        (l) => emit(SettingsBloc_ChangingImplantCompanyNameErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_ChangedImplantCompanyNameSuccessfullyState()),
      );
    });
    on<SettingsBloc_UpdateImplantsEvent>((event, emit) async {
      emit(SettingsBloc_UpdatingImplantsState());
      final result = await addImplantsUseCase(event.value);
      result.fold(
        (l) => emit(SettingsBloc_UpdatingImplantsErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_UpdatedImplantsSuccessfullyState()),
      );
    });
    on<SettingsBloc_AddImplantCompaniesEvent>((event, emit) async {
      emit(SettingsBloc_AddingImplantCompaniesState());
      final result = await addImplantCompaniesUseCase(event.name);
      result.fold(
        (l) => emit(SettingsBloc_AddingImplantCompaniesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_AddedImplantCompaniesSuccessfullyState()),
      );
    });
    on<SettingsBloc_AddTacsCompaniesEvent>((event, emit) async {
      emit(SettingsBloc_AddingTacsCompaniesState());
      final result = await addTacsCompaniesUseCase(event.model);
      result.fold(
        (l) => emit(SettingsBloc_AddingTacsCompaniesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_AddedTacsCompaniesSuccessfullyState()),
      );
    });
    on<SettingsBloc_AddExpensesCategoriesEvent>((event, emit) async {
      emit(SettingsBloc_AddingExpensesCategoriesState());
      final result = await addExpensesCategoriesUseCase(event.model);
      result.fold(
        (l) => emit(SettingsBloc_AddingExpensesCategoriesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_AddedExpensesCategoriesSuccessfullyState()),
      );
    });
    on<SettingsBloc_AddSuppliersEvent>((event, emit) async {
      emit(SettingsBloc_AddingSuppliersState(medical: event.params.medical));
      final result = await addSuppliersUseCase(event.params);
      result.fold(
        (l) => emit(SettingsBloc_AddingSuppliersErrorState(message: l.message ?? "", medical: event.params.medical)),
        (r) => emit(SettingsBloc_AddedSuppliersSuccessfullyState(medical: event.params.medical)),
      );
    });
    on<SettingsBloc_AddPaymentMethodsEvent>((event, emit) async {
      emit(SettingsBloc_AddingPaymentMethodsState());
      final result = await addPaymentMethodsUseCase(event.model);
      result.fold(
        (l) => emit(SettingsBloc_AddingPaymentMethodsErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_AddedPaymentMethodsSuccessfullyState()),
      );
    });
    on<SettingsBloc_EditTreatmentPricesEvent>((event, emit) async {
      emit(SettingsBloc_EditingTreatmentPricesState());
      final pricesFromSettings = await getTreatmentItemsUseCase(NoParams());
      pricesFromSettings.fold(
        (l) => null,
        (r) {
          var implantsFromSettings = r.where((element) => element.isImplant()).toList();
          var implantPrice = event.prices.firstWhere((element) => element.name == "Implant");
          implantsFromSettings.forEach((element) {
            element.price = implantPrice.price ?? 0;
            element.showInSurgical = implantPrice.showInSurgical;
            element.allowAssign = implantPrice.allowAssign;
          });
          event.prices.removeWhere((element) => element.name == "Implant");
          event.prices.addAll(implantsFromSettings);
        },
      );
      if (pricesFromSettings.isRight()) {
        final result = await editTreatmentPricesUseCase(event.prices);
        result.fold(
          (l) => emit(SettingsBloc_EditingTreatmentPricesErrorState(message: l.message ?? "")),
          (r) => emit(SettingsBloc_EditedTreatmentPricesSuccessfullyState()),
        );
      } else {
        emit(SettingsBloc_EditingTreatmentPricesErrorState(message: "error"));
      }
    });
    on<SettingsBloc_ChangeImplantLineNameEvent>((event, emit) async {
      emit(SettingsBloc_ChangingImplantLineNameState());
      final result = await changeImplantLineNameUseCase(event.value);
      result.fold(
        (l) => emit(SettingsBloc_ChangingImplantLineNameErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_ChangedImplantLineNameSuccessfullyState()),
      );
    });
    on<SettingsBloc_LoadMembraneCompaniesEvent>((event, emit) async {
      emit(SettingsBloc_LoadingMembraneCompaniesState());
      final result = await getMembraneCompaniesUseCase(NoParams());
      result.fold(
        (l) => emit(SettingsBloc_LoadingMembraneCompaniesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedMembraneCompaniesSuccessfullyState(data: r)),
      );
    });
    on<SettingsBloc_AddMembranesEvent>((event, emit) async {
      emit(SettingsBloc_AddingMembranesState());
      final result = await addMembranesUseCase(event.value);
      result.fold(
        (l) => emit(SettingsBloc_AddingMembranesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_AddedMembranesSuccessfullyState()),
      );
    });
    on<SettingsBloc_AddImplantLinesEvent>((event, emit) async {
      emit(SettingsBloc_AddingImplantLinesState());
      final result = await addImplantLinesUseCase(event.value);
      result.fold(
        (l) => emit(SettingsBloc_AddingImplantLinesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_AddedImplantLinesSuccessfullyState()),
      );
    });
    on<SettingsBloc_AddMembraneCompaniesEvent>((event, emit) async {
      emit(SettingsBloc_AddingMembraneCompaniesState());
      final result = await addMembraneCompaniesUseCase(event.model);
      result.fold(
        (l) => emit(SettingsBloc_AddingMembraneCompaniesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_AddedMembraneCompaniesSuccessfullyState()),
      );
    });
    on<SettingsBloc_LoadIncomeCategoriesEvent>((event, emit) async {
      emit(SettingsBloc_LoadingIncomeCategoriesState());
      final result = await getIncomeCategoriesUseCase(NoParams());
      result.fold(
        (l) => emit(SettingsBloc_LoadingIncomeCategoriesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedIncomeCategoriesSuccessfullyState(data: r)),
      );
    });
    on<SettingsBloc_AddIncomeCategoriesEvent>((event, emit) async {
      emit(SettingsBloc_AddingIncomeCategoriesState());
      final result = await addIncomeCategoriesUseCase(event.model);
      result.fold(
        (l) => emit(SettingsBloc_AddingIncomeCategoriesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_AddedIncomeCategoriesSuccessfullyState()),
      );
    });
    on<SettingsBloc_AddStockCategoriesEvent>((event, emit) async {
      emit(SettingsBloc_AddingStockCategoriesState());
      final result = await addStockCategoriesUseCase(event.model);
      result.fold(
        (l) => emit(SettingsBloc_AddingStockCategoriesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_AddedStockCategoriesSuccessfullyState()),
      );
    });
    on<SettingsBloc_LoadStockCategoriesEvent>((event, emit) async {
      emit(SettingsBloc_LoadingStockCategoriesState());
      final result = await getStockCategoriesUseCase(event.website);
      result.fold(
        (l) => emit(SettingsBloc_LoadingStockCategoriesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedStockCategoriesSuccessfullyState(data: r)),
      );
    });
    on<SettingsBloc_LoadSuppliersEvent>((event, emit) async {
      emit(SettingsBloc_LoadingSuppliersState(medical: event.params.medical));
      final result = await getSuppliersUseCase(event.params);
      result.fold(
        (l) => emit(SettingsBloc_LoadingSuppliersErrorState(message: l.message ?? "", medical: event.params.medical)),
        (r) => emit(SettingsBloc_LoadedSuppliersSuccessfullyState(data: r, medical: event.params.medical)),
      );
    });
    on<SettingsBloc_LoadPaymentMethodsEvent>((event, emit) async {
      emit(SettingsBloc_LoadingPaymentMethodsState());
      final result = await getPaymentMethodsUseCase(NoParams());
      result.fold(
        (l) => emit(SettingsBloc_LoadingPaymentMethodsErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedPaymentMethodsSuccessfullyState(data: r)),
      );
    });
    on<SettingsBloc_LoadRoomsEvent>((event, emit) async {
      emit(SettingsBloc_LoadingRoomsState());
      final result = await getRoomsUseCase(NoParams());
      result.fold(
        (l) => emit(SettingsBloc_LoadingRoomsErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedRoomsSuccessfullyState(data: r)),
      );
    });
    on<SettingsBloc_LoadTreatmentPricesEvent>((event, emit) async {
      emit(SettingsBloc_LoadingTreatmentPricesState());
      final result = await getTreatmentItemsUseCase(NoParams());
      result.fold(
        (l) => emit(SettingsBloc_LoadingTreatmentPricesErrorState(message: l.message ?? "")),
        (r) {
          int implantPrice = r.firstWhere((element) => element.isImplant()).price ?? 0;
          r.removeWhere((element) => element.isImplant());
          r = [
            ...r,
            TreatmentItemEntity(
              name: "Implant",
              price: implantPrice,
            )
          ];
          emit(SettingsBloc_LoadedTreatmentPricesSuccessfullyState(data: r));
        },
      );
    });
    on<SettingsBloc_EditRoomsEvent>((event, emit) async {
      emit(SettingsBloc_EditingRoomsState());
      final result = await editRoomsUseCase(event.model);
      result.fold(
        (l) => emit(SettingsBloc_EditingRoomsErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_EditedRoomsSuccessfullyState()),
      );
    });

    on<SettingsBloc_EditClinicPricesEvent>((event, emit) async {
      emit(SettingsBloc_EditingClinicPricesState());
      final result = await updateTeethClinicPricesUseCase(event.prices);
      result.fold(
        (l) => emit(SettingsBloc_EditingClinicPricesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_EditedClinicPricesSuccessfullyState()),
      );
    });
    on<SettingsBloc_LoadClinicPricesEvent>((event, emit) async {
      emit(SettingsBloc_LoadingClinicPricesState());
      final result = await getTeethClinicPricesUseCase(event.params);
      result.fold(
        (l) => emit(SettingsBloc_LoadingClinicPricesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedClinicPricesSuccessfullyState(data: r)),
      );
    });
    on<SettingsBloc_LoadLabItemsParentsEvent>((event, emit) async {
      emit(SettingsBloc_LoadingLabItemParentsState());
      final result = await getLabItemParentsUseCase(NoParams());
      result.fold(
        (l) => emit(SettingsBloc_LoadingLabItemParentsErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedLabItemParentsSuccessfullyState(data: r)),
      );
    });
    on<SettingsBloc_LoadLabItemCompaniesEvent>((event, emit) async {
      emit(SettingsBloc_LoadingLabItemsCompaniesState());
      final result = await getLabItemsCompaniesUseCase(event.id);
      result.fold(
        (l) => emit(SettingsBloc_LoadingLabItemsCompaniesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedLabItemsCompaniesSuccessfullyState(data: r)),
      );
    });
    on<SettingsBloc_LoadLabItemsShadesEvent>((event, emit) async {
      emit(SettingsBloc_LoadingLabItemsShadesState());
      final result = await getLabItemsLinesUseCase(event.companyId);
      result.fold(
        (l) => emit(SettingsBloc_LoadingLabItemsShadesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedLabItemsShadesSuccessfullyState(data: r)),
      );
    });
    on<SettingsBloc_LoadLabItemsEvent>((event, emit) async {
      emit(SettingsBloc_LoadingLabItemsState());
      final result = await getLabItemsUseCase(event.shadeId);
      result.fold(
        (l) => emit(SettingsBloc_LoadingLabItemsErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedLabItemsSuccessfullyState(data: r)),
      );
    });

    on<SettingsBloc_UpdateLabItemCompaniesEvent>((event, emit) async {
      emit(SettingsBloc_UpdatingLabItemsCompaniesState());
      final result = await updateLabItemsCompaniesUseCase(event.params);
      result.fold(
        (l) => emit(SettingsBloc_UpdatingLabItemsCompaniesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_UpdatedLabItemsCompaniesSuccessfullyState()),
      );
    });
    on<SettingsBloc_UpdateLabItemShadesEvent>((event, emit) async {
      emit(SettingsBloc_UpdatingLabItemsShadesState());
      final result = await updateLabItemsShadesUseCase(event.params);
      result.fold(
        (l) => emit(SettingsBloc_UpdatingLabItemsShadesErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_UpdatedLabItemsShadesSuccessfullyState()),
      );
    });
    on<SettingsBloc_UpdateLabItemEvent>((event, emit) async {
      emit(SettingsBloc_UpdatingLabItemsState());
      final result = await updateLabItemsUseCase(event.params);
      result.fold(
        (l) => emit(SettingsBloc_UpdatingLabItemsErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_UpdatedLabItemsSuccessfullyState()),
      );
    });
    on<SettingsBloc_UpdateLabItemParentPriceEvent>((event, emit) async {
      emit(SettingsBloc_UpdatingLabItemsParentsPriceParentsPriceParentsPriceState());
      final result = await updateLabItemsParentsPriceUseCase(event.params);
      result.fold(
        (l) => emit(SettingsBloc_UpdatingLabItemsParentsPriceParentsPriceErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_UpdatedLabItemsParentsPriceParentsPriceSuccessfullyState()),
      );
    });

    on<SettingsBloc_GetProstheticItemsEvent>((event, emit) async {
      emit(SettingsBloc_LoadingProstheticItemsState());
      final result = await getProstheticItemsUseCase(event.type);
      result.fold(
        (l) => emit(SettingsBloc_LoadingProstheticItemsErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedProstheticItemsSuccessfullyState(data: r, type: event.type)),
      );
    });

    on<SettingsBloc_GetProstheticStatusEvent>((event, emit) async {
      emit(SettingsBloc_LoadingProstheticStatusState());
      final result = await getProstheticStatusUseCase(event.params);
      result.fold(
        (l) => emit(SettingsBloc_LoadingProstheticStatusErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedProstheticStatusSuccessfullyState(data: r)),
      );
    });

    on<SettingsBloc_GetProstheticNextVisitEvent>((event, emit) async {
      emit(SettingsBloc_LoadingProstheticNextVisitState());
      final result = await getProstheticNextVisitUseCase(event.params);
      result.fold(
        (l) => emit(SettingsBloc_LoadingProstheticNextVisitErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_LoadedProstheticNextVisitSuccessfullyState(data: r)),
      );
    });

    on<SettingsBloc_UpdateProstheticItemsEvent>((event, emit) async {
      emit(SettingsBloc_UpdatingProstheticItemsState());
      final result = await updateProstheticItemsUseCase(event.params);
      result.fold(
        (l) => emit(SettingsBloc_UpdatingProstheticItemsErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_UpdatedProstheticItemsSuccessfullyState(type: event.params.type)),
      );
    });

    on<SettingsBloc_UpdateProstheticNextEventEvent>((event, emit) async {
      emit(SettingsBloc_UpdatingProstheticStatusState());
      final result = await updateProstheticNextVisitUseCase(event.params);
      result.fold(
        (l) => emit(SettingsBloc_UpdatingProstheticStatusErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_UpdatedProstheticStatusSuccessfullyState(
          type: event.params.type,
          itemId: event.params.itemId,
        )),
      );
    });

    on<SettingsBloc_UpdateProstheticStatusEvent>((event, emit) async {
      emit(SettingsBloc_UpdatingProstheticNextVisitState());
      final result = await updateProstheticStatusUseCase(event.params);
      result.fold(
        (l) => emit(SettingsBloc_UpdatingProstheticNextVisitErrorState(message: l.message ?? "")),
        (r) => emit(SettingsBloc_UpdatedProstheticNextVisitSuccessfullyState(
          type: event.params.type,
          itemId: event.params.itemId,
        )),
      );
    });
  }
}
