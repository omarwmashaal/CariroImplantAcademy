import 'package:equatable/equatable.dart';

abstract class StockBloc_Events extends Equatable{}

class StockBloc_GetStockEvent extends StockBloc_Events{
  final String? search;
  StockBloc_GetStockEvent({required this.search});
  @override
  // TODO: implement props
  List<Object?> get props => [search];
}
class StockBloc_GetStockLogEvent extends StockBloc_Events{
  final String? search;
  StockBloc_GetStockLogEvent({required this.search});
  @override
  // TODO: implement props
  List<Object?> get props => [search];
}