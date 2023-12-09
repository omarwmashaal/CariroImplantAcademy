import 'StockModel.dart';

class ImplantModelsss {
  int? id;
  String? name;
  String? size;
  int? count;
  int? stockItemId;
  StockModel? stockItem;

  ImplantModelsss(
      {this.id,
        this.name="",
        this.size="",
        this.count,
        this.stockItemId,
        this.stockItem});

  ImplantModelsss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']??"";
    size = json['size'];
    count = json['count'];
    stockItemId = json['stockItemId'];
    stockItem = json['stockItem'] != null
        ? new StockModel.fromJson(json['stockItem'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['size'] = this.size;
    data['count'] = this.count;
    data['stockItemId'] = this.stockItemId;
    if (this.stockItem != null) {
      data['stockItem'] = this.stockItem!.toJson();
    }
    return data;
  }
}