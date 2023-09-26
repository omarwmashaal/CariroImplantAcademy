import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';
import 'package:equatable/equatable.dart';

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
