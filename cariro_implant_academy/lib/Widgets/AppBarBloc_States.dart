import 'package:cariro_implant_academy/core/domain/entities/notificationEntity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../Models/NotificationModel.dart';

abstract class AppBarBlocState extends Equatable{}

class AppBarNewNotificationState extends AppBarBlocState{
  final List<NotificationEntity> notifications;
  AppBarNewNotificationState({required this.notifications});
  @override
  // TODO: implement props
  List<Object?> get props => [notifications];
}
class AppBarNotificationsLoadedState extends AppBarBlocState{
  final List<NotificationEntity> notifications;
  AppBarNotificationsLoadedState({required this.notifications});
  @override
  // TODO: implement props
  List<Object?> get props => [notifications];
}
class AppBarChangedState extends AppBarBlocState{
  final Widget? newAppBar;
  AppBarChangedState({ this.newAppBar});
  @override
  // TODO: implement props
  List<Object?> get props => [newAppBar];
}
class AppBarInitialState extends AppBarBlocState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
