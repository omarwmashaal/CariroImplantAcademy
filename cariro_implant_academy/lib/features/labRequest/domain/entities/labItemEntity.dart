import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockEntity.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class LabItemEntity extends StockEntity {
  int? id;
  int? price;
  String? code;
  int? consumedCount;
  bool? consumed;
  String? size;
  int? labItemShadeId;
  int? labItemCompanyId;
  int? labItemParentId;
  BasicNameIdObjectEntity? labItemShade;

  LabItemEntity({
    this.id,
    this.code,
    this.price,
    this.consumedCount = 0,
    this.consumed = false,
    this.size,
    this.labItemShadeId,
    this.labItemShade,
    this.labItemCompanyId,
    this.labItemParentId,
    super.name,
  });

  @override
  List<Object?> get  props => super.props..addAll([
        id,
        code,
        consumedCount,
        consumed,
        size,
        labItemShadeId,
        labItemShade,
      ]);

  bool isNull() => (code?.isBlank ?? true) ||  (size?.isBlank ?? true);
}
