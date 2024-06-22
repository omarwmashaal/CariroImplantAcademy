import 'package:equatable/equatable.dart';

import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/installmentPlanEntity.dart';

import '../../domain/entities/cashFlowSummaryEntity.dart';

abstract class CashFlowBloc_States extends Equatable {}

class CashFlowBloC_LoadingCashFlowState extends CashFlowBloc_States {
  @override
  List<Object?> get props => [];
}

class CashFlowBloC_ProcessingCashFlowState extends CashFlowBloc_States {
  @override
  List<Object?> get props => [];
}

class CashFlowBloC_LoadingCashFlowErrorState extends CashFlowBloc_States {
  final String message;

  CashFlowBloC_LoadingCashFlowErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class CashFlowBloC_ProcessingCashFlowErrorState extends CashFlowBloc_States {
  final String message;

  CashFlowBloC_ProcessingCashFlowErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class CashFlowBloC_LoadedCashFlowSuccessfullyState extends CashFlowBloc_States {
  final List<CashFlowEntity> data;

  CashFlowBloC_LoadedCashFlowSuccessfullyState({required this.data});

  @override
  List<Object?> get props => [data];
}

class CashFlowBloC_LoadedCashFlowSummarySuccessfullyState extends CashFlowBloc_States {
  final CashFlowSummaryEntity data;

  CashFlowBloC_LoadedCashFlowSummarySuccessfullyState({required this.data});

  @override
  List<Object?> get props => [data];
}

class CashFlowBloC_ProcessingCashFlowSuccessfullyState extends CashFlowBloc_States {
  @override
  List<Object?> get props => [];
}

class CashFlowBloC_CashFlowTotalState extends CashFlowBloc_States {
  final int total;
  CashFlowBloC_CashFlowTotalState({required this.total});
  @override
  List<Object?> get props => [total];
}

class CashFlowBloC_UpdateSummaryNetProfitState extends CashFlowBloc_States {
  final int incomeTotal;
  final int expensesTotal;

  CashFlowBloC_UpdateSummaryNetProfitState({
    required this.expensesTotal,
    required this.incomeTotal,
  });

  @override
  List<Object?> get props => [
        incomeTotal,
        expensesTotal,
      ];
}

class CashFlowBloC_LoadedInstallmentSuccessfullyState extends CashFlowBloc_States {
  final InstallmentPlanEntity? data;
  final bool? calculationsOnly;
  CashFlowBloC_LoadedInstallmentSuccessfullyState({
    required this.data,
    required this.calculationsOnly,
  });
  @override
  List<Object?> get props => [];
}

class CashFlowBloC_LoadingInstallmentState extends CashFlowBloc_States {
  @override
  List<Object?> get props => [];
}

class CashFlowBloC_LoadingInstallmentErrorState extends CashFlowBloc_States {
  final String message;
  CashFlowBloC_LoadingInstallmentErrorState({
    required this.message,
  });
  @override
  List<Object?> get props => [];
}

class CashFlowBloC_PayedInstallmentSuccessfullyState extends CashFlowBloc_States {
  @override
  List<Object?> get props => [];
}

class CashFlowBloC_PayingInstallmentState extends CashFlowBloc_States {
  @override
  List<Object?> get props => [];
}

class CashFlowBloC_PayingInstallmentErrorState extends CashFlowBloc_States {
  final String message;
  CashFlowBloC_PayingInstallmentErrorState({
    required this.message,
  });
  @override
  List<Object?> get props => [];
}

class CashFlowBloC_CreatedInstallmentSuccessfullyState extends CashFlowBloc_States {
  final InstallmentPlanEntity data;
  final bool calculationsOnly;
  CashFlowBloC_CreatedInstallmentSuccessfullyState({
    required this.data,
    required this.calculationsOnly,
  });
  @override
  List<Object?> get props => [];
}

class CashFlowBloC_CreatingInstallmentState extends CashFlowBloc_States {
  @override
  List<Object?> get props => [];
}

class CashFlowBloC_CreatingInstallmentErrorState extends CashFlowBloc_States {
  final String message;
  CashFlowBloC_CreatingInstallmentErrorState({
    required this.message,
  });
  @override
  List<Object?> get props => [];
}
