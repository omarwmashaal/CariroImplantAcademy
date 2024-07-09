import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:dartz/dartz.dart';

class UpdateProstheticMaterialUseCase extends UseCases<NoParams, UpdateProstheticMaterialParams> {
  final SettingsRepository settingsRepository;
  UpdateProstheticMaterialUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, NoParams>> call(UpdateProstheticMaterialParams params) async {
    params.data.removeWhere((element) => element.id == null && (element.name?.isEmpty ?? true));

    return await settingsRepository.updateProstheticMaterial(params.type, params.itemId, params.data);
  }
}

class UpdateProstheticMaterialParams {
  final int itemId;
  final EnumProstheticType type;
  final List<BasicNameIdObjectEntity> data;
  UpdateProstheticMaterialParams({
    required this.itemId,
    required this.type,
    required this.data,
  });
}
