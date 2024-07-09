import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:dartz/dartz.dart';

class GetProstheticMaterialUseCase extends LoadingUseCases<GetProstheticMaterialParams> {
  final SettingsRepository settingsRepository;
  GetProstheticMaterialUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(GetProstheticMaterialParams params) async {
    return await settingsRepository.getProsthticMaterial(params.type, params.itemId);
  }
}

class GetProstheticMaterialParams {
  final int itemId;
  final EnumProstheticType type;
  GetProstheticMaterialParams({
    required this.itemId,
    required this.type,
  });
}
