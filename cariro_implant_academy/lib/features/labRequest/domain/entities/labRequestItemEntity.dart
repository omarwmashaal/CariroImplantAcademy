import 'package:equatable/equatable.dart';

class LabRequestItemEntity extends Equatable {
  String? name;
  String? description;
  int? number;
  int? price;
  int? totalPrice;

  LabRequestItemEntity({
    this.name,
    this.description,
    this.number,
    this.price,
    this.totalPrice,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        number,
        price,
        totalPrice,
      ];

  bool isNull() => this.description?.isEmpty ?? true && (this.number == null || this.number == 0);
}
