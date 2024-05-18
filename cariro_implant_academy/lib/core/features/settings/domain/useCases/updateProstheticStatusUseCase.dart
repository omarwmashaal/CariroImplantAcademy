import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:dartz/dartz.dart';

class UpdateProstheticStatusUseCase extends UseCases<NoParams, UpdateProstheticStatusParams> {
  final SettingsRepository settingsRepository;
  UpdateProstheticStatusUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, NoParams>> call(UpdateProstheticStatusParams params) async {
    return await settingsRepository.updateProstheticStatus(params.type, params.itemId,params.data);
  }
}

class UpdateProstheticStatusParams {
  final int itemId;
  final EnumProstheticType type;
  final List<BasicNameIdObjectEntity> data;
  UpdateProstheticStatusParams({
    required this.itemId,
    required this.type,
    required this.data,
  });
}
