import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/paymentLogEntity.dart';

abstract class ReceiptBloc_States extends Equatable {}

class ReceiptBloc_InitiState extends ReceiptBloc_States {
  @override
  List<Object?> get props => [];
}

class ReceiptBloc_LoadingReceiptsState extends ReceiptBloc_States {
  @override
  List<Object?> get props => [];
}

class ReceiptBloc_LoadingReceiptsErrorState extends ReceiptBloc_States {
  final String message;

  ReceiptBloc_LoadingReceiptsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReceiptBloc_LoadedReceiptsSuccessfullyState extends ReceiptBloc_States {
  final List<ReceiptEntity> data;

  ReceiptBloc_LoadedReceiptsSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [data,identityHashCode(this)];
}

class ReceiptBloc_LoadingPaymentLogsState extends ReceiptBloc_States {
  @override
  List<Object?> get props => [];
}

class ReceiptBloc_LoadingPaymentLogsErrorState extends ReceiptBloc_States {
  final String message;

  ReceiptBloc_LoadingPaymentLogsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReceiptBloc_LoadedPaymentLogsSuccessfullyState extends ReceiptBloc_States {
  final List<PaymentLogEntity> paymentLogs;
  final ReceiptEntity receipt;

  ReceiptBloc_LoadedPaymentLogsSuccessfullyState({
    required this.paymentLogs,
    required this.receipt,
  });

  @override
  List<Object?> get props => [paymentLogs, receipt];
}

class ReceiptBloc_RemovingPaymentState extends ReceiptBloc_States {
  @override
  List<Object?> get props => [];
}

class ReceiptBloc_RemovingPaymentErrorState extends ReceiptBloc_States {
  final String message;

  ReceiptBloc_RemovingPaymentErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReceiptBloc_RemovedPaymentSuccessfullyState extends ReceiptBloc_States {
  @override
  List<Object?> get props => [];
}
class ReceiptBloc_AddingPaymentState extends ReceiptBloc_States {
  @override
  List<Object?> get props => [];
}

class ReceiptBloc_AddingPaymentErrorState extends ReceiptBloc_States {
  final String message;

  ReceiptBloc_AddingPaymentErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReceiptBloc_AddedPaymentSuccessfullyState extends ReceiptBloc_States {
  @override
  List<Object?> get props => [];
}
