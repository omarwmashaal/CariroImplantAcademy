import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/clinicPriceEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/implantEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../features/labRequest/domain/entities/labItemParentEntity.dart';
import '../../../../../features/patient/domain/entities/roomEntity.dart';
import '../../../../error/failure.dart';
import '../../../../useCases/useCases.dart';
import '../entities/membraneCompanyEnity.dart';
import '../useCases/addImplantsUseCase.dart';
import '../useCases/addMembranesUseCase.dart';

abstract class SettingsRepository{
  //Get Methods
  Future<Either<Failure,TreatmentPricesEntity>> getTreatmentPrices();
  Future<Either<Failure,List<TacCompanyEntity>>> getTacs();
  Future<Either<Failure,List<MembraneCompanyEntity>>> getMembraneCompanies();
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getMembranes(int id);
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getImplantCompanies();
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getImplantLines(int id);
  Future<Either<Failure,List<ImplantEntity>>> getImplants(int id);
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getIncomeCategories();
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getExpensesCategories();
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getPaymentMethods();
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getNonMedicalNonStockExpensesCategories();
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getNonMedicalStockCategories();
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getStockCategories();
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getMedicalExpensesCategories();
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getSuppliers();
  //Update Methods
  Future<Either<Failure,NoParams>> changeImplantCompanyName(BasicNameIdObjectEntity value);
  Future<Either<Failure,NoParams>> changeImplantLineName(BasicNameIdObjectEntity value);
  Future<Either<Failure,NoParams>> addImplants(UpdateImplantsParams value);
  Future<Either<Failure,NoParams>> addImplantLines(BasicNameIdObjectEntity value);
  Future<Either<Failure,NoParams>> addImplantCompanies( String name);
  Future<Either<Failure,NoParams>> addMembranes(AddMembraneParams value);
  Future<Either<Failure,NoParams>> addTacsCompanies( List<TacCompanyEntity> model);
  Future<Either<Failure,NoParams>> addMembraneCompanies( List<BasicNameIdObjectEntity> model);
  Future<Either<Failure,NoParams>> addExpensesCategories( List<BasicNameIdObjectEntity> model);
  Future<Either<Failure,NoParams>> addIncomeCategories( List<BasicNameIdObjectEntity> model);
  Future<Either<Failure,NoParams>> addSuppliers( List<BasicNameIdObjectEntity> model);
  Future<Either<Failure,NoParams>> addStockCategories( List<BasicNameIdObjectEntity> model);
  Future<Either<Failure,NoParams>> addPaymentMethods( List<BasicNameIdObjectEntity> model);
  Future<Either<Failure,NoParams>> editRooms( List<RoomEntity> model);
  Future<Either<Failure,NoParams>> editTreatmentPrices( TreatmentPricesEntity prices);
  Future<Either<Failure,List<ClinicPriceEntity>>> getTeethTreatmentPrices(List<int>? teeth,List<EnumClinicPrices>? category);
  Future<Either<Failure,NoParams>> updateTeethTreatmentPrices(List<ClinicPriceEntity> params);
  Future<Either<Failure,List<LabItemParentEntity>>> getLabItemParents();
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getLabItemCompanies(int id);
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getLabItemLines(int id);
  Future<Either<Failure,List<LabItemEntity>>> getLabItems(int id);
  Future<Either<Failure,NoParams>> updateLabItems(int shadeId,List<LabItemEntity> data);
  Future<Either<Failure,NoParams>> updateLabItemsShades(int companyId, List<BasicNameIdObjectEntity> data);
  Future<Either<Failure,NoParams>> updateLabItemsCompanies(int parentItemId, List<BasicNameIdObjectEntity> data);
  Future<Either<Failure,NoParams>> updateLabItemsParentsPrice(int parentItemId, int price);



}