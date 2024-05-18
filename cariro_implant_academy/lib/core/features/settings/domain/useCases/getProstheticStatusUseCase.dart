import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:dartz/dartz.dart';

class GetProstheticStatusUseCase extends LoadingUseCases<GetProstheticStatusParams> {
  final SettingsRepository settingsRepository;
  GetProstheticStatusUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(GetProstheticStatusParams params) async {
    return await settingsRepository.getProsthticStatus(params.type,params.itemId);
  }
}

class GetProstheticStatusParams {
  final int itemId;
  final EnumProstheticType type;
  GetProstheticStatusParams({
    required this.itemId,
    required this.type,
  });
}
