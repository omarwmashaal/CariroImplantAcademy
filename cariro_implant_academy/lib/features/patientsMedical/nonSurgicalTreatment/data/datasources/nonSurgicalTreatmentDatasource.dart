import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/data/models/nonSurgicalTreatmentModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/teethTreatmentPlanModel.dart';

import '../../../../../core/constants/remoteConstants.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/useCases/useCases.dart';
import '../../../treatmentFeature/domain/entities/teethTreatmentPlan.dart';
import '../../domain/entities/nonSurgialTreatmentEntity.dart';
import '../../domain/usecases/saveNonSurgicalTreatmentUseCase.dart';

abstract class NonSurgicalTreatmentDatasource {
  Future<NonSurgicalTreatmentEntity> getNonSurgicalTreatment(int id);

  Future<List<NonSurgicalTreatmentEntity>> getAllNonSurgicalTreatments(int id);

  Future<NoParams> saveNonSurgicalTreatment(SaveNonSurgicalTreatmentParams data);

  Future<List<int>> checkNonSurgicalTreatmentTeethStatus(String data);

  Future<TeethTreatmentPlanModel?> getPaidPlanItem(int patientId, int tooth);
}

class NonSurgicalTreatmentDatasourceImpl implements NonSurgicalTreatmentDatasource {
  final HttpRepo httpRepo;

  NonSurgicalTreatmentDatasourceImpl({required this.httpRepo});

  @override
  Future<List<int>> checkNonSurgicalTreatmentTeethStatus(String data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/CheckNonSurgicalTreatmentTeethStatus?treatment=$data");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try {
      return response.body == null ? [] : (response.body as List<dynamic>).map((e) => e as int).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<NonSurgicalTreatmentEntity>> getAllNonSurgicalTreatments(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetPatientAllNonSurgicalTreatments?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try {
      return (response.body as List<dynamic>).map((e) => NonSurgicalTreatmentModel.fromMap(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NonSurgicalTreatmentEntity> getNonSurgicalTreatment(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetPatientNonSurgicalTreatment?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try {
      return NonSurgicalTreatmentModel.fromMap((response.body ?? Map<String, dynamic>()) as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> saveNonSurgicalTreatment(SaveNonSurgicalTreatmentParams data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$medicalController/AddPatientNonSurgicalTreatment?id=${data.patientId}",
        body: NonSurgicalTreatmentModel.fromEntity(data.nonSurgicalTreatmentEntity).toMap(),
      );
    } catch (e) {
      print(e);
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<TeethTreatmentPlanModel?> getPaidPlanItem(int patientId, int tooth) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(
        host: "$serverHost/$medicalController/GetPaidPlanItem?id=$patientId&tooth=$tooth",
      );
    } catch (e) {
      print(e);
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try {
      if (response.body == null) return null;
      return TeethTreatmentPlanModel.fromJson(response.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException();
    }
  }
}
