import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../features/labRequest/domain/entities/labItemParentEntity.dart';

class UpdateLabItemsParentsPriceUseCase extends UseCases<NoParams, UpdateLabItemsParentsPriceParams> {
  final SettingsRepository settingsRepository;

  UpdateLabItemsParentsPriceUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(UpdateLabItemsParentsPriceParams params) async {
    return await settingsRepository.updateLabItemsParentsPrice(params.parentItemId,params.price).then((value) => value.fold(
          (l) => Left(l..message = "Update Lab Items Parents Price:"),
          (r) => Right(r),
        ));
  }
}

class UpdateLabItemsParentsPriceParams{
  final int parentItemId;
  final int price;
  UpdateLabItemsParentsPriceParams({required this.parentItemId,required this.price});
 }
