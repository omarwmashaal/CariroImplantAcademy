import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/implantEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/treatmentPricesEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class AddImplantsUseCase extends UseCases<NoParams, UpdateImplantsParams> {
  final SettingsRepository settingsRepository;

  AddImplantsUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, NoParams>> call(UpdateImplantsParams value) async {
    return await settingsRepository.addImplants(value).then((value) => value.fold(
          (l) => Left(l..message = "Add Implats: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
class UpdateImplantsParams{
  final int lineId;
  final List<ImplantEntity> data;
  UpdateImplantsParams({required this.lineId,required this.data});
}

class BasicIdWithList {
  final int id;
  final List<BasicNameIdObjectEntity> data;

  BasicIdWithList({
    required this.data,
    required this.id,
  });
}
