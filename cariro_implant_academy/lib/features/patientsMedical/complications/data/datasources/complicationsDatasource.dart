import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/udpateComplicationsAfterProsthesisUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/udpateComplicationsAfterSurgeryUseCase.dart';

import '../../../../../core/Http/httpRepo.dart';
import '../../../../../core/constants/remoteConstants.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/useCases/useCases.dart';
import '../../domain/entities/complicationsAfterProsthesisEntity.dart';
import '../../domain/entities/complicationsAfterSurgeryEntity.dart';
import '../models/complicationsAfterProsthesisModel.dart';
import '../models/complicationsAfterSurgeryModel.dart';

abstract class ComplicationsDatasource {
  Future<List<ComplicationsAfterSurgeryModel>> getComplicationsAfterSurgery(int id);
  Future<List<int>> getSurgeryTeethForComplications(int id);

  Future<List<ComplicationsAfterProsthesisModel>> getComplicationsAfterProsthesis(int id);

  Future<NoParams> updateComplicationsAfterSurgery(UpdateSurgicalComplicationsParams data);

  Future<NoParams> updateComplicationsAfterProsthesis(UpdateProstheticComplicationsParams data);
}

class ComplicationsDatasourceImpl implements ComplicationsDatasource {
  final HttpRepo httpRepo;

  ComplicationsDatasourceImpl({required this.httpRepo});

  @override
  Future<List<ComplicationsAfterProsthesisModel>> getComplicationsAfterProsthesis(int id) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.get(host: "$serverHost/$medicalController/getComplicationsAfterProsthesis?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      return ((result.body ?? []) as List<dynamic>).map((e) => ComplicationsAfterProsthesisModel.fromJson((e) as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: e.toString());
    }
  }

  @override
  Future<List<ComplicationsAfterSurgeryModel>> getComplicationsAfterSurgery(int id) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.get(host: "$serverHost/$medicalController/getComplicationsAfterSurgery?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      return ((result.body ?? []) as List<dynamic>).map((e) => ComplicationsAfterSurgeryModel.fromJson((e) as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: e.toString());
    }
  }

  @override
  Future<NoParams> updateComplicationsAfterProsthesis(UpdateProstheticComplicationsParams data) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.put(
        host: "$serverHost/$medicalController/updateComplicationsAfterProsthesis?id=${data.id}",
        body: data.data.map((e) => ComplicationsAfterProsthesisModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updateComplicationsAfterSurgery(UpdateSurgicalComplicationsParams data) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.put(
        host: "$serverHost/$medicalController/updateComplicationsAfterSurgery?id=${data.id}",
        body: data.data.map((e) => ComplicationsAfterSurgeryModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    return NoParams();
  }

  @override
  Future<List<int>> getSurgeryTeethForComplications(int id) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.get(host: "$serverHost/$medicalController/getSurgeryTeethForComplications?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);

    try {
      return ((result.body ?? []) as List<dynamic>).map((e) => e as int).toList();
    } catch (e) {
      throw DataConversionException(message: e.toString());
    }
  }
}
