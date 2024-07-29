import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:dartz/dartz.dart';

class GetProstheticTechniqueUseCase extends LoadingUseCases<GetProstheticTechniqueParams> {
  final SettingsRepository settingsRepository;
  GetProstheticTechniqueUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(GetProstheticTechniqueParams params) async {
    return await settingsRepository.getProsthticTechnique(params.type, params.itemId);
  }
}

class GetProstheticTechniqueParams {
  final int itemId;
  final EnumProstheticType type;
  GetProstheticTechniqueParams({
    required this.itemId,
    required this.type,
  });
}
