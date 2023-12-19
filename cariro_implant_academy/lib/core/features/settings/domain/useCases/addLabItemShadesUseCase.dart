import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:dartz/dartz.dart';

class UpdateLabItemsShadesUseCase extends UseCases<NoParams, UpdateLabItemsShadesParams> {
  final SettingsRepository settingsRepository;

  UpdateLabItemsShadesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(UpdateLabItemsShadesParams params) async {
    return await settingsRepository.updateLabItemsShades(params.companyId,params.data).then((value) => value.fold(
          (l) => Left(l..message = "Update Lab Items Shades:"),
          (r) => Right(r),
        ));
  }
}

class UpdateLabItemsShadesParams{
  final int companyId;
  final List<BasicNameIdObjectEntity> data;
  UpdateLabItemsShadesParams({required this.companyId,required this.data});
 }
