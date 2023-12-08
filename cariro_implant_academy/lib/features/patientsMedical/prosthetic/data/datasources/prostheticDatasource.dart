import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/prostheticModel.dart';

import '../../../../../core/constants/remoteConstants.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/useCases/useCases.dart';
import '../../domain/entities/prostheticEntity.dart';
import '../../domain/entities/prostheticTreatmentFinalEntity.dart';
import '../models/prostheticTreatmentFinalModel.dart';

abstract class ProstheticDatasource {
  Future<ProstheticTreatmentModel> getPatientProstheticTreatmentDiagnostic(int id);

  Future<ProstheticTreatmentFinalModel> getPatientProstheticTreatmentFinalProthesisSingleBridge(int id);

  Future<ProstheticTreatmentFinalModel> getPatientProstheticTreatmentFinalProthesisFullArch(int id);

  Future<NoParams> updatePatientProstheticTreatmentDiagnostic(ProstheticTreatmentEntity data);

  Future<NoParams> updatePatientProstheticTreatmentFinalProthesisSingleBridge(ProstheticTreatmentFinalEntity data);

  Future<NoParams> updatePatientProstheticTreatmentFinalProthesisFullArch(ProstheticTreatmentFinalEntity data);
}

class ProstheticDatasourceImpl implements ProstheticDatasource {
  final HttpRepo httpRepo;

  ProstheticDatasourceImpl({required this.httpRepo});

  @override
  Future<ProstheticTreatmentModel> getPatientProstheticTreatmentDiagnostic(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetPatientProstheticTreatmentDiagnostic?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body == null) return ProstheticTreatmentModel();
      return ProstheticTreatmentModel.fromJson(response.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<ProstheticTreatmentFinalModel> getPatientProstheticTreatmentFinalProthesisFullArch(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetPatientProstheticTreatmentFinalProthesisFullArch?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body == null)
        return ProstheticTreatmentFinalModel(
          patientId: id,
        );
      return ProstheticTreatmentFinalModel.fromMap(response.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<ProstheticTreatmentFinalModel> getPatientProstheticTreatmentFinalProthesisSingleBridge(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetPatientProstheticTreatmentFinalProthesisSingleBridge?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body == null)
        return ProstheticTreatmentFinalModel(
          patientId: id,
        );
      return ProstheticTreatmentFinalModel.fromMap(response.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> updatePatientProstheticTreatmentDiagnostic(ProstheticTreatmentEntity data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$medicalController/UpdatePatientProstheticTreatmentDiagnostic?id=${data.id}",
        body: ProstheticTreatmentModel.fromEntity(data).toJson(),
      );
    } catch (e) {
      print(e);
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updatePatientProstheticTreatmentFinalProthesisFullArch(ProstheticTreatmentFinalEntity data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$medicalController/UpdatePatientProstheticTreatmentFinalProthesis?id=${data.patientId}&type=1",
        body: ProstheticTreatmentFinalModel.fromEntity(data).toJson(),
      );
    } catch (e) {
      print(e);
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updatePatientProstheticTreatmentFinalProthesisSingleBridge(ProstheticTreatmentFinalEntity data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$medicalController/UpdatePatientProstheticTreatmentFinalProthesis?id=${data.patientId}&type=0",
        body: ProstheticTreatmentFinalModel.fromEntity(data).toJson(),
      );
    } catch (e) {
      print(e);
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }
}
