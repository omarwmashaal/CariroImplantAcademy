import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';

import '../../../../core/constants/remoteConstants.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entity/visitEntity.dart';
import '../models/visitModel.dart';

abstract class VisitsDataSource {
  Future<List<VisitModel>> getPatientVisits(int patientId);

  Future<List<VisitModel>> getAllVisits();

  Future<List<VisitModel>> getAllSchedules(int month);

  Future<List<VisitModel>> getMySchedules(int month);

  Future<NoParams> scheduleNewVisit(VisitEntity newVisit);
}

class VisitsDatasourceImpl implements VisitsDataSource {
  final HttpRepo httpRepo;

  VisitsDatasourceImpl({required this.httpRepo});

  @override
  Future<List<VisitModel>> getAllSchedules(int month) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$patientInfoController/GetAllSchedules?month=$month");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode);
    try {
      return response.body == null ? [] : (response.body as List<dynamic>).map((e) => VisitModel.fromJson(e)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<VisitModel>> getAllVisits() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$patientInfoController/ListVisitsLogs");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode);
    try {
      return response.body == null ? [] : (response.body as List<dynamic>).map((e) => VisitModel.fromJson(e)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<VisitModel>> getMySchedules(int month) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$patientInfoController/GetScheduleForDoctor?month=$month");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode);
    try {
      return response.body == null ? [] : (response.body as List<dynamic>).map((e) => VisitModel.fromJson(e)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<VisitModel>> getPatientVisits(int patientId) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$patientInfoController/GetVisitsLog?id=$patientId");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode);
    try {
      return response.body == null ? [] : (response.body as List<dynamic>).map((e) => VisitModel.fromJson(e)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> scheduleNewVisit(VisitEntity newVisit) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(host: "$serverHost/$patientInfoController/ScheduleVisit", body:
        VisitModel.fromEntity(newVisit).toJson()
        ,);
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode);
   return NoParams();
  }

}