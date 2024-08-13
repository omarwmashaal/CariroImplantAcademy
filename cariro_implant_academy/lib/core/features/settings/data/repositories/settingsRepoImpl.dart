import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/implantEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/labPricesForDoctorEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/labSizesThresholdEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/membraneCompanyEnity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/membraneEnity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/addImplantsUseCase.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemCompanyEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemShadeEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labOptionEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/roomEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../features/labRequest/domain/entities/labItemParentEntity.dart';
import '../../domain/entities/clinicPriceEntity.dart';
import '../../domain/useCases/addMembranesUseCase.dart';
import '../datasources/settingsDatasource.dart';

class SettingsRepoImpl implements SettingsRepository {
  final SettingsDatasource settingsDatasource;

  SettingsRepoImpl({required this.settingsDatasource});

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getImplantCompanies() async {
    try {
      final result = await settingsDatasource.getImplantCompanies();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getImplantLines(int id) async {
    try {
      final result = await settingsDatasource.getImplantLines(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ImplantEntity>>> getImplants(int id) async {
    try {
      final result = await settingsDatasource.getImplants(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<MembraneCompanyEntity>>> getMembraneCompanies() async {
    try {
      final result = await settingsDatasource.getMembraneCompanies();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<TacCompanyEntity>>> getTacs() async {
    try {
      final result = await settingsDatasource.getTacs();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<MembraneEntity>>> getMembranes(int id) async {
    try {
      final result = await settingsDatasource.getMembranes(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getExpensesCategories(Website website) async {
    try {
      final result = await settingsDatasource.getExpensesCategories(website);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getIncomeCategories() async {
    try {
      final result = await settingsDatasource.getIncomeCategories();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getPaymentMethods() async {
    try {
      final result = await settingsDatasource.getPaymentMethods();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getMedicalExpensesCategories(Website website) async {
    try {
      final result = await settingsDatasource.getMedicalExpensesCategories(website);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getNonMedicalNonStockExpensesCategories(Website website) async {
    try {
      final result = await settingsDatasource.getNonMedicalNonStockExpensesCategories(website);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getNonMedicalStockCategories(Website website) async {
    try {
      final result = await settingsDatasource.getNonMedicalStockCategories(website);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getSuppliers(Website website, bool medical) async {
    try {
      final result = await settingsDatasource.getSuppliers(website, medical);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addExpensesCategories(List<BasicNameIdObjectEntity> model) async {
    try {
      final result = await settingsDatasource.addExpensesCategories(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addImplantCompanies(String name) async {
    try {
      final result = await settingsDatasource.addImplantCompanies(name);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addImplantLines(BasicNameIdObjectEntity value) async {
    try {
      final result = await settingsDatasource.addImplantLines(value);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addImplants(UpdateImplantsParams value) async {
    try {
      final result = await settingsDatasource.addImplants(value);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addIncomeCategories(List<BasicNameIdObjectEntity> model) async {
    try {
      final result = await settingsDatasource.addIncomeCategories(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addMembraneCompanies(List<BasicNameIdObjectEntity> model) async {
    try {
      final result = await settingsDatasource.addMembraneCompanies(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addMembranes(AddMembraneParams value) async {
    try {
      final result = await settingsDatasource.addMembranes(value);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addPaymentMethods(List<BasicNameIdObjectEntity> model) async {
    try {
      final result = await settingsDatasource.addPaymentMethods(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addStockCategories(List<BasicNameIdObjectEntity> model) async {
    try {
      final result = await settingsDatasource.addStockCategories(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addSuppliers(List<BasicNameIdObjectEntity> model, bool medical) async {
    try {
      final result = await settingsDatasource.addSuppliers(model, medical);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addTacsCompanies(List<TacCompanyEntity> model) async {
    try {
      final result = await settingsDatasource.addTacsCompanies(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> changeImplantCompanyName(BasicNameIdObjectEntity value) async {
    try {
      final result = await settingsDatasource.changeImplantCompanyName(value);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> changeImplantLineName(BasicNameIdObjectEntity value) async {
    try {
      final result = await settingsDatasource.changeImplantLineName(value);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> editRooms(List<RoomEntity> model) async {
    try {
      final result = await settingsDatasource.editRooms(model);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> editTreatmentPrices(List<TreatmentItemEntity> prices) async {
    try {
      final result = await settingsDatasource.editTreatmentPrices(prices);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getStockCategories(Website website) async {
    try {
      final result = await settingsDatasource.getStockCategories(website);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ClinicPriceEntity>>> getTeethTreatmentPrices(List<int>? teeth, List<EnumClinicPrices>? category) async {
    try {
      final result = await settingsDatasource.getTeethTreatmentPrices(teeth, category);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateTeethTreatmentPrices(List<ClinicPriceEntity> params) async {
    try {
      final result = await settingsDatasource.updateTeethTreatmentPrices(params);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<LabItemParentEntity>>> getLabItemParents() async {
    try {
      final result = await settingsDatasource.getLabItemParents();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getLabItemComspanies(int id) async {
    try {
      final result = await settingsDatasource.getLabItemCompanies(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getProsthticItems(EnumProstheticType type) async {
    try {
      final result = await settingsDatasource.getProsthticItems(type);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getProsthticNextVisit(EnumProstheticType type, int itemId) async {
    try {
      final result = await settingsDatasource.getProsthticNextVisit(type, itemId);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getProsthticTechnique(EnumProstheticType type, int itemId) async {
    try {
      final result = await settingsDatasource.getProsthticTechnique(type, itemId);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getProsthticMaterial(EnumProstheticType type, int itemId) async {
    try {
      final result = await settingsDatasource.getProsthticMaterial(type, itemId);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getProsthticStatus(EnumProstheticType type, int itemId) async {
    try {
      final result = await settingsDatasource.getProsthticStatus(type, itemId);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateProstheticItems(EnumProstheticType type, List<BasicNameIdObjectEntity> data) async {
    try {
      final result = await settingsDatasource.updateProstheticItems(type, data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateProstheticNextVisit(EnumProstheticType type, int itemId, List<BasicNameIdObjectEntity> data) async {
    try {
      final result = await settingsDatasource.updateProstheticNextVisit(type, itemId, data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateProstheticTechnique(EnumProstheticType type, int itemId, List<BasicNameIdObjectEntity> data) async {
    try {
      final result = await settingsDatasource.updateProstheticTechnique(type, itemId, data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateProstheticMaterial(EnumProstheticType type, int itemId, List<BasicNameIdObjectEntity> data) async {
    try {
      final result = await settingsDatasource.updateProstheticMaterial(type, itemId, data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateProstheticStatus(EnumProstheticType type, int itemId, List<BasicNameIdObjectEntity> data) async {
    try {
      final result = await settingsDatasource.updateProstheticStatus(type, itemId, data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<LabItemCompanyEntity>>> getLabItemCompanies(int id) async {
    try {
      final result = await settingsDatasource.getLabItemCompanies(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<LabItemShadeEntity>>> getLabItemLines(int? parentId, int? companyId) async {
    try {
      final result = await settingsDatasource.getLabItemLines(parentId, companyId);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<LabItemEntity>>> getLabItems(int? parentId, int? companyId, int? shadeId) async {
    try {
      final result = await settingsDatasource.getLabItems(parentId, companyId, shadeId);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateLabItems(List<LabItemEntity> data) async {
    try {
      final result = await settingsDatasource.updateLabItems(data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateLabItemsCompanies(List<LabItemCompanyEntity> data) async {
    try {
      final result = await settingsDatasource.updateLabItemsCompanies(data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateLabItemsParents(List<LabItemParentEntity> data) async {
    try {
      final result = await settingsDatasource.updateLabItemsParents(data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateLabItemsShades(List<LabItemShadeEntity> data) async {
    try {
      final result = await settingsDatasource.updateLabItemsShades(data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<LabOptionEntity>>> getLabOptions(int? parentId, int? doctorId) async {
    try {
      final result = await settingsDatasource.getLabOptions(parentId, doctorId);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateLabOptions(List<LabOptionEntity> data) async {
    try {
      final result = await settingsDatasource.updateLabOptions(data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getDefaultSurgicalComplications() async {
    try {
      final result = await settingsDatasource.getDefaultSurgicalComplications();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateDefaultSurgicalComplications(List<BasicNameIdObjectEntity> value) async {
    try {
      final result = await settingsDatasource.updateDefaultSurgicalComplications(value);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> getDefaultProstheticComplications() async {
    try {
      final result = await settingsDatasource.getDefaultProstheticComplications();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateDefaultProstheticComplications(List<BasicNameIdObjectEntity> value) async {
    try {
      final result = await settingsDatasource.updateDefaultProstheticComplications(value);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateLabOptionsDoctorPriceList(List<LabPriceForDoctorEntity> data) async {
    try {
      final result = await settingsDatasource.updateLabOptionsDoctorPriceList(data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<LabSizesThresholdEntity>>> getLabThresholds(int parentId) async {
    try {
      final result = await settingsDatasource.getLabThresholds(parentId);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateLabThresholds(int parentId, List<LabSizesThresholdEntity> data) async {
    try {
      final result = await settingsDatasource.updateLabThresholds(parentId, data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
