import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';

import '../../Http/httpRepo.dart';
import '../../constants/remoteConstants.dart';
import '../../domain/entities/BasicNameIdObjectEntity.dart';
import '../../domain/useCases/loadUsersUseCase.dart';
import '../../error/exception.dart';

abstract class LoadingDatasource {
  Future<List<BasicNameIdObjectEntity>> loadUsers({required LoadUsersEnum userType});
  Future<List<BasicNameIdObjectEntity>> loadCandidateBatches();
  Future<List<BasicNameIdObjectEntity>> loadCandidatesByBatchId(int id);
  Future<List<BasicNameIdObjectEntity>> loadCandidatesBatches();
  Future<List<BasicNameIdObjectEntity>> loadWorkPlaces();
}

class LoadingDataSourceImpl implements LoadingDatasource {
  final HttpRepo httpRepo;

  LoadingDataSourceImpl({required this.httpRepo});

  @override
  Future<List<BasicNameIdObjectEntity>> loadUsers({required LoadUsersEnum userType}) async {
    late StandardHttpResponse response;
    String searchHost = "";
    switch (userType) {
      case LoadUsersEnum.admins:
        searchHost = "LoadAdmins";
        break;
      case LoadUsersEnum.instructors:
        searchHost = "LoadInstructors";
        break;
      case LoadUsersEnum.assistants:
        searchHost = "LoadAssistants";
        break;
      case LoadUsersEnum.instructorsAndAssistants:
        searchHost = "LoadInstructorsAndAssistants";
        break;
      case LoadUsersEnum.supervisors:
        searchHost = "LoadSupervisors";
        break;
      case LoadUsersEnum.technicians:
        searchHost = "LoadTechnicians";
        break;
      case LoadUsersEnum.labDesigner:
        searchHost = "LoadLabDesingers";
        break;
      case LoadUsersEnum.allDoctors:
        searchHost = "GetAllDoctors";
        break;
      default:
        searchHost = "";
    }
    try {
      response = await httpRepo.get(host: "$serverHost/$userController/$searchHost");
    } catch (e) {
      throw HttpInternalServerErrorException();
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return response.body == null
          ? []
          : (response.body as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectEntity>> loadCandidateBatches() async {
    late StandardHttpResponse response;

    try {
      response = await httpRepo.get(host: "$serverHost/$userController/LoadCandidatesBatches");
    } catch (e) {
      throw HttpInternalServerErrorException();
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return response.body == null
          ? []
          : (response.body as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectEntity>> loadCandidatesByBatchId(int id) async {
    late StandardHttpResponse response;

    try {
      response = await httpRepo.get(host: "$serverHost/$userController/LoadCandidatesByBatchID?id=$id");
    } catch (e) {
      throw HttpInternalServerErrorException();
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return response.body == null
          ? []
          : (response.body as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectEntity>> loadCandidatesBatches() async {
    late StandardHttpResponse response;

    try {
      response = await httpRepo.get(host: "$serverHost/$userController/LoadCandidatesBatches");
    } catch (e) {
      throw HttpInternalServerErrorException();
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return response.body == null
          ? []
          : (response.body as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectEntity>> loadWorkPlaces() async {
    late StandardHttpResponse response;

    try {
      response = await httpRepo.get(host: "$serverHost/$labCustomerController/GetAllWorkPlaces");
    } catch (e) {
      throw HttpInternalServerErrorException();
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return response.body == null
          ? []
          : (response.body as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }
}
