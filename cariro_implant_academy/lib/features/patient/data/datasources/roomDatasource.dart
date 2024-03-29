import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/features/patient/data/models/roomModel.dart';

import '../../../../core/constants/remoteConstants.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/visitEntity.dart';
import '../../domain/usecases/getAvailableRoomsUsecase.dart';
import '../models/visitModel.dart';

abstract class RoomDatasource{
  Future<List<RoomModel>> getRooms();
  Future<List<RoomModel>> getAvailableRooms(GetAvailableRoomsParams params);
}

class RoomDatasourceImpl implements RoomDatasource{
  final HttpRepo httpRepo;
  RoomDatasourceImpl({required this.httpRepo});

  @override
  Future<List<RoomModel>> getRooms() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetRooms");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try {
      return response.body==null?[]: (response.body as List<dynamic>).map((e) => RoomModel.fromJson(e)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }  @override
  Future<List<RoomModel>> getAvailableRooms(GetAvailableRoomsParams params) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$patientInfoController/GetAvailableRooms?from=${params.from.toUtc().toIso8601String()}&to=${params.to.toUtc().toIso8601String()}");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try {
      return response.body==null?[]: (response.body as List<dynamic>).map((e) => RoomModel.fromJson(e)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

}