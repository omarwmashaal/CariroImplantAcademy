import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/prostheticModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/prostheticStepModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticStepEntity.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/remoteConstants.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/useCases/useCases.dart';
import '../../domain/entities/prostheticDiagnosticEntity.dart';
import '../../domain/entities/prostheticFinalEntity.dart';
import '../models/prostheticTreatmentFinalModel.dart';

abstract class ProstheticDatasource {
  Future<List<ProstheticStepModel>> getPatientProstheticTreatmentDiagnostic(int id);

  Future<List<ProstheticStepModel>> getPatientProstheticTreatmentFinalProthesisSingleBridge(int id);

  Future<List<ProstheticStepModel>> getPatientProstheticTreatmentFinalProthesisFullArch(int id);

  Future<NoParams> updatePatientProstheticTreatmentDiagnostic(List<ProstheticStepEntity> data);

  Future<NoParams> updatePatientProstheticTreatmentFinalProthesisSingleBridge(List<ProstheticStepEntity> data);

  Future<NoParams> updatePatientProstheticTreatmentFinalProthesisFullArch(List<ProstheticStepEntity> data);
}

class ProstheticDatasourceImpl implements ProstheticDatasource {
  final HttpRepo httpRepo;

  ProstheticDatasourceImpl({required this.httpRepo});

  @override
  Future<List<ProstheticStepModel>> getPatientProstheticTreatmentDiagnostic(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetPatientProstheticTreatmentDiagnostic?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body == null) return [];
      return ((response.body ?? []) as List<dynamic>).map((e) => ProstheticStepModel.fromJson(response.body as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<ProstheticStepModel>> getPatientProstheticTreatmentFinalProthesisFullArch(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetPatientProstheticTreatmentFinalProthesisFullArch?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body == null) return [];
      return ((response.body ?? []) as List<dynamic>).map((e) => ProstheticStepModel.fromJson(response.body as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<ProstheticStepModel>> getPatientProstheticTreatmentFinalProthesisSingleBridge(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetPatientProstheticTreatmentFinalProthesisSingleBridge?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body == null) return [];
      return ((response.body ?? []) as List<dynamic>).map((e) => ProstheticStepModel.fromJson(response.body as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> updatePatientProstheticTreatmentDiagnostic(List<ProstheticStepEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$medicalController/UpdatePatientProstheticTreatmentDiagnostic",
        body:data.map((e) => ProstheticStepModel.fromEntity(e).toJson()).toList() ,
      );
    } catch (e) {
      print(e);
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updatePatientProstheticTreatmentFinalProthesisFullArch(List<ProstheticStepEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$medicalController/UpdatePatientProstheticTreatmentFinalProthesis",
        body:data.map((e) => ProstheticStepModel.fromEntity(e).toJson()).toList() ,
      );
    } catch (e) {
      print(e);
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updatePatientProstheticTreatmentFinalProthesisSingleBridge(List<ProstheticStepEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$medicalController/UpdatePatientProstheticTreatmentFinalProthesis",
        body:data.map((e) => ProstheticStepModel.fromEntity(e).toJson()).toList() ,
      );
    } catch (e) {
      print(e);
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }
}
