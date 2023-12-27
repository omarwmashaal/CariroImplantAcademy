import 'package:equatable/equatable.dart';

import 'labItemEntity.dart';

class OmarEntity extends Equatable{
  String? name;
  String? description;
  int? number;
  int? price;
  int? totalPrice;
  int? labItemId;
  LabItemEntity? labItem;

  OmarEntity({
    this.name,
    this.description,
    this.number,
    this.price,
    this.totalPrice,
    this.labItem,
    this.labItemId,
  });

  @override
  List<Object?> get props => [
    name,
    description,
    number,
    price,
    totalPrice,
    labItem,
    labItemId,
  ];

  bool isNull() => this.description?.isEmpty ?? true && (this.number == null || this.number == 0);
}
