import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/clinicPriceEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/implantEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/roomEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../../Models/ImplantModel.dart';
import '../../../../../Models/TacCompanyModel.dart';
import '../../../../../features/labRequest/domain/entities/labItemParentEntity.dart';
import '../../../../data/models/BasicNameIdObjectModel.dart';
import '../../data/models/membraneCompanyModel.dart';
import '../../data/models/treatmentPricesModel.dart';
import '../../domain/entities/membraneCompanyEnity.dart';
import '../../domain/entities/treatmentPricesEntity.dart';

abstract class SettingsBloc_States extends Equatable {}

abstract class SettingsBlocLoadedSuccessfullyState extends SettingsBloc_States {
  final List<BasicNameIdObjectEntity> data;

  SettingsBlocLoadedSuccessfullyState({required this.data});
}

abstract class SettingsBlocSuccessState extends SettingsBloc_States {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

abstract class SettingsBlocErrorState extends SettingsBloc_States {
  final String message;

  SettingsBlocErrorState({required this.message});
}

class SettingsBloc_LoadingImplantCompaniesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingImplantLinesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingImplantsState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadedImplantCompaniesSuccessfullyState extends SettingsBlocLoadedSuccessfullyState {
  SettingsBloc_LoadedImplantCompaniesSuccessfullyState({required super.data});

  @override
  List<Object?> get props => [super.data];
}

class SettingsBloc_LoadedImplantLinesSuccessfullyState extends SettingsBlocLoadedSuccessfullyState {
  SettingsBloc_LoadedImplantLinesSuccessfullyState({required super.data});

  @override
  List<Object?> get props => [super.data];
}

class SettingsBloc_LoadedImplantsSuccessfullyState extends SettingsBlocLoadedSuccessfullyState {
  SettingsBloc_LoadedImplantsSuccessfullyState({required super.data});

  @override
  List<Object?> get props => [super.data];
}

class SettingsBloc_LoadingImplantCompaniesErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingImplantCompaniesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadingImplantLinesErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingImplantLinesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadingImplantsErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingImplantsErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadingTreatmentPricesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingTreatmentPricesErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingTreatmentPricesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedTreatmentPricesSuccessfullyState extends SettingsBloc_States {
  final List<TreatmentItemEntity> data;

  SettingsBloc_LoadedTreatmentPricesSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [this.data];
}

class SettingsBloc_LoadingTacsState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingTacsErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingTacsErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedTacsSuccessfullyState extends SettingsBloc_States {
  final List<TacCompanyEntity> data;

  SettingsBloc_LoadedTacsSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [this.data];
}

class SettingsBloc_LoadingMembraneCompaniesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingMembraneCompaniesErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingMembraneCompaniesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedMembraneCompaniesSuccessfullyState extends SettingsBloc_States {
  final List<MembraneCompanyEntity> data;

  SettingsBloc_LoadedMembraneCompaniesSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [this.data];
}

class SettingsBloc_LoadingMembranesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingMembranesErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingMembranesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedMembranesSuccessfullyState extends SettingsBloc_States {
  final List<BasicNameIdObjectEntity> data;

  SettingsBloc_LoadedMembranesSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [this.data];
}

class SettingsBloc_LoadingIncomeCategoriesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingIncomeCategoriesErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingIncomeCategoriesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedIncomeCategoriesSuccessfullyState extends SettingsBloc_States {
  final List<BasicNameIdObjectEntity> data;

  SettingsBloc_LoadedIncomeCategoriesSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [this.data];
}
class SettingsBloc_LoadingStockCategoriesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingStockCategoriesErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingStockCategoriesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedStockCategoriesSuccessfullyState extends SettingsBloc_States {
  final List<BasicNameIdObjectEntity> data;

  SettingsBloc_LoadedStockCategoriesSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [this.data];
}

class SettingsBloc_LoadingExpensesCategoriesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingExpensesCategoriesErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingExpensesCategoriesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedExpensesCategoriesSuccessfullyState extends SettingsBloc_States {
  final List<BasicNameIdObjectEntity> data;

  SettingsBloc_LoadedExpensesCategoriesSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [this.data];
}

class SettingsBloc_LoadingPaymentMethodsState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingPaymentMethodsErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingPaymentMethodsErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedPaymentMethodsSuccessfullyState extends SettingsBloc_States {
  final List<BasicNameIdObjectEntity> data;

  SettingsBloc_LoadedPaymentMethodsSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [this.data];
}

class SettingsBloc_LoadingRoomsState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingRoomsErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingRoomsErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedRoomsSuccessfullyState extends SettingsBloc_States {
  final List<RoomEntity> data;

  SettingsBloc_LoadedRoomsSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [this.data,identityHashCode(this)];
}

class SettingsBloc_LoadingMedicalExpensesCategoriesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingMedicalExpensesCategoriesErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingMedicalExpensesCategoriesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedMedicalExpensesCategoriesSuccessfullyState extends SettingsBloc_States {
  final List<BasicNameIdObjectEntity> data;

  SettingsBloc_LoadedMedicalExpensesCategoriesSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [this.data];
}

class SettingsBloc_LoadingNonMedicalNonStockExpensesCategoriesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingNonMedicalNonStockExpensesCategoriesErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingNonMedicalNonStockExpensesCategoriesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedNonMedicalNonStockExpensesCategoriesSuccessfullyState extends SettingsBloc_States {
  final List<BasicNameIdObjectEntity> data;

  SettingsBloc_LoadedNonMedicalNonStockExpensesCategoriesSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [this.data];
}

class SettingsBloc_LoadingNonMedicalStockCategoriesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingNonMedicalStockCategoriesErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingNonMedicalStockCategoriesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedNonMedicalStockCategoriesSuccessfullyState extends SettingsBloc_States {
  final List<BasicNameIdObjectEntity> data;

  SettingsBloc_LoadedNonMedicalStockCategoriesSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [this.data];
}

class SettingsBloc_LoadingSuppliersState extends SettingsBloc_States {
  final bool medical;
  SettingsBloc_LoadingSuppliersState({required this.medical});
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingSuppliersErrorState extends SettingsBlocErrorState {
  final bool medical;
  SettingsBloc_LoadingSuppliersErrorState({required super.message,required this.medical});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedSuppliersSuccessfullyState extends SettingsBloc_States {
  final List<BasicNameIdObjectEntity> data;
  final bool medical;

  SettingsBloc_LoadedSuppliersSuccessfullyState({required this.data, required this.medical});

  @override
  List<Object?> get props => [this.data];
}

class SettingsBloc_ChangingImplantCompanyNameState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_ChangingImplantCompanyNameErrorState extends SettingsBlocErrorState {
  SettingsBloc_ChangingImplantCompanyNameErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_ChangedImplantCompanyNameSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_ChangingImplantLineNameState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_ChangingImplantLineNameErrorState extends SettingsBlocErrorState {
  SettingsBloc_ChangingImplantLineNameErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_ChangedImplantLineNameSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_UpdatingImplantsState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_UpdatingImplantsErrorState extends SettingsBlocErrorState {
  SettingsBloc_UpdatingImplantsErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_UpdatedImplantsSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingImplantLinesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingImplantLinesErrorState extends SettingsBlocErrorState {
  SettingsBloc_AddingImplantLinesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_AddedImplantLinesSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingImplantCompaniesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingImplantCompaniesErrorState extends SettingsBlocErrorState {
  SettingsBloc_AddingImplantCompaniesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_AddedImplantCompaniesSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingMembranesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingMembranesErrorState extends SettingsBlocErrorState {
  SettingsBloc_AddingMembranesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_AddedMembranesSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingTacsCompaniesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingTacsCompaniesErrorState extends SettingsBlocErrorState {
  SettingsBloc_AddingTacsCompaniesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_AddedTacsCompaniesSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingMembraneCompaniesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingMembraneCompaniesErrorState extends SettingsBlocErrorState {
  SettingsBloc_AddingMembraneCompaniesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_AddedMembraneCompaniesSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingExpensesCategoriesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingExpensesCategoriesErrorState extends SettingsBlocErrorState {
  SettingsBloc_AddingExpensesCategoriesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_AddedExpensesCategoriesSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingIncomeCategoriesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingIncomeCategoriesErrorState extends SettingsBlocErrorState {
  SettingsBloc_AddingIncomeCategoriesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_AddedIncomeCategoriesSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingSuppliersState extends SettingsBloc_States {
  final bool medical;
  SettingsBloc_AddingSuppliersState({required this.medical});
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingSuppliersErrorState extends SettingsBlocErrorState {
  final bool medical;
  SettingsBloc_AddingSuppliersErrorState({required super.message,required this.medical});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_AddedSuppliersSuccessfullyState extends SettingsBlocSuccessState {
  final bool medical;
  SettingsBloc_AddedSuppliersSuccessfullyState({required this.medical});
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingStockCategoriesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingStockCategoriesErrorState extends SettingsBlocErrorState {
  SettingsBloc_AddingStockCategoriesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_AddedStockCategoriesSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingPaymentMethodsState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_AddingPaymentMethodsErrorState extends SettingsBlocErrorState {
  SettingsBloc_AddingPaymentMethodsErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_AddedPaymentMethodsSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_EditingRoomsState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_EditingRoomsErrorState extends SettingsBlocErrorState {
  SettingsBloc_EditingRoomsErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_EditedRoomsSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_EditingTreatmentPricesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_EditingTreatmentPricesErrorState extends SettingsBlocErrorState {
  SettingsBloc_EditingTreatmentPricesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_EditedTreatmentPricesSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_EditingClinicPricesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_EditingClinicPricesErrorState extends SettingsBlocErrorState {
  SettingsBloc_EditingClinicPricesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_EditedClinicPricesSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}
class SettingsBloc_LoadingClinicPricesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingClinicPricesErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingClinicPricesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedClinicPricesSuccessfullyState extends SettingsBlocSuccessState {
  final List<ClinicPriceEntity> data;
  SettingsBloc_LoadedClinicPricesSuccessfullyState({required this.data});
  @override
  List<Object?> get props => [data];
}
class SettingsBloc_LoadingLabItemParentsState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingLabItemParentsErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingLabItemParentsErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedLabItemParentsSuccessfullyState extends SettingsBlocSuccessState {
  final List<LabItemParentEntity> data;
  SettingsBloc_LoadedLabItemParentsSuccessfullyState({required this.data});
  @override
  List<Object?> get props => [data,identityHashCode(this)];
}
class SettingsBloc_LoadingLabItemsState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingLabItemsErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingLabItemsErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedLabItemsSuccessfullyState extends SettingsBlocSuccessState {
  final List<LabItemEntity> data;
  SettingsBloc_LoadedLabItemsSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [data,identityHashCode(this)];
}

class SettingsBloc_LoadingLabItemsShadesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingLabItemsShadesErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingLabItemsShadesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedLabItemsShadesSuccessfullyState extends SettingsBlocSuccessState {
  final List<BasicNameIdObjectEntity> data;
  SettingsBloc_LoadedLabItemsShadesSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [data,identityHashCode(this)];
}

class SettingsBloc_LoadingLabItemsCompaniesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadingLabItemsCompaniesErrorState extends SettingsBlocErrorState {
  SettingsBloc_LoadingLabItemsCompaniesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_LoadedLabItemsCompaniesSuccessfullyState extends SettingsBlocSuccessState {
  final List<BasicNameIdObjectEntity> data;
  SettingsBloc_LoadedLabItemsCompaniesSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [data,identityHashCode(this)];
}



class SettingsBloc_UpdatingLabItemsCompaniesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_UpdatingLabItemsCompaniesErrorState extends SettingsBlocErrorState {
  SettingsBloc_UpdatingLabItemsCompaniesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_UpdatedLabItemsCompaniesSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}
class SettingsBloc_UpdatingLabItemsShadesState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_UpdatingLabItemsShadesErrorState extends SettingsBlocErrorState {
  SettingsBloc_UpdatingLabItemsShadesErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_UpdatedLabItemsShadesSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}
class SettingsBloc_UpdatingLabItemsState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_UpdatingLabItemsErrorState extends SettingsBlocErrorState {
  SettingsBloc_UpdatingLabItemsErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_UpdatedLabItemsSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_UpdatingLabItemsParentsPriceParentsPriceParentsPriceState extends SettingsBloc_States {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_UpdatingLabItemsParentsPriceParentsPriceErrorState extends SettingsBlocErrorState {
  SettingsBloc_UpdatingLabItemsParentsPriceParentsPriceErrorState({required super.message});

  @override
  List<Object?> get props => [message];
}

class SettingsBloc_UpdatedLabItemsParentsPriceParentsPriceSuccessfullyState extends SettingsBlocSuccessState {
  @override
  List<Object?> get props => [];
}

