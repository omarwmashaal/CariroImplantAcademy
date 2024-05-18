import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:dartz/dartz.dart';

class UpdateProstheticNextVisitUseCase extends UseCases<NoParams, UpdateProstheticNextVisitParams> {
  final SettingsRepository settingsRepository;
  UpdateProstheticNextVisitUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, NoParams>> call(UpdateProstheticNextVisitParams params) async {
    params.data.removeWhere((element) => element.id==null &&  (element.name?.isEmpty ?? true));
  
    return await settingsRepository.updateProstheticNextVisit(params.type, params.itemId,params.data);
  }
}

class UpdateProstheticNextVisitParams {
  final int itemId;
  final EnumProstheticType type;
  final List<BasicNameIdObjectEntity> data;
  UpdateProstheticNextVisitParams({
    required this.itemId,
    required this.type,
    required this.data,
  });
}
