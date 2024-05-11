import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';

class ProstheticDataEntity extends BasicNameIdObjectEntity {
  int? itemId;
  BasicNameIdObjectEntity? item;
  ProstheticDataEntity({
    this.itemId,
    this.item,
  });
}
