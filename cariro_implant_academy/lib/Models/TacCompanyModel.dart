class TacCompanyModel {
  int? id;
  String? name;
  int? number;

  TacCompanyModel({this.id, this.name = "",this.number=0});

  TacCompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "";
    number = json['number'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['number'] = this.number;
    return data;
  }
}
