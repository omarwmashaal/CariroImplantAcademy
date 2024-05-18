import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/data/repositories/settingsRepoImpl.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:dartz/dartz.dart';

class GetProstheticItemsUseCase extends LoadingUseCases<EnumProstheticType> {
  final SettingsRepository settingsRepository;
  GetProstheticItemsUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(EnumProstheticType type) async {
    return await settingsRepository.getProsthticItems(type);
  }
}
