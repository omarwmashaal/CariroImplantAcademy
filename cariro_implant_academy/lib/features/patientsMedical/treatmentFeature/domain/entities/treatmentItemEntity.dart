import 'package:equatable/equatable.dart';

class TreatmentItemEntity extends Equatable {
  int? id;
  String? name;
  int? price;
  String? priceAction;
  TreatmentItemEntity({
    this.id,
    this.name,
    this.price,
    this.priceAction,
  });

  @override
  List<Object?> get props => [
        this.id,
        this.name,
        this.price,
        this.priceAction,
      ];

  bool isImplant() => (name?.toLowerCase().contains("implant") ?? false) && !(name?.toLowerCase().contains("without") ?? false);
}
