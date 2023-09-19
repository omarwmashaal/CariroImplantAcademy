import 'package:cariro_implant_academy/core/Http/httpRepo.dart';

import '../../../../core/constants/enums/enums.dart';
import '../../../../core/constants/remoteConstants.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/useCases/useCases.dart';
import '../../domain/entities/complainEntity.dart';
import '../models/complainModel.dart';

abstract class ComplainsDatasource{
  Future<NoParams> resolveComplain(int complainId);
  Future<NoParams> inqueueComplain(int complainId,String? notes);
  Future<NoParams> updateComplainNotes(int complainId,String? notes);
  Future<NoParams> addComplain(ComplainsEntity complain);
  Future<List<ComplainModel>> getComplains({int? id, String? search, EnumComplainStatus? status});

}

class ComplainDatasourceImpl implements ComplainsDatasource{
  final HttpRepo httpRepo;
  ComplainDatasourceImpl({required this.httpRepo});
  @override
  Future<NoParams> addComplain(ComplainsEntity complain) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.post(
        host: "$serverHost/$patientInfoController/AddComplain?",
        body: ComplainModel.fromEntity(complain).toJson()
      );
    } catch(e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode);
    return NoParams();
  }

  @override
  Future<List<ComplainModel>> getComplains({int? id, String? search, EnumComplainStatus? status})  async {
    late StandardHttpResponse result;
    String query = "";
    query += "${query==null?"":"${id==null?"":"&"}"}${id==null?"":"id=$id"}";
    query += "${query==null?"":"${search==null?"":"&"}"}${search==null?"":"search=$search"}";
    query += "${query==null?"":"${status==null?"":"&"}"}${status==null?"":"status=${status.index}"}";
    try {
      result = await httpRepo.get(
        host: "$serverHost/$patientInfoController/getComplains?$query",
      );
    } catch(e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode);
    try {
      if(result.body==null)
        return [];
      return (result.body as List<dynamic>).map((e) => ComplainModel.fromJson(e as Map<String,dynamic>)).toList() ;
    } catch (e) {
      throw DataConversionException();
    }
  }

  @override
  Future<NoParams> inqueueComplain(int complainId, String? notes) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.put(
          host: "$serverHost/$patientInfoController/InQueueComplain?id=$complainId&${notes==null?"":"notes=$notes"}",
      );
    } catch(e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode);
    return NoParams();
  }

  @override
  Future<NoParams> resolveComplain(int complainId) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.put(
        host: "$serverHost/$patientInfoController/ResolveComplain?id=$complainId",
      );
    } catch(e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode);
    return NoParams();
  }

  @override
  Future<NoParams> updateComplainNotes(int complainId, String? notes) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.put(
        host: "$serverHost/$patientInfoController/UpdateComplainNotes?id=$complainId&${notes==null?"":"notes=$notes"}",
      );
    } catch(e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode);
    return NoParams();
  }

}