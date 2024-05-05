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
}