class DropDownDTO {
  int? id;
  String? name;

  DropDownDTO({this.id, this.name=""});

  DropDownDTO.fromJson(Map<String, dynamic> json) {
    try{
      id = json['id'];
    }
    catch(e){
      id = json['idInt']??0;
    }
    name = json['name']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
