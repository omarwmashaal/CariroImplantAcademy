import 'dart:convert';

import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import '../../../../../core/constants/remoteConstants.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/patientInfoEntity.dart';
import '../../domain/usecases/patientSearchUseCase.dart';
import '../models/patientSearchResponseModel.dart';

abstract class PatientSearchDataSource {
  Future<List<PatientInfoEntity>> searchPatients(PatientSearchParams params);

  Future<PatientInfoEntity> getPatient(int id);

  Future<int> getNextAvailableId();

  Future<bool> checkDuplicateId(int id);

  Future<PatientInfoModel> createPatient(PatientInfoModel patient);

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
    } catch(e) {
      throw mapException(e);
    }
    if (result.statusCode != 200)
      throw getHttpException(statusCode: result.statusCode,message: result.errorMessage);

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
    } catch(e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode,message: result.errorMessage);
    try {
      return PatientInfoModel.fromMap(result.body! as Map<String,dynamic>);
    } catch (e) {
      throw DataConversionException(message: DATACONVERSION_FAILURE_MESSAGE);
    }
  }

  @override
  Future<int> getNextAvailableId() async {
    late StandardHttpResponse result;
    try {
      result = await client.get(
        host: "$serverHost/$patientInfoController/GetNextAvailableId",
      );
    } catch(e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode,message: result.errorMessage);
    try {
      return int.parse(result.body! as String);
    } catch (e) {
      throw DataConversionException(message: DATACONVERSION_FAILURE_MESSAGE);
    }
  }

  @override
  Future<bool> checkDuplicateId(int id) async {
    late StandardHttpResponse result;
    try {
      result = await client.get(
        host: "$serverHost/$patientInfoController/CheckDuplicateId?id=$id",
      );
    } catch(e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode,message: result.errorMessage);
    return result.body != null;
  }

  @override
  Future<PatientInfoModel> createPatient(PatientInfoModel patient) async {
    late StandardHttpResponse result;
    try {
      result = await client.post(host: "$serverHost/$patientInfoController/CreatePatient", body: patient.toMap());
    } catch(e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode,message: result.errorMessage);
    try{
      return PatientInfoModel.fromMap(result.body! as Map<String,dynamic>);
    }catch(e)
    {
      throw DataConversionFailure(failureMessage: DATACONVERSION_FAILURE_MESSAGE);
    }
  }

  @override
  Future<String?> checkDuplicateNumber(String number) async {
    StandardHttpResponse response;
    try {
      response = await client.post(host: "$serverHost/$patientInfoController/CompareDuplicateNumber?number=$number");
      if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
      return (response.body! as String);
    } catch (e) {
      throw HttpInternalServerErrorException();
    }
  }
}
