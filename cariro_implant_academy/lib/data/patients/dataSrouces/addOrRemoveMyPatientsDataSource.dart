import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/constants/remoteConstants.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';

import '../../../domain/patients/usecases/addRangeToMyPatientsUseCase.dart';

abstract class AddOrRemoveMyPatientsDataSource {
  Future<bool> addToMyPatientsRange(AddRangePatientsParams params);
  Future<bool> addToMyPatients(int id);
  Future<bool> removeFromMyPatients(int id);

}

class AddOrRemoveMyPatientsDataSourceImpl implements AddOrRemoveMyPatientsDataSource {
  HttpRepo client;

  AddOrRemoveMyPatientsDataSourceImpl(this.client);

  @override
  Future<bool> addToMyPatientsRange(AddRangePatientsParams params) async {
    late StandardHttpResponse result;
    try {
      result = await client.post(host: "$serverHost/$patientInfoController/AddRangeToMyPatients?from=${params.from}&to=${params.to}");
    } catch(e) {
      throw mapException(e);
    }
    if (result.statusCode == 200) return true;
    else throw HttpInternalServerErrorException();
  }

  @override
  Future<bool> addToMyPatients(int id)  async {
    late StandardHttpResponse result;
    try {
      result = await client.post(host: "$serverHost/$patientInfoController/AddToMyPatients?id=$id");
    } catch(e) {
      throw mapException(e);
    }
    if (result.statusCode == 200) return true;
    else throw HttpInternalServerErrorException();
  }



  @override
  Future<bool> removeFromMyPatients(int id) {
    // TODO: implement removeFromMyPatients
    throw UnimplementedError();
  }

}
