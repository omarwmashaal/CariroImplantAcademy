import 'dart:convert';

import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/data/models/advancedSearchPatientsModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/data/models/prostheticModel.dart';
import 'package:intl/intl.dart';
import '../../../../../core/constants/remoteConstants.dart';
import '../../../../core/error/failure.dart';
import '../../../patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import '../../domain/entities/advancedPatientSearchEntity.dart';
import '../../domain/entities/advancedTreatmentSearchEntity.dart';
import '../../domain/entities/patientInfoEntity.dart';
import '../../domain/usecases/patientSearchUseCase.dart';
import '../models/advancedTreatmentSearchModel.dart';
import '../models/patientSearchResponseModel.dart';

abstract class PatientSearchDataSource {
  Future<List<PatientInfoEntity>> searchPatients(PatientSearchParams params);

  Future<PatientInfoEntity> getPatient(int id);
  Future<NoParams> setPatientOut(int id,String outReason);

  Future<int> getNextAvailableId();

  Future<bool> checkDuplicateId(String id);

  Future<List<AdvancedSearchPatientsModel>> advancedSearchPatients(AdvancedPatientSearchEntity params);
  Future< List<AdvancedTreatmentSearchModel>> advancedTreatmentSearch(AdvancedTreatmentSearchEntity params);
  Future< List<ProstheticTreatmentEntity>> advancedProstheticSearch(ProstheticTreatmentEntity query,DateTime? from, DateTime? to);


  Future<PatientInfoModel> createPatient(PatientInfoEntity patient);

  Future<PatientInfoModel> updatePatientData(PatientInfoEntity patient);

  Future<String?> checkDuplicateNumber(String number);
}

class PatientSearchDataSourceImpl implements PatientSearchDataSource {
  HttpRepo client;

  PatientSearchDataSourceImpl({required this.client});

  @override
  Future<List<PatientInfoEntity>> searchPatients(PatientSearchParams params) async {
    late StandardHttpResponse result;
    String _query = "myPatients=${params.myPatients}";
    if (params.query != null) {
      _query += "&search=${params.query}";
      if (params.filter != null) _query += "&filter=${params.filter}";
    }

    try {
      result = await client.get(
        host: "$serverHost/$patientInfoController/ListPatients?$_query",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200)
      throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);

    try {
      return (result.body! as List<dynamic>).map((e) => PatientInfoModel.fromMap(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: DATACONVERSION_FAILURE_MESSAGE);
    }
  }

  @override
  Future<PatientInfoEntity> getPatient(int id) async {
    late StandardHttpResponse result;
    try {
      result = await client.get(
        host: "$serverHost/$patientInfoController/GetPatientInfo?id=$id",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      return PatientInfoModel.fromMap(result.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: DATACONVERSION_FAILURE_MESSAGE);
    }
  }
  @override
  Future<NoParams> setPatientOut(int id,String outReason) async {
    late StandardHttpResponse result;
    try {
      result = await client.post(
        host: "$serverHost/$patientInfoController/SetPatientOut?id=$id${outReason==""?"":"&outReason=$outReason"}",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    return NoParams();
  }

  @override
  Future<int> getNextAvailableId() async {
    late StandardHttpResponse result;
    try {
      result = await client.get(
        host: "$serverHost/$patientInfoController/GetNextAvailableId",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      return result.body as int;
    } catch (e) {
      throw DataConversionException(message: DATACONVERSION_FAILURE_MESSAGE);
    }
  }

  @override
  Future<bool> checkDuplicateId(String id) async {
    late StandardHttpResponse result;
    try {
      result = await client.get(
        host: "$serverHost/$patientInfoController/CheckDuplicateId?id=$id",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    return result.body != null;
  }

  @override
  Future<PatientInfoModel> createPatient(PatientInfoEntity patient) async {
    late StandardHttpResponse result;
    try {
      result = await client.post(host: "$serverHost/$patientInfoController/CreatePatient", body: PatientInfoModel.fromEntity(patient).toMap());
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      return PatientInfoModel.fromMap(result.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: DATACONVERSION_FAILURE_MESSAGE);
    }
  }

  @override
  Future<String?> checkDuplicateNumber(String number) async {
    StandardHttpResponse response;
    try {
      response = await client.post(host: "$serverHost/$patientInfoController/CompareDuplicateNumber?number=$number");
      if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
      return (response.body as String?);
    } catch (e) {
      throw HttpInternalServerErrorException();
    }
  }

  @override
  Future<PatientInfoModel> updatePatientData(PatientInfoEntity patient) async {
    late StandardHttpResponse result;
    try {
      result = await client.put(host: "$serverHost/$patientInfoController/UpdatePatientsInfo", body: PatientInfoModel.fromEntity(patient).toMap());
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      return PatientInfoModel.fromMap(result.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: DATACONVERSION_FAILURE_MESSAGE);
    }
  }

  @override
  Future<List<AdvancedSearchPatientsModel>> advancedSearchPatients(AdvancedPatientSearchEntity params) async {
    late StandardHttpResponse response;

    try {
      response = await client.post(
          host: "$serverHost/$patientInfoController/AdvancedSearchPatient",
          body: AdvancedSearchPatientsModel.fromEntity(params).toJson()
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body == null) return [];
      return ((response.body!) as List<dynamic>).map((e) => AdvancedSearchPatientsModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    catch(e)
    {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<AdvancedTreatmentSearchModel>> advancedTreatmentSearch(AdvancedTreatmentSearchEntity params) async {
    late StandardHttpResponse response;

    try {
      response = await client.post(
          host: "$serverHost/$patientInfoController/AdvancedSearchTreatment",
          body: AdvancedTreatmentSearchModel.fromEntity(params).toJson()
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body == null) return [];
      return ((response.body!) as List<dynamic>).map((e) => AdvancedTreatmentSearchModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    catch(e)
    {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<ProstheticTreatmentEntity>> advancedProstheticSearch(ProstheticTreatmentEntity query,DateTime? from, DateTime? to)async {
    late StandardHttpResponse response;
    String q ="";
    if(from!=null) q+="from=${from!.toUtc().toIso8601String()}";
    if(to!=null) q+="${q==""?"":"&"}to=${to!.toUtc().toIso8601String()}";
    try {
      response = await client.post(
          host: "$serverHost/$patientInfoController/AdvancedSearchProsthetic?$q",
          body: ProstheticTreatmentModel.fromEntity(query).toJson()
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body == null) return [];
      return ((response.body!) as List<dynamic>).map((e) => ProstheticTreatmentModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }
}
