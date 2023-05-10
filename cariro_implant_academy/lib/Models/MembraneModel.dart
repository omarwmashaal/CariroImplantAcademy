class MembraneModel {
  int? id;
  String? size;

  MembraneModel({this.id, this.size = ""});

  MembraneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    return data;
  }
}
