import 'package:cariro_implant_academy/core/features/settings/domain/entities/clinicPriceEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addLabItemCompaniesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addSuppliersUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getProstheticNextVisitUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getProstheticStatusUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getSuppliersUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getTeethClinicPrice.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../../features/patient/domain/entities/roomEntity.dart';
import '../../../../constants/enums/enums.dart';
import '../../../../domain/entities/BasicNameIdObjectEntity.dart';

import '../../domain/useCases/addImplantsUseCase.dart';
import '../../domain/useCases/addLabItemShadesUseCase.dart';
import '../../domain/useCases/addLabItemsUseCase.dart';
import '../../domain/useCases/addMembranesUseCase.dart';
import '../../domain/useCases/updateLabItemParentsPriceUseCase.dart';

abstract class SettingsBloc_Events extends Equatable {}

class SettingsBloc_LoadLabItemsEvent extends SettingsBloc_Events {
  final int shadeId;
  SettingsBloc_LoadLabItemsEvent({required this.shadeId});
  @override
  List<Object?> get props => [shadeId];
}

class SettingsBloc_LoadLabItemsCompaniesEvent extends SettingsBloc_Events {
  final int id;
  SettingsBloc_LoadLabItemsCompaniesEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class SettingsBloc_LoadLabItemsShadesEvent extends SettingsBloc_Events {
  final int companyId;
  SettingsBloc_LoadLabItemsShadesEvent({required this.companyId});
  @override
  List<Object?> get props => [companyId];
}

class SettingsBloc_LoadLabItemsParentsEvent extends SettingsBloc_Events {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadLabItemCompaniesEvent extends SettingsBloc_Events {
  final int id;
  SettingsBloc_LoadLabItemCompaniesEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class SettingsBloc_LoadImplantCompaniesEvent extends SettingsBloc_Events {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadImplantLinesEvent extends SettingsBloc_Events {
  final int companyId;

  SettingsBloc_LoadImplantLinesEvent({required this.companyId});

  @override
  List<Object?> get props => [companyId];
}

class SettingsBloc_LoadImplantsEvent extends SettingsBloc_Events {
  final int lineId;

  SettingsBloc_LoadImplantsEvent({required this.lineId});

  @override
  List<Object?> get props => [lineId];
}

class SettingsBloc_LoadTreatmentPricesEvent extends SettingsBloc_Events {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadTacsEvent extends SettingsBloc_Events {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadMembraneCompaniesEvent extends SettingsBloc_Events {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadMembranesEvent extends SettingsBloc_Events {
  final int id;

  SettingsBloc_LoadMembranesEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class SettingsBloc_LoadIncomeCategoriesEvent extends SettingsBloc_Events {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadExpensesCategoriesEvent extends SettingsBloc_Events {
  final Website website;
  SettingsBloc_LoadExpensesCategoriesEvent({required this.website});
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadPaymentMethodsEvent extends SettingsBloc_Events {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadRoomsEvent extends SettingsBloc_Events {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadMedicalExpensesCategoriesEvent extends SettingsBloc_Events {
  final Website website;
  SettingsBloc_LoadMedicalExpensesCategoriesEvent({required this.website});
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadNonMedicalNonStockExpensesCategoriesEvent extends SettingsBloc_Events {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadNonMedicalStockCategoriesEvent extends SettingsBloc_Events {
  final Website website;
  SettingsBloc_LoadNonMedicalStockCategoriesEvent({required this.website});
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadSuppliersEvent extends SettingsBloc_Events {
  final GetSuppliersParams params;
  SettingsBloc_LoadSuppliersEvent({required this.params});
  @override
  List<Object?> get props => [];
}

class SettingsBloc_ChangeImplantCompanyNameEvent extends SettingsBloc_Events {
  final BasicNameIdObjectEntity value;

  SettingsBloc_ChangeImplantCompanyNameEvent({required this.value});

  @override
  List<Object?> get props => [value];
}

class SettingsBloc_ChangeImplantLineNameEvent extends SettingsBloc_Events {
  final BasicNameIdObjectEntity value;

  SettingsBloc_ChangeImplantLineNameEvent({required this.value});

  @override
  List<Object?> get props => [value];
}

class SettingsBloc_UpdateImplantsEvent extends SettingsBloc_Events {
  final UpdateImplantsParams value;

  SettingsBloc_UpdateImplantsEvent({required this.value});

  @override
  List<Object?> get props => [value];
}

class SettingsBloc_AddImplantLinesEvent extends SettingsBloc_Events {
  final BasicNameIdObjectEntity value;

  SettingsBloc_AddImplantLinesEvent({required this.value});

  @override
  List<Object?> get props => [value];
}

class SettingsBloc_AddImplantCompaniesEvent extends SettingsBloc_Events {
  final String name;

  SettingsBloc_AddImplantCompaniesEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

class SettingsBloc_AddMembranesEvent extends SettingsBloc_Events {
  final AddMembraneParams value;

  SettingsBloc_AddMembranesEvent({required this.value});

  @override
  List<Object?> get props => [value];
}

class SettingsBloc_AddTacsCompaniesEvent extends SettingsBloc_Events {
  final List<TacCompanyEntity> model;

  SettingsBloc_AddTacsCompaniesEvent({required this.model});

  @override
  List<Object?> get props => [model];
}

class SettingsBloc_AddMembraneCompaniesEvent extends SettingsBloc_Events {
  final List<BasicNameIdObjectEntity> model;

  SettingsBloc_AddMembraneCompaniesEvent({required this.model});

  @override
  List<Object?> get props => [model];
}

class SettingsBloc_AddExpensesCategoriesEvent extends SettingsBloc_Events {
  final List<BasicNameIdObjectEntity> model;

  SettingsBloc_AddExpensesCategoriesEvent({required this.model});

  @override
  List<Object?> get props => [model];
}

class SettingsBloc_AddIncomeCategoriesEvent extends SettingsBloc_Events {
  final List<BasicNameIdObjectEntity> model;

  SettingsBloc_AddIncomeCategoriesEvent({required this.model});

  @override
  List<Object?> get props => [model];
}

class SettingsBloc_AddSuppliersEvent extends SettingsBloc_Events {
  final AddSuppliersParams params;

  SettingsBloc_AddSuppliersEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class SettingsBloc_AddStockCategoriesEvent extends SettingsBloc_Events {
  final List<BasicNameIdObjectEntity> model;

  SettingsBloc_AddStockCategoriesEvent({required this.model});

  @override
  List<Object?> get props => [model];
}

class SettingsBloc_AddPaymentMethodsEvent extends SettingsBloc_Events {
  final List<BasicNameIdObjectEntity> model;

  SettingsBloc_AddPaymentMethodsEvent({required this.model});

  @override
  List<Object?> get props => [model];
}

class SettingsBloc_EditRoomsEvent extends SettingsBloc_Events {
  final List<RoomEntity> model;

  SettingsBloc_EditRoomsEvent({required this.model});

  @override
  List<Object?> get props => [model];
}

class SettingsBloc_EditTreatmentPricesEvent extends SettingsBloc_Events {
  final List<TreatmentItemEntity> prices;

  SettingsBloc_EditTreatmentPricesEvent({required this.prices});

  @override
  List<Object?> get props => [prices];
}

class SettingsBloc_LoadStockCategoriesEvent extends SettingsBloc_Events {
  final Website website;
  SettingsBloc_LoadStockCategoriesEvent({required this.website});
  @override
  List<Object?> get props => [];
}

class SettingsBloc_EditClinicPricesEvent extends SettingsBloc_Events {
  final List<ClinicPriceEntity> prices;

  SettingsBloc_EditClinicPricesEvent({required this.prices});

  @override
  List<Object?> get props => [prices];
}

class SettingsBloc_LoadClinicPricesEvent extends SettingsBloc_Events {
  final GetTeethClinicPircesParams params;
  SettingsBloc_LoadClinicPricesEvent({required this.params});
  @override
  List<Object?> get props => [params];
}

class SettingsBloc_UpdateLabItemCompaniesEvent extends SettingsBloc_Events {
  final UpdateLabItemsCompaniesParams params;
  SettingsBloc_UpdateLabItemCompaniesEvent({required this.params});
  @override
  List<Object?> get props => [params];
}

class SettingsBloc_UpdateLabItemShadesEvent extends SettingsBloc_Events {
  final UpdateLabItemsShadesParams params;
  SettingsBloc_UpdateLabItemShadesEvent({required this.params});
  @override
  List<Object?> get props => [params];
}

class SettingsBloc_UpdateLabItemEvent extends SettingsBloc_Events {
  final UpdateLabItemsParams params;
  SettingsBloc_UpdateLabItemEvent({required this.params});
  @override
  List<Object?> get props => [params];
}

class SettingsBloc_UpdateLabItemParentPriceEvent extends SettingsBloc_Events {
  final UpdateLabItemsParentsPriceParams params;
  SettingsBloc_UpdateLabItemParentPriceEvent({required this.params});
  @override
  List<Object?> get props => [params];
}

class SettingsBloc_GetProstheticItemsEvent extends SettingsBloc_Events {
  final EnumProstheticType type;
  SettingsBloc_GetProstheticItemsEvent({required this.type});
  @override
  List<Object?> get props => [type];
}

class SettingsBloc_GetProstheticStatusEvent extends SettingsBloc_Events {
  final GetProstheticStatusParams params;
  SettingsBloc_GetProstheticStatusEvent({required this.params});
  @override
  List<Object?> get props => [params];
}

class SettingsBloc_GetProstheticNextVisitEvent extends SettingsBloc_Events {
  final GetProstheticNextVisitParams params;
  SettingsBloc_GetProstheticNextVisitEvent({required this.params});
  @override
  List<Object?> get props => [params];
}

