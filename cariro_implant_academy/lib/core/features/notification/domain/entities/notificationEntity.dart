import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../Helpers/CIA_DateConverters.dart';
import '../../../../constants/enums/enums.dart';

class NotificationEntity  extends Equatable{
  int? id;
  String? title;
  String? content;
  bool? read;
  DateTime? date;
  int? infoId;
  EnumNotificationType? type;
  Function(BuildContext context)? onClickAction;

  NotificationEntity({this.type,this.onClickAction,this.title, this.content, this.id, this.read = false, this.date , this.infoId});

  @override
  // TODO: implement props
  List<Object?> get props => [this.title, this.content, this.id, this.read, this.date, this.onClickAction,this.type, this.infoId];

}
