import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/data/models/receiptModel.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/entities/cashFlowEntity.dart';

class CashFlowModel extends CashFlowEntity {
  CashFlowModel({
    super.id,
    super.code,
    super.receiptID,
    super.receipt,
    super.candidate,
    super.candidateId,
    super.size,
    super.date,
    super.name,
    super.categoryId,
    super.category,
    super.supplierId,
    super.supplier,
    super.createdById,
    super.createdBy,
    super.price,
    super.count,
    super.paymentMethodId,
    super.paymentMethod,
    super.notes,
    super.type,
    super.membraneCompany,
    super.membrane,
    super.tac,
    super.implantCompany,
    super.implantLine,
    super.implant,
    super.labItemShadeId,
  });

  factory CashFlowModel.fromEntity(CashFlowEntity entity) {
    return CashFlowModel(
      id: entity.id,
      size: entity.size,
      code: entity.code,
      candidate: entity.candidate,
      candidateId: entity.candidateId,
      labItemShadeId: entity.labItemShadeId,
      receiptID: entity.receiptID,
      receipt: entity.receipt,
      date: entity.date,
      name: entity.name,
      categoryId: entity.categoryId,
      category: entity.category,
      supplierId: entity.supplierId,
      supplier: entity.supplier,
      createdById: entity.createdById,
      createdBy: entity.createdBy,
      price: entity.price,
      count: entity.count,
      paymentMethodId: entity.paymentMethodId,
      paymentMethod: entity.paymentMethod,
      notes: entity.notes,
      type: entity.type,
      membraneCompany: entity.membraneCompany,
      membrane: entity.membrane,
      tac: entity.tac,
      implantCompany: entity.implantCompany,
      implantLine: entity.implantLine,
      implant: entity.implant,
    );
  }

  CashFlowModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    labItemShadeId = json['labItemShadeId'];
    receiptID = json['receiptID'];
    candidateId = json['candidateId'];
    size = json['size'];
    labRequestId = json['labRequestId'];
    date = DateTime.tryParse(json['date'] ?? "")?.toLocal();
    name = json['name'];
    categoryId = json['categoryId'];
    category = json['category'] != null ? new BasicNameIdObjectModel.fromJson(json['category']) : BasicNameIdObjectModel();
    patientId = json['patientId'];
    patient = json['patient'] != null ? new BasicNameIdObjectModel.fromJson(json['patient']) : null;
    candidate = json['candidate'] != null ? new BasicNameIdObjectModel.fromJson(json['candidate']) : null;
    supplierId = json['supplierId'];
    supplier = json['supplier'] != null ? new BasicNameIdObjectModel.fromJson(json['supplier']) : BasicNameIdObjectModel();
    createdById = json['createdById'];
    createdBy = json['createdBy'] != null ? new BasicNameIdObjectModel.fromJson(json['createdBy']) : BasicNameIdObjectModel();
    price = json['price'];
    count = json['count'];
    paymentMethodId = json['paymentMethodId'];
    paymentMethod = json['paymentMethod'] != null ? new BasicNameIdObjectModel.fromJson(json['paymentMethod']) : BasicNameIdObjectModel();
    paymentLogId = json['paymentLogId'];
    paymentLog = json['paymentLog'] != null ? new BasicNameIdObjectModel.fromJson(json['paymentLog']) : BasicNameIdObjectModel();
    notes = json['notes'];
    type = json['type'];
    receiptID = json['receiptID'];
    receipt = ReceiptModel.fromJson(json['receipt'] ?? Map<String, dynamic>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    data['code'] = this.code;
    data['labItemShadeId'] = this.labItemShadeId;
    data['receiptID'] = this.receiptID;
    data['candidateId'] = this.candidateId;
    data['receipt'] = this.receipt;
    data['date'] = this.date == null ? null : this.date!.toUtc().toIso8601String();
    data['name'] = this.name;
    data['categoryId'] = this.categoryId;
    if (this.category != null) {
      data['category'] = BasicNameIdObjectModel.fromEntity(this.category!).toJson();
    }
    data['supplierId'] = this.supplierId;
    if (this.supplier != null) {
      data['supplier'] = BasicNameIdObjectModel.fromEntity(this.supplier!).toJson();
    }
    data['createdById'] = this.createdById;
    data['createdBy'] = this.createdBy;
    data['price'] = this.price;
    data['count'] = this.count;
    data['paymentMethodId'] = this.paymentMethodId;
    if (this.paymentMethod != null) {
      data['paymentMethod'] = BasicNameIdObjectModel.fromEntity(this.paymentMethod!).toJson();
    }
    data['notes'] = this.notes;
    data['type'] = this.type;
    return data;
  }
}
