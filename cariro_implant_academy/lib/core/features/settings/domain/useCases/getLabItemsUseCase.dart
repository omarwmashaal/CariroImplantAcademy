import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:dartz/dartz.dart';

class GetLabItemsUseCase extends LoadingUseCases<GetLabItemsParams> {
  final SettingsRepository settingsRepository;

  GetLabItemsUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<LabItemEntity>>> call(GetLabItemsParams params) async {
    return await settingsRepository.getLabItems(params.parentId,params.companyId,params.shadeId).then((value) => value.fold(
          (l) => Left(l..message = "Get Lab Items: ${l.message}"),
          (r) => Right(r),
        ));
  }
}

class GetLabItemsParams {
  int? parentId;
  int? companyId;
  int? shadeId;
  GetLabItemsParams({
    this.parentId,
    this.companyId,
    this.shadeId,
  });
  
}
