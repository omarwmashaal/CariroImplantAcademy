import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/data/models/medicalExaminationModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/entities/dentalHistoryEntity.dart';

import '../../../../../core/Http/httpRepo.dart';
import '../../../../../core/constants/remoteConstants.dart';
import '../../../../../core/useCases/useCases.dart';
import '../../domain/entities/medicalExaminationEntity.dart';

abstract class MedicalHistoryDatasource {
  Future<MedicalExaminationModel> getMedicalExamination(int id);
  Future<NoParams> saveMedicalExamination(MedicalExaminationEntity medicalExaminationEntity);


}

class MedicalHistoryDatasourceImpl implements MedicalHistoryDatasource {
  final HttpRepo httpRepo;

  MedicalHistoryDatasourceImpl({required this.httpRepo});

  @override
  Future<MedicalExaminationModel> getMedicalExamination(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetPatientMedicalExamination?id=$id");
    } catch(e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode);
    try {
      return MedicalExaminationModel.fromJson(response.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> saveMedicalExamination(MedicalExaminationEntity medicalExaminationEntity) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$medicalController/UpdatePatientMedicalExamination?id=${medicalExaminationEntity.patientId}",
        body: MedicalExaminationModel.fromEntity(medicalExaminationEntity).toJson(),
      );
    }catch(e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode);
    return NoParams();
  }

 }
