import 'package:cariro_implant_academy/features/stock/domain/entities/stockEntity.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockLogEntity.dart';
import 'package:equatable/equatable.dart';

abstract class StockBloc_States extends Equatable{}

class StockBloc_LoadingState extends StockBloc_States{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class StockBloc_LoadingErrorState extends StockBloc_States{
  final String message;
  StockBloc_LoadingErrorState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class StockBloc_LoadedStockSuccessfullyState extends StockBloc_States{
  final List<dynamic> data;
  StockBloc_LoadedStockSuccessfullyState({required this.data});
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class StockBloc_LoadedStockLogSuccessfullyState extends StockBloc_States{
  final List<StockLogEntity> data;
  StockBloc_LoadedStockLogSuccessfullyState({required this.data});
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}