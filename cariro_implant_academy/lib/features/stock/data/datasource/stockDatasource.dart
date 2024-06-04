import 'package:cariro_implant_academy/core/constants/remoteConstants.dart';

import '../../../../core/Http/httpRepo.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/stockEntity.dart';
import '../../domain/entities/stockLogEntity.dart';
import '../models/stockLogModel.dart';
import '../models/stockModel.dart';

abstract class StockDatasource {
  Future<List<StockModel>> getStock(String? search);
  Future<List<StockModel>> getLabStock(String? search, int? parentId, int? companyId, int? shadeId, bool? consumed);

  Future<List<StockLogModel>> getStockLogs(String? search, DateTime? from, DateTime? to, int? categoryId, int? operatorId, String? status);

  Future<StockModel> getStockByName(String search);
}

class StockDatasourceImpl implements StockDatasource {
  final HttpRepo httpRepo;

  StockDatasourceImpl({required this.httpRepo});

  @override
  Future<List<StockModel>> getStock(String? search) async {
    late StandardHttpResponse response;
    String query = "";
    if (search != null) query = "search=$search";
    try {
      response = await httpRepo.get(host: "$serverHost/$stockController/GetAllStock?$query");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => StockModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<StockLogModel>> getStockLogs(String? search, DateTime? from, DateTime? to, int? categoryId, int? operatorId, String? status) async {
    late StandardHttpResponse response;
    String query = "";
    if (search != null) query = "search=$search";
    if (from != null) query = "${query == "" ? "" : "&"}from=${from!.toUtc().toIso8601String()}";
    if (to != null) query = "${query == "" ? "" : "&"}to=${to!.toUtc().toIso8601String()}";
    if (categoryId != null) query = "${query == "" ? "" : "&"}categoryId=$categoryId";
    if (operatorId != null) query = "${query == "" ? "" : "&"}operatorId=$operatorId";
    if (status != null) query = "${query == "" ? "" : "&"}status=$status";
    try {
      response = await httpRepo.get(host: "$serverHost/$stockController/GetStockLogs?$query");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => StockLogModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<StockModel> getStockByName(String name) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$stockController/getStockByName?name=$name");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return StockModel.fromJson(response.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<StockModel>> getLabStock(String? search, int? parentId, int? companyId, int? shadeId, bool? consumed) async {
    late StandardHttpResponse response;
    String query = "";
    if (search != null) query = "search=$search";
    if (parentId != null) query = "${query == "" ? "" : "&"}parentId=$parentId";
    if (companyId != null) query = "${query == "" ? "" : "&"}companyId=$companyId";
    if (shadeId != null) query = "${query == "" ? "" : "&"}shadeId=$shadeId";
    if (consumed != null) query = "${query == "" ? "" : "&"}consumed=$consumed";
    try {
      response = await httpRepo.get(host: "$serverHost/$stockController/GetAllStockForLab?$query");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => StockModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }
}
