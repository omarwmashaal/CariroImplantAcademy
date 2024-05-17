import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:dartz/dartz.dart';

class GetProstheticNextVisitUseCase extends LoadingUseCases<GetProstheticNextVisitParams> {
  final SettingsRepository settingsRepository;
  GetProstheticNextVisitUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> call(GetProstheticNextVisitParams params) async {
    return await settingsRepository.getProsthticNextVisit(params.type,params.itemId);
  }
}

class GetProstheticNextVisitParams {
  final int itemId;
  final EnumProstheticType type;
  GetProstheticNextVisitParams({
    required this.itemId,
    required this.type,
  });
}
