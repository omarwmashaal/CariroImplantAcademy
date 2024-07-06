import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';

import '../../../../constants/remoteConstants.dart';
import '../../../../error/exception.dart';
import '../../../../useCases/useCases.dart';
import '../models/paymentLogModel.dart';
import '../models/receiptModel.dart';

abstract class ReceiptsDatasource {
  Future<ReceiptModel> getTodaysReceipt({required int patientId});
  Future<ReceiptModel> addReceipt(ReceiptEntity params);
  Future<ReceiptModel> getLastReceipt({required int patientId});

  Future<List<ReceiptModel>> getReceipts({required int patientId});

  Future<ReceiptModel> getReceiptById({required int receiptId});

  Future<List<PaymentLogModel>> getAllPaymentLogs({required int patientId});

  Future<List<PaymentLogModel>> getPaymentLogsforAReceipt({required int receiptId});

  Future<NoParams> addPayment({required int patientId, required int receiptId, required int paidAmount});

  Future<NoParams> removePayment({required int paymentId});

  Future<int> getTotalDebt({required int patientId});
  Future<NoParams> addPatientReceipt(int patientId, int tooth, String action, int? price);
}

class ReceiptsDatasourceImpl implements ReceiptsDatasource {
  final HttpRepo httpRepo;

  ReceiptsDatasourceImpl({required this.httpRepo});

  @override
  Future<NoParams> addPayment({required int patientId, required int receiptId, required int paidAmount}) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.post(
        host: "$serverHost/$patientInfoController/AddPayment?id=$patientId&receiptId=$receiptId&paidAmount=$paidAmount",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    return NoParams();
  }

  @override
  Future<List<PaymentLogModel>> getAllPaymentLogs({required int patientId}) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.get(
        host: "$serverHost/$patientInfoController/GetAllPaymentLogs?id=$patientId",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      return ((result.body ?? []) as List<dynamic>).map((e) => PaymentLogModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException();
    }
  }

  @override
  Future<ReceiptModel> getLastReceipt({required int patientId}) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.get(
        host: "$serverHost/$patientInfoController/GetLastReceipt?id=$patientId",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      if (result.body == null) return ReceiptModel();
      return ReceiptModel.fromJson(result.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException();
    }
  }

  @override
  Future<List<PaymentLogModel>> getPaymentLogsforAReceipt({required int receiptId}) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.get(
        host: "$serverHost/$patientInfoController/GetPaymentLogsForAReceipt?receiptId=$receiptId",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      return ((result.body ?? []) as List<dynamic>).map((e) => PaymentLogModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException();
    }
  }

  @override
  Future<ReceiptModel> getReceiptById({required int receiptId}) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.get(
        host: "$serverHost/$patientInfoController/getReceiptById?id=$receiptId",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      if (result.body == null) return ReceiptModel();
      return ReceiptModel.fromJson(result.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException();
    }
  }

  @override
  Future<List<ReceiptModel>> getReceipts({required int patientId}) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.get(
        host: "$serverHost/$patientInfoController/getReceipts?id=$patientId",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      return ((result.body ?? []) as List<dynamic>).map((e) => ReceiptModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException();
    }
  }

  @override
  Future<ReceiptModel> getTodaysReceipt({required int patientId}) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.get(
        host: "$serverHost/$patientInfoController/getTodaysReceipt?id=$patientId",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      if (result.body == null) return ReceiptModel();
      return ReceiptModel.fromJson(result.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException();
    }
  }

  @override
  Future<int> getTotalDebt({required int patientId}) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.get(
        host: "$serverHost/$patientInfoController/getTotalDebt?id=$patientId",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      return (result.body ?? 0) as int;
    } catch (e) {
      throw DataConversionException();
    }
  }

  @override
  Future<NoParams> removePayment({required int paymentId}) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.post(
        host: "$serverHost/$patientInfoController/RemovePayment?id=$paymentId",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> addPatientReceipt(int patientId, int tooth, String action, int? price) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.put(
        host: "$serverHost/$medicalController/AddPatientReceipt?id=$patientId&tooth=$tooth&action=$action${price != null ? "&price=$price" : ""}",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    return NoParams();
  }

  @override
  Future<ReceiptModel> addReceipt(ReceiptEntity params) async {
    late StandardHttpResponse result;
    try {
      result = await httpRepo.post(
        host: "$serverHost/$cashFlowController/AddReceipt",
        body: ReceiptModel.fromEntity(params).toJson(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (result.statusCode != 200) throw getHttpException(statusCode: result.statusCode, message: result.errorMessage);
    try {
      if (result.body == null) return ReceiptModel();
      return ReceiptModel.fromJson(result.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException();
    }
  }
}
