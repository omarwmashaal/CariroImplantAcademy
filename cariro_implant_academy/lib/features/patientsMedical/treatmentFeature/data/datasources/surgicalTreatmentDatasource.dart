import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/surgicalTreatmentModel.dart';

import '../../../../../core/constants/remoteConstants.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/useCases/useCases.dart';
import '../../domain/entities/requestChangeEntity.dart';
import '../../domain/entities/surgicalTreatmentEntity.dart';
import '../models/requestChangeModel.dart';

abstract class SurgicalTreatmentDatasource {
  Future<SurgicalTreatmentModel> getSurgicalTreatment(int id);

  Future<NoParams> saveSurgicalTreatment(int id, SurgicalTreatmentEntity data);
  Future<RequestChangeModel> addChangeRequest(RequestChangeEntity request);
  Future<NoParams> acceptChanges(RequestChangeEntity request);
}

class SurgicalTreatmentDatasourceImpl implements SurgicalTreatmentDatasource {
  final HttpRepo httpRepo;

  SurgicalTreatmentDatasourceImpl({required this.httpRepo});

  @override
  Future<SurgicalTreatmentModel> getSurgicalTreatment(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetPatientSurgicalTreatment?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try {
      if (response.body != null)
        return SurgicalTreatmentModel.fromJson(response.body as Map<String, dynamic>);
      else
        return SurgicalTreatmentModel(patientId: id, surgicalTreatment: []);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> saveSurgicalTreatment(int id, SurgicalTreatmentEntity data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$medicalController/UpdatePatientSurgicalTreatment?id=$id",
        body: SurgicalTreatmentModel.fromEntity(data).toJson(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<RequestChangeModel> addChangeRequest(RequestChangeEntity request)async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host: "$serverHost/$medicalController/AddChangeRequest?",
        body: RequestChangeModel.fromEntity(request).toJson(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try{
      return RequestChangeModel.fromJson(response.body as Map<String,dynamic>);
    }
    catch(e)
    {
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
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
  return NoParams();
  }
}
