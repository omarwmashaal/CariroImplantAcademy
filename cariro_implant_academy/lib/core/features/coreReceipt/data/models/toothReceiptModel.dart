import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/toothReceiptEntity.dart';

class ToothReceiptModel extends ToothReceiptEntity {
  ToothReceiptModel({
    super.price,
    super.tooth,
    super.name,
  });
  ToothReceiptModel.fromJson(Map<String, dynamic> json) {
    tooth = json['tooth'];
    name = json['name'];
    price = json['price'];
  }
  ToothReceiptModel.fromEntity(ToothReceiptEntity entity) {
    tooth = entity.tooth;
    name = entity.name;
    price = entity.price;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['tooth'] = this.tooth;
    data['price'] = this.price;
    data['name'] = this.name;
    return data;
  }
}
