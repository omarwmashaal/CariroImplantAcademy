import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class LabItemEntity extends Equatable {
  int? id;
  String? code;
  int? consumedCount;
  int? unitPrice;
  bool? consumed;
  String? size;
  int? labItemShadeId;
  BasicNameIdObjectEntity? labItemShade;

  LabItemEntity({
    this.id,
    this.code,
    this.consumedCount = 0,
    this.unitPrice = 0,
    this.consumed = false,
    this.size,
    this.labItemShadeId,
    this.labItemShade,
  });

  @override
  List<Object?> get props => [
        id,
        code,
        consumedCount,
        unitPrice,
        consumed,
        size,
        labItemShadeId,
        labItemShade,
      ];

  bool isNull() => (code?.isBlank ?? true) || (unitPrice?.isBlank ?? true) || (size?.isBlank ?? true);
}
