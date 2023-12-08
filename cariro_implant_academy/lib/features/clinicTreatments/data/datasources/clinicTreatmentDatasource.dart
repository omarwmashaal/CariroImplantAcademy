import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/data/models/clinicTreatmentModel.dart';

import '../../../../core/Http/httpRepo.dart';
import '../../../../core/constants/remoteConstants.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/clinicTreatmentEntity.dart';
import '../models/clinicDoctorPercentageModel.dart';

abstract class ClinicTreatmentDatasource {
  Future<ClinicTreatmentModel> getTreatment(int id);

  Future<NoParams> updateTreatment(int id, ClinicTreatmentEntity model);

  Future<NoParams> updateClinicReceipt(int patientId, int treatmentId);

  Future<List<ClinicDoctorPercentageModel>> getDoctorPercentageForPatient(int id);
}

class ClinicTreatmentDataSourceImpl implements ClinicTreatmentDatasource {
  final HttpRepo httpRepo;

  ClinicTreatmentDataSourceImpl({required this.httpRepo});

  @override
  Future<ClinicTreatmentModel> getTreatment(int id) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.get(host: "$serverHost/$clinicTreatmentController/GetTreatment?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      return ClinicTreatmentModel.fromJson(result.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException();
    }
  }

  @override
  Future<NoParams> updateTreatment(int id, ClinicTreatmentEntity model) async {
    late StandardHttpResponse result;
    try {
      result =
          await httpRepo.post(host: "$serverHost/$clinicTreatmentController/UpdateTreatment?id=$id", body: ClinicTreatmentModel.fromEntity(model).toJson());
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    return NoParams();
  }

  @override
  Future<List<ClinicDoctorPercentageModel>> getDoctorPercentageForPatient(int id) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.get(host: "$serverHost/$clinicTreatmentController/getDoctorPercentageForPatient?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      return ((result.body ?? []) as List<dynamic>).map((e) => ClinicDoctorPercentageModel.fromMap(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException();
    }
  }

  @override
  Future<NoParams> updateClinicReceipt(int patientId, int treatmentId) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.post(
        host: "$serverHost/$clinicTreatmentController/UpdateReceipt?patientId=$patientId&treatmentId=$treatmentId",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    return NoParams();
  }
}
