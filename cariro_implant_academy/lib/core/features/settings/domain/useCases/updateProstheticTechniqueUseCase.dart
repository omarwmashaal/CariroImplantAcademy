import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:dartz/dartz.dart';

class UpdateProstheticTechniqueUseCase extends UseCases<NoParams, UpdateProstheticTechniqueParams> {
  final SettingsRepository settingsRepository;
  UpdateProstheticTechniqueUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, NoParams>> call(UpdateProstheticTechniqueParams params) async {
    params.data.removeWhere((element) => element.id==null &&  (element.name?.isEmpty ?? true));
  
    return await settingsRepository.updateProstheticTechnique(params.type, params.itemId,params.data);
  }
}

class UpdateProstheticTechniqueParams {
  final int itemId;
  final EnumProstheticType type;
  final List<BasicNameIdObjectEntity> data;
  UpdateProstheticTechniqueParams({
    required this.itemId,
    required this.type,
    required this.data,
  });
}
