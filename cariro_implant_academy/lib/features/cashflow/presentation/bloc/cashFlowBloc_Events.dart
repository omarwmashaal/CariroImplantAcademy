import 'package:cariro_implant_academy/features/cashflow/domain/useCases/listIncomeUseCase.dart';
import 'package:equatable/equatable.dart';

import '../../../../Models/Enum.dart';
import '../../../../core/constants/enums/enums.dart';
import '../../domain/entities/cashFlowEntity.dart';

abstract class CashFlowBloc_Events extends Equatable {}

class CashFlowBloc_ListIncomeEvent extends CashFlowBloc_Events {
  final ListCashFlowParams params;

  CashFlowBloc_ListIncomeEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class CashFlowBloc_ListExpensesEvent extends CashFlowBloc_Events {
  final ListCashFlowParams params;

  CashFlowBloc_ListExpensesEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class CashFlowBloc_GetSummaryEvent extends CashFlowBloc_Events {
  final EnumSummaryFilter filter;

  CashFlowBloc_GetSummaryEvent({required this.filter});

  @override
  List<Object?> get props => [filter];
}

class CashFlowBloc_GetIncomeByCategoryEvent extends CashFlowBloc_Events {
  final int categoryID;
  final String filter;

  CashFlowBloc_GetIncomeByCategoryEvent({
    required this.filter,
    required this.categoryID,
  });

  @override
  List<Object?> get props => [categoryID, filter];
}

class CashFlowBloc_GetExpensesByCategoryEvent extends CashFlowBloc_Events {
  final int categoryID;
  final String filter;

  CashFlowBloc_GetExpensesByCategoryEvent({
    required this.filter,
    required this.categoryID,
  });

  @override
  List<Object?> get props => [categoryID, filter];
}

class CashFlowBloc_AddIncomeEvent extends CashFlowBloc_Events {
  final CashFlowEntity model;

  CashFlowBloc_AddIncomeEvent({required this.model});

  @override
  List<Object?> get props => [model];
}

class CashFlowBloc_AddExpenseEvent extends CashFlowBloc_Events {
  final List<CashFlowEntity> models;
  final bool isStockItem;
  final EnumExpenseseCategoriesType type;

  CashFlowBloc_AddExpenseEvent({
    required this.type,
    required this.isStockItem,
    required this.models,
  });

  @override
  List<Object?> get props => [
        models,
        isStockItem,
        type,
      ];
}

class CashFlowBloc_AddSettlementEvent extends CashFlowBloc_Events {
  final String filter;
  final int value;

  CashFlowBloc_AddSettlementEvent({
    required this.filter,
    required this.value,
  });

  @override
  List<Object?> get props => [filter, value];
}

class CashFlowBloc_GetExpenesesCategoryByNameEvent extends CashFlowBloc_Events {
  final String name;

  CashFlowBloc_GetExpenesesCategoryByNameEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

