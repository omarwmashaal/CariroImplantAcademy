import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:dartz/dartz.dart';

class UpdateLabItemsCompaniesUseCase extends UseCases<NoParams, UpdateLabItemsCompaniesParams> {
  final SettingsRepository settingsRepository;

  UpdateLabItemsCompaniesUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(UpdateLabItemsCompaniesParams params) async {
    return await settingsRepository.updateLabItemsCompanies(params.parentItemId,params.data).then((value) => value.fold(
          (l) => Left(l..message = "Update Lab Items Companies:"),
          (r) => Right(r),
        ));
  }
}

class UpdateLabItemsCompaniesParams{
  final int parentItemId;
  final List<BasicNameIdObjectEntity> data;
  UpdateLabItemsCompaniesParams({required this.parentItemId,required this.data});
 }
