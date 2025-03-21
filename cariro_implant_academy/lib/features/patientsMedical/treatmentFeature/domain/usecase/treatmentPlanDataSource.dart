import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/treatmentDetailsModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/treatmentItemModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/treatmentPlanModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';

import '../../../../../../core/Http/httpRepo.dart';
import '../../../../../../core/constants/remoteConstants.dart';
import '../../../../../../core/error/exception.dart';
import '../../domain/entities/treatmentPlanEntity.dart';

abstract class TreatmentPlanDataSource {
  Future<TreatmentPlanEntity> getTreatmentPlanData(int id);
  Future<List<TreatmentDetailsModel>> getPatientTreatmentDetails(int id);

  Future<NoParams> saveTreatmentDetailsData(int id, List<TreatmentDetailsEntity> data);
  Future<NoParams> saveTreatmentPlan(int id, TreatmentPlanEntity data);
  Future<List<TreatmentItemModel>> getTreatmentItems();

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
  Future<List<TreatmentDetailsModel>> getPatientTreatmentDetails(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetPatientTreatmentDetails?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body != null)
        return ((response.body ?? []) as List<dynamic>).map((e) => TreatmentDetailsModel.fromJson(e as Map<String, dynamic>)).toList();
      else
        return [];
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> saveTreatmentDetailsData(int id, List<TreatmentDetailsEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$medicalController/UpdatePatientTreatmentDetails?id=$id",
        body: data.map((e) => TreatmentDetailsModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> saveTreatmentPlan(int id, TreatmentPlanEntity data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$medicalController/UpdatePatientTreatmentPlan?id=$id",
        body: TreatmentPlanModel.fromEntity(data).toJson(),
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

  @override
  Future<List<TreatmentItemModel>> getTreatmentItems() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetTreatmentItems");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body != null)
        return ((response.body ?? []) as List<dynamic>).map((e) => TreatmentItemModel.fromJson(e as Map<String, dynamic>)).toList();
      else
        return [];
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }
}
