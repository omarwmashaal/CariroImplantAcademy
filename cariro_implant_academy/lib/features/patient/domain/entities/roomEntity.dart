import 'dart:ui';

import 'package:equatable/equatable.dart';

class RoomEntity extends Equatable {
  int? id;
  String? name;
  Color? color;

  RoomEntity({this.id = 0, this.name = "Unspecified", this.color = const Color(4288585374)});



  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        color,
      ];
}
