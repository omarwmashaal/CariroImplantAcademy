import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/toothReceiptEntity.dart';

class ToothReceiptModel extends ToothReceiptEntity {
  ToothReceiptModel({
    super.crown,
    super.extraction,
    super.restoration,
    super.rootCanalTreatment,
    super.scaling,
    super.tooth,
  });
  ToothReceiptModel.fromJson(Map<String, dynamic> json) {
    crown = json['crown'];
    scaling = json['scaling'];
    restoration = json['restoration'];
    rootCanalTreatment = json['rootCanalTreatment'];
    extraction = json['extraction'];
    tooth = json['tooth'];
  }
}