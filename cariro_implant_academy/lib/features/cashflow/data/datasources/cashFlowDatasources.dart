import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/features/cashflow/data/models/cashFlowModel.dart';
import 'package:cariro_implant_academy/features/cashflow/data/models/cashFlowSummaryModel.dart';
import 'package:cariro_implant_academy/features/cashflow/data/models/installmentPlanModel.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';

import '../../../../core/constants/enums/enums.dart';
import '../../../../core/Http/httpRepo.dart';
import '../../../../core/constants/enums/enums.dart';
import '../../../../core/constants/remoteConstants.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/useCases/useCases.dart';

abstract class CashFlowDatasource {
  Future<List<CashFlowModel>> listIncome({String? from, String? to, int? catId, int? paymentMethodId});

  Future<List<CashFlowModel>> listExpenses({String? from, String? to, int? catId, int? paymentMethodId});

  Future<CashFlowSummaryModel> getSummary(EnumSummaryFilter filter);

  Future<CashFlowSummaryModel> getIncomeByCategory(int categoryID, String filter);

  Future<CashFlowSummaryModel> getExpensesByCategory(int categoryID, String filter);

  Future<NoParams> addIncome(CashFlowEntity model);

  Future<NoParams> addExpense(List<CashFlowEntity> models, bool isStockItem, EnumExpenseseCategoriesType type, Website inventoryWebsite);

  Future<NoParams> addSettlement(String filter, int value);

  Future<BasicNameIdObjectModel> getExpenesesCategoryByName(String name);
  Future<InstallmentPlanModel?> getInstallmentsOfUser(int id);
  Future<NoParams> payInstallment(int installmentPlanId, int value);
  Future<InstallmentPlanModel> createInstallmentPlan(int? id, int total, DateTime startDate, int numberOfPayments, EnumInstallmentInterval interval);
}

class CashFlowDataSourceImpl implements CashFlowDatasource {
  final HttpRepo httpRepo;

  CashFlowDataSourceImpl({required this.httpRepo});

  @override
  Future<NoParams> addExpense(List<CashFlowEntity> models, bool isStockItem, EnumExpenseseCategoriesType type, Website inventoryWebsite) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host:
            "$serverHost/$cashFlowController/${(siteController.getSite() == Website.Lab || inventoryWebsite == Website.Lab) && type == EnumExpenseseCategoriesType.BoughtMedical ? "AddLabExpense" : "addExpense"}?type=${type.index}&inventoryWebsite=${inventoryWebsite.index}",
        body: models.map((e) => CashFlowModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> addIncome(CashFlowEntity model) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host: "$serverHost/$cashFlowController/AddIncome?",
        body: CashFlowModel.fromEntity(model).toJson(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> addSettlement(String filter, int value) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(host: "$serverHost/$cashFlowController/AddSettlement?value=$value&filter=$filter");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<BasicNameIdObjectModel> getExpenesesCategoryByName(String name) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$cashFlowController/getExpenesesCategoryByName?name=$name");
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
  Future<CashFlowSummaryModel> getExpensesByCategory(int categoryID, String filter) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$cashFlowController/getExpensesByCategory?categoryID=$categoryID&filter=$filter");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return CashFlowSummaryModel.fromJson(response.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<CashFlowSummaryModel> getIncomeByCategory(int categoryID, String filter) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$cashFlowController/getIncomeByCategory?categoryID=$categoryID&filter=$filter");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return CashFlowSummaryModel.fromJson(response.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<CashFlowSummaryModel> getSummary(EnumSummaryFilter filter) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$cashFlowController/getSummary?filter=${filter.index}");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return CashFlowSummaryModel.fromJson(response.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<CashFlowModel>> listExpenses({String? from, String? to, int? catId, int? paymentMethodId}) async {
    late StandardHttpResponse response;
    try {
      var query = "";
      if (from != null) query += "${query == "" ? "" : "&"}from=$from";
      if (to != null) query += "${query == "" ? "" : "&"}to=$to";
      if (catId != null) query += "${query == "" ? "" : "&"}catId=$catId";
      if (paymentMethodId != null) query += "${query == "" ? "" : "&"}paymentMethodId=$paymentMethodId";

      response = await httpRepo.get(host: "$serverHost/$cashFlowController/listExpenses?$query");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => CashFlowModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<CashFlowModel>> listIncome({String? from, String? to, int? catId, int? paymentMethodId}) async {
    late StandardHttpResponse response;
    try {
      var query = "";
      if (from != null) query += "${query == "" ? "" : "&"}from=$from";
      if (to != null) query += "${query == "" ? "" : "&"}to=$to";
      if (catId != null) query += "${query == "" ? "" : "&"}catId=$catId";
      if (paymentMethodId != null) query += "${query == "" ? "" : "&"}paymentMethodId=$paymentMethodId";

      response = await httpRepo.get(host: "$serverHost/$cashFlowController/listIncome?$query");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => CashFlowModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<InstallmentPlanModel> createInstallmentPlan(
    int? id,
    int total,
    DateTime startDate,
    int numberOfPayments,
    EnumInstallmentInterval interval,
  ) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host:
            "$serverHost/$cashFlowController/createInstallmentPlan?total=$total&startDate=${startDate.toIso8601String()}&numberOfPayments=$numberOfPayments&interval=${interval.index}${id == null ? "" : "&id=$id"}",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return InstallmentPlanModel.fromJson(response.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<InstallmentPlanModel?> getInstallmentsOfUser(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$cashFlowController/getInstallmentsOfUser?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      if (response.body == null) return null;
      return InstallmentPlanModel.fromJson(response.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> payInstallment(int installmentPlanId, int value) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$cashFlowController/payInstallment?installmentPlanId=$installmentPlanId&value=$value",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }
}
