import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/data/models/dentalExaminationBaseModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/domain/entities/dentalExaminationBaseEntity.dart';

import '../../../../../core/Http/httpRepo.dart';
import '../../../../../core/constants/remoteConstants.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/useCases/useCases.dart';

abstract class DentalExaminationDataSource {
  Future<DentalExaminationBaseEntity> getDentalExamination(int id);

  Future<NoParams> saveDentalExamination(DentalExaminationBaseEntity dentalExaminationBaseEntity);
}

class DentalExaminationDatasourceImpl implements DentalExaminationDataSource {
  final HttpRepo httpRepo;

  DentalExaminationDatasourceImpl({required this.httpRepo});

  @override
  Future<DentalExaminationBaseEntity> getDentalExamination(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetPatientDentalExamination?id=$id");
    } catch (e) {
      throw HttpInternalServerErrorException();
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode);
    try {
      return DentalExaminationBaseModel.fromMap(response.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> saveDentalExamination(DentalExaminationBaseEntity dentalExaminationBaseEntity) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$medicalController/UpdatePatientDentalExamination?id=${dentalExaminationBaseEntity.patientId}",
        body: DentalExaminationBaseModel.fromEntity(dentalExaminationBaseEntity).toMap(),
      );
    } catch (e) {
      throw HttpInternalServerErrorException();
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode);
    return NoParams();
  }
}
