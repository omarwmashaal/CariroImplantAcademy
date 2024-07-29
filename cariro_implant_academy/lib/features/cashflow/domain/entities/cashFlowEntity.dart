import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/features/coreReceipt/domain/entities/receiptEntity.dart';
import 'package:equatable/equatable.dart';

class CashFlowEntity extends Equatable {
  int? id;
  int? receiptID;
  ReceiptEntity? receipt;
  DateTime? date;
  String? name;
  int? categoryId;
  BasicNameIdObjectEntity? category;
  int? supplierId;
  BasicNameIdObjectEntity? supplier;
  int? createdById;
  BasicNameIdObjectEntity? createdBy;
  int? patientId;
  int? candidateId;
  BasicNameIdObjectEntity? patient;
  BasicNameIdObjectEntity? candidate;
  int? price;
  int? count;
  int? paymentMethodId;
  BasicNameIdObjectEntity? paymentMethod;
  int? paymentLogId;
  BasicNameIdObjectEntity? paymentLog;
  String? notes;
  String? type;
  BasicNameIdObjectEntity? membraneCompany;
  BasicNameIdObjectEntity? membrane;
  BasicNameIdObjectEntity? tac;
  BasicNameIdObjectEntity? implantCompany;
  BasicNameIdObjectEntity? implantLine;
  BasicNameIdObjectEntity? implant;
  int? labRequestId;
  int? labItemShadeId;
  String? size;
  String? code;
  BasicNameIdObjectEntity? labItemParent;
  BasicNameIdObjectEntity? labItemCompany;
  BasicNameIdObjectEntity? labItemShade;
  CashFlowEntity({
    this.id,
    this.code,
    this.labItemShade,
    this.labItemCompany,
    this.labItemParent,
    this.labItemShadeId,
    this.receiptID,
    this.receipt,
    this.date,
    this.name,
    this.categoryId,
    this.category,
    this.supplierId,
    this.supplier,
    this.candidate,
    this.candidateId,
    this.createdById,
    this.createdBy,
    this.price = 0,
    this.count,
    this.paymentMethodId,
    this.paymentMethod,
    this.notes,
    this.size,
    this.type,
    this.membraneCompany,
    this.membrane,
    this.tac,
    this.implantCompany,
    this.implantLine,
    this.implant,
  }) {
    if (this.paymentMethod == null) this.paymentMethod = BasicNameIdObjectEntity();
    if (this.supplier == null) this.supplier = BasicNameIdObjectEntity();
    if (this.category == null) this.category = BasicNameIdObjectEntity();
  }

  @override
  List<Object?> get props => [
        this.id,
        this.receiptID,
        this.receipt,
        this.labItemShadeId,
        this.date,
        this.name,
        this.categoryId,
        this.category,
        this.supplierId,
        this.supplier,
        this.createdById,
        this.createdBy,
        this.price,
        this.size,
        this.count,
        this.paymentMethodId,
        this.paymentMethod,
        this.code,
        this.notes,
        this.type,
        this.membraneCompany,
        this.membrane,
        this.tac,
        this.implantCompany,
        this.implantLine,
        this.implant,
      ];
}
/*
class CashFlowDataSource extends DataGridSource {
  List<String> columns = [
    "ID",
    "Item",
    "Category",
    "Created by",
    "Amount",
    "Method",
    "Notes",
  ];

  List<CashFlowEntity> models = <CashFlowEntity>[];
  CashFlowType type;

  /// Creates the income data source class with required details.
  CashFlowDataSource({required this.type}) {
    init();
  }

  init() {
    if (type == CashFlowType.income) {
      columns = [
        "ID",
        "Date",
        "Category",
        "Created by",
        "Patient",
        "Receipt Id",
        "Payment Log Id",
        "Amount",
      ];
      if (siteController.getSite() == Website.Lab) {
        _cashFlowData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
          DataGridCell<int>(columnName: 'ID', value: e.id),
          DataGridCell<String>(columnName: 'Date', value: e.date),
          DataGridCell<String>(columnName: 'Created by', value: e.createdBy!.name),
          DataGridCell<int>(columnName: 'Amount', value: e.price ?? 0),
        ]))
            .toList();
      } else
        _cashFlowData = models
            .map<DataGridRow>((e) => DataGridRow(cells: [
          DataGridCell<int>(columnName: 'ID', value: e.id),
          DataGridCell<String>(columnName: 'Date', value: e.date),
          DataGridCell<String>(columnName: 'Category', value: e.category!.name),
          DataGridCell<String>(columnName: 'Created by', value: e.createdBy!.name),
          DataGridCell<String>(columnName: 'Patient', value: e.patient!.name),
          DataGridCell<int>(columnName: 'Receipt Id', value: e.receiptID),
          DataGridCell<int>(columnName: 'Payment Log Id', value: e.paymentLogId),
          DataGridCell<int>(columnName: 'Amount', value: e.price ?? 0),
        ]))
            .toList();
    } else if (type == CashFlowType.expenses) {
      columns = [
        "ID",
        "Item",
        "Date",
        "Category",
        "Supplier",
        "Created by",
        "Amount",
        "Method",
        "Notes",
      ];
      _cashFlowData = models
          .map<DataGridRow>((e) => DataGridRow(cells: [
        DataGridCell<int>(columnName: 'ID', value: e.id),
        DataGridCell<String>(columnName: 'Item', value: e.name),
        DataGridCell<String>(columnName: 'Date', value: e.date),
        DataGridCell<String>(columnName: 'Category', value: e.category!.name),
        DataGridCell<String>(columnName: 'Supplier', value: e.supplier!.name),
        DataGridCell<String>(columnName: 'Created by', value: e.createdBy!.name),
        DataGridCell<int>(columnName: 'Amount', value: e.price ?? 0),
        DataGridCell<String>(columnName: 'Method', value: e.paymentMethod!.name),
        DataGridCell<String>(columnName: 'Notes', value: e.notes ?? ""),
      ]))
          .toList();
    }
  }

  List<DataGridRow> _cashFlowData = [];

  @override
  List<DataGridRow> get rows => _cashFlowData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              e.value.toString(),
            ),
          );
        }).toList());
  }

  Future<bool> loadData({
    String? from,
    String? to,
    int? catId,
    int? paymentMethodId,
  }) async {
    late API_Response response;

    if (type == CashFlowType.income)
      response = await CashFlowAPI.ListIncome(from: from, to: to, catId: catId, paymentMethodId: paymentMethodId);
    else if (type == CashFlowType.expenses) response = await CashFlowAPI.ListExpenses(from: from, to: to, catId: catId, paymentMethodId: paymentMethodId);
    if (response.statusCode == 200) models = response.result as List<CashFlowEntity>;
    init();
    notifyListeners();

    return true;
  }
}
*/