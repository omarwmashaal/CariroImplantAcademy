import 'dart:ui';

class CIA_RoomModel {
  int? id;
  String? name;
  Color? color;

  CIA_RoomModel({this.id = 0, this.name = "Unspecified", this.color=const Color(4288585374)});

  CIA_RoomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']?? "Unspecified";
    color = Color(json['color']??4288585374);//0xd3d3d3
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id??1;
    data['name'] = this.name;
    data['color'] = (this.color??Color(4288585374)).value;
    return data;
  }
}
