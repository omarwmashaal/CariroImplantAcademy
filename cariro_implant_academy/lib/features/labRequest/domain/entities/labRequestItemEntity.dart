import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:equatable/equatable.dart';

class LabRequestItemEntity extends Equatable {
  String? name;
  String? description;
  int? number;
  int? price;
  int? totalPrice;
  int? labItemId;
  LabItemEntity? labItem;

  LabRequestItemEntity({
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
