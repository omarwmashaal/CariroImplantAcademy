import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labOptionEntity.dart';
import 'package:dartz/dartz.dart';

class GetLabOptionsUseCase extends LoadingUseCases<GetLabOptionsParams> {
  final SettingsRepository settingsRepository;

  GetLabOptionsUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<LabOptionEntity>>> call(GetLabOptionsParams params) async {
    return await settingsRepository.getLabOptions(params.parentId, params.doctorId).then((value) => value.fold(
          (l) => Left(l..message = "Get Lab Options: ${l.message}"),
          (r) => Right(r),
        ));
  }
}

class GetLabOptionsParams {
  final int? parentId;
  final int? doctorId;
  GetLabOptionsParams({required this.doctorId, this.parentId});
}
