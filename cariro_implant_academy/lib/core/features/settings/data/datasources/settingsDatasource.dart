import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/treatmentPricesModel.dart';

import '../../../../constants/remoteConstants.dart';
import '../../../../data/models/BasicNameIdObjectModel.dart';
import '../../../../domain/entities/BasicNameIdObjectEntity.dart';
import '../../../../error/exception.dart';
import '../../domain/entities/implantEntity.dart';
import '../../domain/entities/membraneCompanyEnity.dart';
import '../../domain/entities/tacEntity.dart';
import '../../domain/entities/treatmentPricesEntity.dart';
import '../models/ImplantModel.dart';
import '../models/membraneCompanyModel.dart';
import '../models/tacCompanyModel.dart';

abstract class SettingsDatasource{
  Future<TreatmentPricesModel> getTreatmentPrices();
  Future<List<TacCompanyModel>> getTacs();
  Future<List<MembraneCompanyModel>> getMembraneCompanies();
  Future<List<BasicNameIdObjectModel>> getMembranes(int id);
  Future<List<BasicNameIdObjectModel>> getImplantCompanies();
  Future<List<BasicNameIdObjectModel>> getImplantLines(int id);
  Future<List<ImplantModel>> getImplants(int id);
}

class SettingsDatasourceImpl implements SettingsDatasource{
  final HttpRepo httpRepo;
  SettingsDatasourceImpl({required this.httpRepo});
  @override
  Future<TreatmentPricesModel> getTreatmentPrices() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetTreatmentPrices");
    } catch(e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try {
      return TreatmentPricesModel.fromJson(response.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectModel>> getImplantCompanies()async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetImplantCompanies");
    } catch(e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try {
      return ((response.body??[]) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String,dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectModel>> getImplantLines(int id)async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetImplantLines?id=$id");
    } catch(e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try {
      return ((response.body??[]) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String,dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<ImplantModel>> getImplants(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetImplants?id=$id");
    } catch(e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try {
      return ((response.body??[]) as List<dynamic>).map((e) => ImplantModel.fromJson(e as Map<String,dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<MembraneCompanyModel>> getMembraneCompanies()async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetMembraneCompanies");
    } catch(e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try {
      return ((response.body??[]) as List<dynamic>).map((e) => MembraneCompanyModel.fromJson(e as Map<String,dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<TacCompanyModel>> getTacs() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetTacsCompanies");
    } catch(e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try {
      return ((response.body??[]) as List<dynamic>).map((e) => TacCompanyModel.fromJson(e as Map<String,dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectModel>> getMembranes(int id)  async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetMembranes?id=$id");
    } catch(e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try {
      return ((response.body??[]) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String,dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

}