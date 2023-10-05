import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';
import 'package:equatable/equatable.dart';

import '../../../../../features/patient/domain/entities/roomEntity.dart';
import '../../../../domain/entities/BasicNameIdObjectEntity.dart';
import '../../domain/entities/treatmentPricesEntity.dart';
import '../../domain/useCases/addImplantsUseCase.dart';
import '../../domain/useCases/addMembranesUseCase.dart';

abstract class SettingsBloc_Events extends Equatable {}

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
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadNonMedicalNonStockExpensesCategoriesEvent extends SettingsBloc_Events {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadNonMedicalStockCategoriesEvent extends SettingsBloc_Events {
  @override
  List<Object?> get props => [];
}

class SettingsBloc_LoadSuppliersEvent extends SettingsBloc_Events {
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
  final List<BasicNameIdObjectEntity> model;

  SettingsBloc_AddSuppliersEvent({required this.model});

  @override
  List<Object?> get props => [model];
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
  final TreatmentPricesEntity prices;

  SettingsBloc_EditTreatmentPricesEvent({required this.prices});

  @override
  List<Object?> get props => [prices];
}

class SettingsBloc_LoadStockCategoriesEvent extends SettingsBloc_Events{
  @override
  List<Object?> get props => [];

}