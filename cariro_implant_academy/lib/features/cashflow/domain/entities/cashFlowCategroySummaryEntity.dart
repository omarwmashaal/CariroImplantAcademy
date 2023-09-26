import 'package:equatable/equatable.dart';

class CashFlowCategorySummaryEntity extends Equatable {
  int? ID;
  DateTime? Date;
  String? Item;
  int? Count;
  String? Supplier;
  int? Total;
  String? HandledBy;
  String? Category;

  CashFlowCategorySummaryEntity({
    this.Date,
    this.Item,
    this.Count,
    this.Supplier,
    this.Total,
    this.HandledBy,
    this.Category,
    this.ID,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.ID,
        this.Date,
        this.Item,
        this.Count,
        this.Supplier,
        this.Total,
        this.HandledBy,
        this.Category,
      ];

//IncomeDataSource dataSource = IncomeDataSource();
}
