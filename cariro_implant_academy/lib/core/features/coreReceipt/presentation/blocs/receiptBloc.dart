import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/presentation/blocs/receiptBloc_States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/addPaymentUsecase.dart';
import '../../domain/usecases/getPaymentLogsForAReceiptUsecase.dart';
import '../../domain/usecases/getReceiptByIdUsecase.dart';
import '../../domain/usecases/getReceipts.dart';
import '../../domain/usecases/removePaymentUsecase.dart';

class ReceiptBloc extends Cubit<ReceiptBloc_States> {
  final GetReceiptsUsecase getReceiptsUsecase;
  final GetReceiptByIdUseCase getReceiptByIdUseCase;
  final GetPaymentLogsForAReceiptUseCase getPaymentLogsForAReceipt;
  final RemovePaymentUseCase removePaymentUseCase;
  final AddPaymentUseCase addPaymentUseCase;

  ReceiptBloc({
    required this.getReceiptsUsecase,
    required this.getReceiptByIdUseCase,
    required this.getPaymentLogsForAReceipt,
    required this.removePaymentUseCase,
    required this.addPaymentUseCase,
  }) : super(ReceiptBloc_InitiState());

  void getPatientReceipts(int patientId) async {
    emit(ReceiptBloc_LoadingReceiptsState());
    final result = await getReceiptsUsecase(patientId);
    result.fold(
      (l) => emit(ReceiptBloc_LoadingReceiptsErrorState(message: l.message ?? "")),
      (r) => emit(ReceiptBloc_LoadedReceiptsSuccessfullyState(data: r)),
    );
  }

  void loadPaymentLogTableData({required int receiptId}) async {
    emit(ReceiptBloc_LoadingPaymentLogsState());
    final result = await getReceiptByIdUseCase(receiptId);
    late ReceiptEntity receiptEntity;
    result.fold(
      (l) {
        emit(ReceiptBloc_LoadingPaymentLogsErrorState(message: l.message ?? ""));
        return;
      },
      (r) => receiptEntity = r,
    );
    if (result.isRight()) {
      await getPaymentLogsForAReceipt(GetPaymentLogForAReceiptParams(
        receiptId: receiptId,
      )).then((value) => value.fold(
            (l) => emit(ReceiptBloc_LoadingPaymentLogsErrorState(message: l.message ?? "")),
            (r) => emit(ReceiptBloc_LoadedPaymentLogsSuccessfullyState(
              paymentLogs: r,
              receipt: receiptEntity,
            )),
          ));
    }
  }

  void removePayment({required int paymentId}) async {
    emit(ReceiptBloc_RemovingPaymentState());
    final result = await removePaymentUseCase(paymentId);
    result.fold(
      (l) => emit(ReceiptBloc_RemovingPaymentErrorState(message: l.message ?? "")),
      (r) => emit(ReceiptBloc_RemovedPaymentSuccessfullyState()),
    );
  }

  void addPayment({required int patientId, required int receiptId, required int paidAmount}) async {
    emit(ReceiptBloc_AddingPaymentState());
    final result = await addPaymentUseCase(AddPaymentParams(
      patientId: patientId,
      receiptId: receiptId,
      paidAmount: paidAmount,
    ));
    result.fold(
      (l) => emit(ReceiptBloc_AddingPaymentErrorState(message: l.message ?? "")),
      (r) => emit(ReceiptBloc_AddedPaymentSuccessfullyState()),
    );
  }
}
