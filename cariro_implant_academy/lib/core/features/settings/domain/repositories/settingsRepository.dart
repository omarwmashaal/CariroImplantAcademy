import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/implantEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/tacEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failure.dart';
import '../entities/membraneCompanyEnity.dart';

abstract class SettingsRepository{
  Future<Either<Failure,TreatmentPricesEntity>> getTreatmentPrices();
  Future<Either<Failure,List<TacCompanyEntity>>> getTacs();
  Future<Either<Failure,List<MembraneCompanyEntity>>> getMembraneCompanies();
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getMembranes(int id);
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getImplantCompanies();
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> getImplantLines(int id);
  Future<Either<Failure,List<ImplantEntity>>> getImplants(int id);
}