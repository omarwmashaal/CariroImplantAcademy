import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/data/repositories/settingsRepoImpl.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:dartz/dartz.dart';

class UpdateProstheticItemsUseCase extends UseCases<NoParams, UpdateProstheticItemsParams> {
  final SettingsRepository settingsRepository;
  UpdateProstheticItemsUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, NoParams>> call(UpdateProstheticItemsParams data) async {
    data.data.removeWhere((element) => element.id==null &&  (element.name?.isEmpty ?? true));
    return await settingsRepository.updateProstheticItems(data.type, data.data);
  }
}

class UpdateProstheticItemsParams {
  final EnumProstheticType type;
  final List<BasicNameIdObjectEntity> data;
  UpdateProstheticItemsParams({
    required this.type,
    required this.data,
  });
}
