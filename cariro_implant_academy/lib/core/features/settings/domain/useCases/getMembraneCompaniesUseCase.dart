import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/membraneCompanyEnity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetMembraneCompaniesUseCase extends LoadingUseCases {
  final SettingsRepository settingsRepository;

  GetMembraneCompaniesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<MembraneCompanyEntity>>> call(NoParams) async {
    return await settingsRepository.getMembraneCompanies().then((value) => value.fold(
          (l) => Left(l..message = "Get Membrane Companies: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
