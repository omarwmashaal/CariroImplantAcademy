import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/postSurgicalTreatmentModel.dart';

import '../../../../../core/constants/remoteConstants.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/useCases/useCases.dart';
import '../../domain/entities/requestChangeEntity.dart';
import '../../domain/entities/postSurgicalTreatmentEntity.dart';
import '../models/requestChangeModel.dart';

abstract class PostSurgicalTreatmentDatasource {
  Future<PostSurgicalTreatmentModel> getPostSurgicalTreatment(int id);

  Future<NoParams> savePostSurgicalTreatment( PostSurgicalTreatmentEntity data);
  Future<RequestChangeModel> addChangeRequest(RequestChangeEntity request);
  Future<NoParams> acceptChanges(RequestChangeEntity request);
}

class SurgicalTreatmentDatasourceImpl implements PostSurgicalTreatmentDatasource {
  final HttpRepo httpRepo;

  SurgicalTreatmentDatasourceImpl({required this.httpRepo});

  @override
  Future<PostSurgicalTreatmentModel> getPostSurgicalTreatment(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetPatientPostSurgery?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return PostSurgicalTreatmentModel.fromJson(response.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> savePostSurgicalTreatment( PostSurgicalTreatmentEntity data) async {
    data.requestChanges = [];
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$medicalController/UpdatePatientPostSurgeryData",
        body: PostSurgicalTreatmentModel.fromEntity(data).toJson(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<RequestChangeModel> addChangeRequest(RequestChangeEntity request) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host: "$serverHost/$medicalController/AddChangeRequest?",
        body: RequestChangeModel.fromEntity(request).toJson(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return RequestChangeModel.fromJson(response.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't Convert Data");
    }
  }

  @override
  Future<NoParams> acceptChanges(RequestChangeEntity request) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host: "$serverHost/$medicalController/AcceptChangeRequest?",
        body: RequestChangeModel.fromEntity(request).toJson(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }
}
