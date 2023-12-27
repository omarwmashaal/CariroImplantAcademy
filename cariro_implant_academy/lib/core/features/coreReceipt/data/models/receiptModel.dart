import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/data/models/toothReceiptModel.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';

import '../../../../../features/labRequest/data/models/OmarModel.dart';

class ReceiptModel extends ReceiptEntity {
  ReceiptModel({
    super.id,
    super.date,
    super.patientId,
    super.patient,
    super.operatorId,
    super.operator,
    super.toothReceiptData,
    super.total,
    super.paid,
    super.unpaid,
    super.prices,
    super.isPaid,
    super.labFees,
    super.zirconUnit,
    super.waxUp,
    super.threeDPrinting,
    super.tiBar,
    super.tiAbutment,
    super.printedPMMA,
    super.milledPMMA,
    super.emaxVeneer,
    super.compositeInlay,
    super.pfm,
  });

  factory ReceiptModel.fromEntity(ReceiptEntity entity)
  {
    return ReceiptModel(
      date:entity.date,
      id:entity.id,
      operator:entity.operator,
      operatorId:entity.operatorId,
      paid:entity.paid,
      patient:entity.patient,
      patientId:entity.patientId,
      toothReceiptData:entity.toothReceiptData,
      total:entity.total,
      unpaid:entity.unpaid,
      prices:entity.prices,
      isPaid:entity.isPaid,
      labFees:entity.labFees,
      zirconUnit:entity.zirconUnit,
      waxUp:entity.waxUp,
      threeDPrinting:entity.threeDPrinting,
      tiBar:entity.tiBar,
      tiAbutment:entity.tiAbutment,
      printedPMMA:entity.printedPMMA,
      milledPMMA:entity.milledPMMA,
      emaxVeneer:entity.emaxVeneer,
      compositeInlay:entity.compositeInlay,
      pfm:entity.pfm,
    );
  }
  ReceiptModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = DateTime.tryParse(json['date']??"")?.toLocal();
    patientId = json['patientId'];
    patient = BasicNameIdObjectModel.fromJson(json['patient'] ?? Map<String, dynamic>());
    operatorId = json['operatorId'];
    operator = BasicNameIdObjectModel.fromJson(json['operator'] ?? Map<String, dynamic>());
    toothReceiptData = ((json['toothReceiptData']??[]) as List<dynamic> ).map((e) => ToothReceiptModel.fromJson(e as Map<String,dynamic>)).toList();
    total = json['total'];
    paid = json['paid'];
    unpaid = json['unpaid'];
    prices = json['clinicPrices']==null?null:(json['clinicPrices'] as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e)).toList();
    isPaid = json['isPaid'];
    labFees = json['labFees'];
    zirconUnit = json['zirconUnit']==null?null:OmarModelsss.fromJson(json['zirconUnit']);
    waxUp = json['waxUp']==null?null:OmarModelsss.fromJson(json['waxUp']);
    threeDPrinting = json['threeDPrinting']==null?null:OmarModelsss.fromJson(json['threeDPrinting']);
    tiBar = json['tiBar']==null?null:OmarModelsss.fromJson(json['tiBar']);
    tiAbutment = json['tiAbutment']==null?null:OmarModelsss.fromJson(json['tiAbutment']);
    printedPMMA = json['printedPMMA']==null?null:OmarModelsss.fromJson(json['printedPMMA']);
    milledPMMA = json['milledPMMA']==null?null:OmarModelsss.fromJson(json['milledPMMA']);
    emaxVeneer = json['emaxVeneer']==null?null:OmarModelsss.fromJson(json['emaxVeneer']);
    compositeInlay = json['compositeInlay']==null?null:OmarModelsss.fromJson(json['compositeInlay']);
    pfm = json['pfm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date==null?null:this.date!.toUtc().toIso8601String();
    data['patientId'] = this.patientId;
    //data['patient'] = this.patient == null ? null : BasicNameIdObjectModel.fromEntity(this.patient!).t();
    data['operatorId'] = this.operatorId;
 //   data['operator'] = this.operator == null ? null : this.operator!.toJson();
    data['total'] = this.total;
    data['paid'] = this.paid;
    data['unpaid'] = this.unpaid;
    data['isPaid'] = this.isPaid;
    data['labFees'] = this.labFees;
    data['zirconUnit'] = this.zirconUnit==null?null:OmarModelsss.fromEntity(this.zirconUnit!).toJson();
    data['waxUp'] = this.waxUp==null?null:OmarModelsss.fromEntity(this.waxUp!).toJson();
    data['threeDPrinting'] = this.threeDPrinting==null?null:OmarModelsss.fromEntity(this.threeDPrinting!).toJson();
    data['tiBar'] = this.tiBar==null?null:OmarModelsss.fromEntity(this.tiBar!).toJson();
    data['tiAbutment'] = this.tiAbutment==null?null:OmarModelsss.fromEntity(this.tiAbutment!).toJson();
    data['printedPMMA'] = this.printedPMMA==null?null:OmarModelsss.fromEntity(this.printedPMMA!).toJson();
    data['milledPMMA'] = this.milledPMMA==null?null:OmarModelsss.fromEntity(this.milledPMMA!).toJson();
    data['emaxVeneer'] = this.emaxVeneer==null?null:OmarModelsss.fromEntity(this.emaxVeneer!).toJson();
    data['compositeInlay'] = this.compositeInlay==null?null:OmarModelsss.fromEntity(this.compositeInlay!).toJson();
    data['pfm'] = this.pfm==null?null:OmarModelsss.fromEntity(this.pfm!).toJson();
    return data;
  }
}
