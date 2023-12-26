import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetLabItemsLinesUseCase extends LoadingUseCases<int> {
  final SettingsRepository settingsRepository;

  GetLabItemsLinesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(int id) async {
    return await settingsRepository.getLabItemLines(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Lab Lines:"),
          (r) => Right(r),
        ));
  }
}
