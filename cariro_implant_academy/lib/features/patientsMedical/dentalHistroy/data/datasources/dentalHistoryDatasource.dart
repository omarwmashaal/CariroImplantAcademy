import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/data/models/medicalExaminationModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/entities/dentalHistoryEntity.dart';

import '../../../../../core/Http/httpRepo.dart';
import '../../../../../core/constants/remoteConstants.dart';
import '../../../../../core/useCases/useCases.dart';
import '../models/dentalHistoryModel.dart';
abstract class DentalHistoryDataSource {

  Future<DentalHistoryModel> getDentalHistory(int id);
  Future<NoParams> saveDentalHistory(DentalHistoryEntity dentalHistoryEntity);
}

class DentalHistoryDataSrouceImpl implements DentalHistoryDataSource {
  final HttpRepo httpRepo;

  DentalHistoryDataSrouceImpl({required this.httpRepo});


  @override
  Future<DentalHistoryModel> getDentalHistory(int id) async{
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$medicalController/GetPatientDentalHistory?id=$id");
    } catch (e) {
      throw HttpInternalServerErrorException();
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode);
    try {
      return DentalHistoryModel.fromJson(response.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> saveDentalHistory(DentalHistoryEntity dentalHistoryEntity)async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$medicalController/UpdatePatientDentalHistory?id=${dentalHistoryEntity.patientId}",
        body: DentalHistoryModel.fromEntity(dentalHistoryEntity).toJson(),
      );
    } catch(e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode);
    return NoParams();
  }
}
