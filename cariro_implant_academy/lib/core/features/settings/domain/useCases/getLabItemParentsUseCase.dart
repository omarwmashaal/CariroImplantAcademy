import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetLabItemParentsUseCase extends UseCases<List<BasicNameIdObjectEntity>, NoParams> {
  final SettingsRepository settingsRepository;

  GetLabItemParentsUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(NoParams params) async {
    return await settingsRepository.getLabItemParents().then((value) => value.fold(
          (l) => Left(l..message = "Get Lab Items:"),
          (r) => Right(r),
        ));
  }
}
