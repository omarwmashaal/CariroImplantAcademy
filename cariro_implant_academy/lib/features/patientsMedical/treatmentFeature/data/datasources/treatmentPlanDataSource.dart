import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/treatmentPlanModel.dart';

import '../../../../../../core/Http/httpRepo.dart';
import '../../../../../../core/constants/remoteConstants.dart';
import '../../../../../../core/error/exception.dart';
import '../../domain/entities/teethTreatmentPlan.dart';
import '../../domain/entities/treatmentPlanEntity.dart';
import '../models/teethTreatmentPlanModel.dart';

abstract class TreatmentPlanDataSource {
  Future<TreatmentPlanEntity> getTreatmentPlanData(int id);

  Future<NoParams> saveTreatmentPlanData(
    int id,
    List<TeethTreatmentPlanEntity> data, {
    bool clearnceUpper = false,
    bool clearanceLower = false,
  });

  Future<NoParams> consumeImplant(int id);
}

class TreatmentPlanDatasourceImpl implements TreatmentPlanDataSource {
  final HttpRepo httpRepo;

  TreatmentPlanDatasourceImpl({required this.httpRepo});

  @override
  Future<TreatmentPlanEntity> getTreatmentPlanData(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetPatientTreatmentPlan?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body != null)
        return TreatmentPlanModel.fromJson(response.body as Map<String, dynamic>);
      else
        return TreatmentPlanModel(patientId: id, treatmentPlan: []);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> saveTreatmentPlanData(
    int id,
    List<TeethTreatmentPlanEntity> data, {
    bool clearnceUpper = false,
    bool clearanceLower = false,
  }) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$medicalController/UpdatePatientTreatmentPlan?id=$id&clearanceLower=$clearanceLower&clearanceUpper=$clearnceUpper",
        body: data.map((e) => TeethTreatmentPlanModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> consumeImplant(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host: "$serverHost/$medicalController/ConsumeImplant?id=$id",
        //body: data.map((e) => TeethTreatmentPlanModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }
}
