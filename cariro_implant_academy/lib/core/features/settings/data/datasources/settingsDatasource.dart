import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/treatmentPricesModel.dart';

import '../../../../constants/remoteConstants.dart';
import '../../../../error/exception.dart';
import '../../domain/entities/treatmentPricesEntity.dart';

abstract class SettingsDatasource{
  Future<TreatmentPricesEntity> getTreatmentPrices();
}

class SettingsDatasourceImpl implements SettingsDatasource{
  final HttpRepo httpRepo;
  SettingsDatasourceImpl({required this.httpRepo});
  @override
  Future<TreatmentPricesEntity> getTreatmentPrices() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetTreatmentPrices");
    } catch(e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode);
    try {
      return TreatmentPricesModel.fromJson(response.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

}