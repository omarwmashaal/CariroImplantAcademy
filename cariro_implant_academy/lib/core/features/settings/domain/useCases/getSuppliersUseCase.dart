import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';

import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import '../../../../constants/enums/enums.dart';

class GetSuppliersUseCase extends LoadingUseCases<GetSuppliersParams> {
  final SettingsRepository settingsRepository;

  GetSuppliersUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(params) async {
    return await settingsRepository.getSuppliers(params.website, params.medical).then((value) => value.fold(
          (l) => Left(l..message = "Get Suppliers: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class GetSuppliersParams {
  final bool medical;
  final Website website;
  GetSuppliersParams({required this.medical, required this.website});
}
