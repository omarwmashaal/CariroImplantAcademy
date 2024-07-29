import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/data/models/toDoListModel.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/todoListEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/searchToDoListUseCase%20.dart';

import '../../../../core/constants/remoteConstants.dart';

abstract class ToDoListDatasource {
  Future<List<ToDoListModel>> getToDoLists(int? patientId);
  Future<List<ToDoListEntity>> searchToDoLists(SearchToDoListParams params);
  Future<NoParams> updateToDoListItem(ToDoListEntity toDoListItem, bool delete);
  Future<NoParams> addToDoListItem(ToDoListEntity toDoListItem);
}

class ToDoListDatasourceImpl implements ToDoListDatasource {
  final HttpRepo httpRepo;

  ToDoListDatasourceImpl({required this.httpRepo});

  @override
  Future<NoParams> addToDoListItem(ToDoListEntity toDoListItem) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$patientInfoController/AddToDoList",
        body: ToDoListModel.fromEntity(toDoListItem).toJson(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<List<ToDoListModel>> getToDoLists(int? patientId) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$patientInfoController/GetToDoLists?${patientId == null ? "" : "patientId=$patientId"}");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body != null)
        return ((response.body ?? []) as List<dynamic>).map((e) => ToDoListModel.fromJson(e as Map<String, dynamic>)).toList();
      else
        return [];
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> updateToDoListItem(ToDoListEntity toDoListItem, bool delete) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host: "$serverHost/$patientInfoController/UpdateToDoListItem?delete=$delete",
        body: ToDoListModel.fromEntity(toDoListItem).toJson(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<List<ToDoListEntity>> searchToDoLists(params) async {
    late StandardHttpResponse response;
    String query = "";
    query += params.done != null ? "${query == "" ? "" : "&"}done=${params.done}" : "";
    query += params.search != null ? "${query == "" ? "" : "&"}search=${params.search}" : "";
    query += params.overdue != null ? "${query == "" ? "" : "&"}overdue=${params.overdue}" : "";
    try {
      response = await httpRepo.get(host: "$serverHost/$patientInfoController/SearchToDoLists?$query");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body != null)
        return ((response.body ?? []) as List<dynamic>).map((e) => ToDoListModel.fromJson(e as Map<String, dynamic>)).toList();
      else
        return [];
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }
}
