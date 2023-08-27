import 'dart:ui';

import 'package:cariro_implant_academy/features/patientVisits/domain/entity/roomEntity.dart';

class RoomModel extends RoomEntity {
  RoomModel({
    id=0,
    name="Unspecified",
    color=  const Color(4288585374),
  }) : super(
          id: id,
          color: color,
          name: name,
        );

  RoomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "Unspecified";
    color = Color(json['color'] ?? 4288585374); //0xd3d3d3
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? 1;
    data['name'] = this.name;
    data['color'] = (this.color ?? Color(4288585374)).value;
    return data;
  }
}
