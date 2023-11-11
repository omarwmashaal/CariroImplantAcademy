import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/clinicPriceEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class UpdateTeethClinicPricesUseCase extends UseCases<NoParams,List<ClinicPriceEntity>>
{
  final SettingsRepository settingsRepository;
  UpdateTeethClinicPricesUseCase({required this.settingsRepository});
  @override
  Future<Either<Failure, NoParams>> call(List<ClinicPriceEntity> params) async{
    return await settingsRepository.updateTeethTreatmentPrices(params);
  }

}

