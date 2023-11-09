import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/clinicPriceEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetTeethClinicPrices extends UseCases<List<ClinicPriceEntity>,GetTeethClinicPircesParams>
{
  final SettingsRepository settingsRepository;
  GetTeethClinicPrices({required this.settingsRepository});
  @override
  Future<Either<Failure, List<ClinicPriceEntity>>> call(GetTeethClinicPircesParams params) async{
    return await settingsRepository.getTeethTreatmentPrices(params.teeth, params.category);
  }

}



class GetTeethClinicPircesParams{
  final List<int>? teeth;
  final EnumClinicPrices category;

  const GetTeethClinicPircesParams({
    this.teeth,
    required this.category,
  });

}