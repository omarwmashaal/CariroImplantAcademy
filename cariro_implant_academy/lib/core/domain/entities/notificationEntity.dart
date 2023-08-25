import 'package:equatable/equatable.dart';

import '../../../Helpers/CIA_DateConverters.dart';
import '../../../Models/Enum.dart';

class NotificationEntity  extends Equatable{
  int? id;
  String? title;
  String? content;
  bool? read;
  String? date;
  int? infoId;
  EnumNotificationType? type;
  String? onClickAction;

  NotificationEntity({this.type,this.onClickAction,this.title, this.content, this.id, this.read = false, this.date = "", this.infoId});

  @override
  // TODO: implement props
  List<Object?> get props => [this.title, this.content, this.id, this.read, this.date, this.onClickAction,this.type, this.infoId];

}
