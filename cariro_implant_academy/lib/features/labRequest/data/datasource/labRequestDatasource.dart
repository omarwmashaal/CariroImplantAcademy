import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/data/models/receiptModel.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labItemModel.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labItemParentModel.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labStepItemModel.dart';
import 'package:dartz/dartz.dart';

import '../../../../Models/ReceiptModel.dart';
import '../../../../core/constants/remoteConstants.dart';
import '../../../../core/data/models/BasicNameIdObjectModel.dart';
import '../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/useCases/useCases.dart';
import '../../domain/entities/labRequestEntityl.dart';
import '../../domain/usecases/getAllRequestsUseCase.dart';
import '../models/labRequestModel.dart';

abstract class LabRequestDatasource {
  Future<List<LabRequestModel>> getAllLabRequests(GetAllRequestsParams params);
  Future<List<LabStepItemModel>> getLabItemStepsFroRequest(int id);

  Future<List<LabRequestModel>> getPatientLabRequests(int id);
  Future<List<LabItemParentModel>> getLabItemsFromSettings();

  Future<LabRequestModel> getLabRequest(int id);
  Future<NoParams> deleteLabRequest(int id);

  Future<NoParams> checkLabRequests(int id);

  Future<NoParams> addRequest(LabRequestEntity model);

  Future<NoParams> updateLabRequest(LabRequestEntity model);

  Future<BasicNameIdObjectModel> getDefaultStepByName(String name);

  Future<List<BasicNameIdObjectModel>> getDefaultSteps();

  Future<NoParams> addToMyTasks(int id);

  Future<NoParams> assignTaskToTechnician(int id, int technicianId, int? designerId);

  Future<NoParams> finishTask(int id, int? nextTaskId, int? assignToId, String? notes);

  Future<NoParams> markRequestAsDone(int id, String? notes);

  // Future<NoParams> addOrUpdateRequestReceipt(int id, List<LabStepEntity> steps);

  Future<NoParams> payForRequest(int id, int amount, DateTime paymentDate);
  Future<LabItemModel> getLabItemDetails(int id);
  Future<ReceiptModel?> getRequestReceipt(int id);

  Future<NoParams> consumeLabItem(int id, int? number, bool consumeWholeBlock);
}

class LabRequestsDatasourceImpl implements LabRequestDatasource {
  final HttpRepo httpRepo;

  LabRequestsDatasourceImpl({required this.httpRepo});

  // @override
  // Future<NoParams> addOrUpdateRequestReceipt(int id, List<LabStepEntity> steps) async {
  //   late StandardHttpResponse response;
  //   try {
  //     response = await httpRepo.post(
  //       host: "$serverHost/$labRequestsController/addOrUpdateRequestReceipt?id=$id",
  //       body: steps.map((e) => LabStepModel.fromEntity(e).toJson()).toList(),
  //     );
  //   } catch (e) {
  //     throw mapException(e);
  //   }
  //   if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
  //   return NoParams();
  // }

  @override
  Future<NoParams> addRequest(LabRequestEntity model) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host: "$serverHost/$labRequestsController/AddRequest",
        body: LabRequestModel.fromEntity(model).toJson(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> addToMyTasks(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(host: "$serverHost/$labRequestsController/addToMyTasks?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> assignTaskToTechnician(int id, int technicianId, int? designerId) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
          host:
              "$serverHost/$labRequestsController/AssignToTechnician?id=$id&technicianId=$technicianId${designerId == null ? "" : "&designerId=$designerId"}");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> finishTask(int id, int? nextTaskId, int? assignToId, String? notes) async {
    String query = "id=$id";
    query += nextTaskId == null ? "" : "&nextTaskId= $nextTaskId";
    query += assignToId == null ? "" : "&assignToId= $assignToId";
    query += notes == null ? "" : "&notes= $notes";
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(host: "$serverHost/$labRequestsController/finishTask?$query");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<List<LabRequestModel>> getAllLabRequests(GetAllRequestsParams params) async {
    late StandardHttpResponse response;
    var query = "";
    if (params.from != null) query = "from=${params.from!.toUtc().toIso8601String()}";
    if (params.to != null) query = query == "" ? query + "to=$params.to" : query + "&to=${params.to!.toUtc().toIso8601String()}";
    if (params.search != null && params.search != "") {
      query = query == "" ? query + "search=${params.search}" : query + "&search=${params.search}";
    }
    if (params.paid != null) query = query == "" ? query + "paid=${params.paid}" : query + "&paid=${params.paid}";
    if (params.status != null) query = query == "" ? query + "status=${params.status!.index}" : query + "&status=${params.status!.index}";
    if (params.source != null) query = query == "" ? query + "source=${params.source!.index}" : query + "&source=${params.source!.index}";
    if (params.myRequests != null) query = query == "" ? query + "myRequests=${params.myRequests}" : query + "&myRequests=${params.myRequests}";

    try {
      response = await httpRepo.get(host: "$serverHost/$labRequestsController/GetAllRequests?$query");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    if (response.body == null) return [];

    try {
      return ((response.body as List<dynamic>).map((e) => LabRequestModel.fromJson(e as Map<String, dynamic>)).toList());
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<BasicNameIdObjectModel> getDefaultStepByName(String name) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$labRequestsController/GetDefaultStepByName?name=$name");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return BasicNameIdObjectModel.fromJson(response.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectModel>> getDefaultSteps() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$labRequestsController/GetDefaultSteps?");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList());
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<LabRequestModel> getLabRequest(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$labRequestsController/GetRequest?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return LabRequestModel.fromJson(response.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<LabRequestModel>> getPatientLabRequests(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$labRequestsController/GetPatientRequests?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body as List<dynamic>).map((e) => LabRequestModel.fromJson(e as Map<String, dynamic>)).toList());
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> markRequestAsDone(int id, String? notes) async {
    late StandardHttpResponse response;

    try {
      response = await httpRepo.post(host: "$serverHost/$labRequestsController/markRequestAsDone?id=$id&${notes == null ? "" : "notes=$notes"}");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> payForRequest(int id, int amount, DateTime paymentDate) async {
    late StandardHttpResponse response;

    try {
      response = await httpRepo.post(
          host: "$serverHost/$labRequestsController/PayForRequest?id=$id&amount=$amount&paymentDate=${paymentDate.toUtc().toIso8601String()}");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> checkLabRequests(int id) async {
    late StandardHttpResponse response;

    try {
      response = await httpRepo.get(host: "$serverHost/$labRequestsController/CheckLabRequests?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updateLabRequest(LabRequestEntity model) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$labRequestsController/UpdateLabRequest",
        body: LabRequestModel.fromEntity(model).toJson(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> consumeLabItem(int id, int? number, bool consumeWholeBlock) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
          host:
              "$serverHost/$labRequestsController/ConsumeLabItem?id=$id&consumeWholeBlock=$consumeWholeBlock${number == null ? "" : "&number=$number"}");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<LabItemModel> getLabItemDetails(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$labRequestsController/GetLabItemDetails?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return LabItemModel.fromJson(response.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<ReceiptModel?> getRequestReceipt(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$labRequestsController/GetReceipt?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body == null) return null;
      return ReceiptModel.fromJson(response.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<LabStepItemModel>> getLabItemStepsFroRequest(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$labRequestsController/GetRequestStepItems?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body as List<dynamic>).map((e) => LabStepItemModel.fromJson(e as Map<String, dynamic>)).toList());
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<LabItemParentModel>> getLabItemsFromSettings() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$labRequestsController/GetRequestStepItems?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body as List<dynamic>).map((e) => LabItemParentModel.fromJson(e as Map<String, dynamic>)).toList());
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> deleteLabRequest(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.delete(
        host: "$serverHost/$labRequestsController/DeleteRequest?id=$id",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }
}
