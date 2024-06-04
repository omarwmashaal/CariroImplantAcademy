import 'package:dartz/dartz.dart';

import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemShadeEntity.dart';

class GetLabItemsLinesUseCase extends LoadingUseCases<GetLabItemsLinesParams> {
  final SettingsRepository settingsRepository;

  GetLabItemsLinesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<LabItemShadeEntity>>> call(GetLabItemsLinesParams params) async {
    return await settingsRepository.getLabItemLines(params.parentId,params.companyId).then((value) => value.fold(
          (l) => Left(l..message = "Get Lab Lines:"),
          (r) => Right(r),
        ));
  }
}

class GetLabItemsLinesParams {
  int? parentId;
  int? companyId;
  GetLabItemsLinesParams({
    this.parentId,
    this.companyId,
  });
  
}
