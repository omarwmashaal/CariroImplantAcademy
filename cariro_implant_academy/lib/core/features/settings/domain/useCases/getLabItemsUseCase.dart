import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:dartz/dartz.dart';

class GetLabItemsUseCase extends LoadingUseCases<int> {
  final SettingsRepository settingsRepository;

  GetLabItemsUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<LabItemEntity>>> call(int id) async {
    return await settingsRepository.getLabItems(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Lab Items: ${l.message}"),
          (r) => Right(r),
        ));
  }
}
