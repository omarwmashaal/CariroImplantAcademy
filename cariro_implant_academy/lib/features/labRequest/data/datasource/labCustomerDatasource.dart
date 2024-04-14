import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/features/patient/data/models/patientInfoModel.dart';
import 'package:cariro_implant_academy/features/user/data/models/userModel.dart';

import '../../../../core/constants/enums/enums.dart';
import '../../../../core/constants/remoteConstants.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/useCases/useCases.dart';
import '../../../patient/domain/entities/patientInfoEntity.dart';
import '../../../user/domain/entities/userEntity.dart';

abstract class LabCustomerDatasource {
  Future<UserEntity> createNewCustomer(UserEntity customer);

  Future<List<PatientInfoModel>> searchLabPatientsByType(String? search, EnumLabRequestSources type);
}

class LabCustomerDataSourceImpl implements LabCustomerDatasource {
  final HttpRepo httpRepo;

  LabCustomerDataSourceImpl({required this.httpRepo});

  @override
  Future<UserEntity> createNewCustomer(UserEntity customer) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host: "$serverHost/$labCustomerController/AddCustomer",
        body: UserModel.fromEntity(customer).toJson(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);

    try {
      return UserModel.fromJson(response.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<PatientInfoModel>> searchLabPatientsByType(String? search, EnumLabRequestSources type) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$labCustomerController/SearchPatientsByType?type=${type.index}&${search==null?"":"search=$search"}");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);

    try {
      return ((response.body as List<dynamic>).map((e) => PatientInfoModel.fromMap(e as Map<String, dynamic>)).toList());
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }
}
