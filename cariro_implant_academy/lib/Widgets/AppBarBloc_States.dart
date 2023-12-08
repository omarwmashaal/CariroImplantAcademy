import 'package:cariro_implant_academy/core/features/notification/domain/entities/notificationEntity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../Models/NotificationModel.dart';

abstract class AppBarBlocState {}

class AppBarNewNotificationState extends AppBarBlocState {
  final List<NotificationEntity> notifications;

  AppBarNewNotificationState({required this.notifications});
}

class AppBarNotificationsLoadedState extends AppBarBlocState {
  final List<NotificationEntity> notifications;

  AppBarNotificationsLoadedState({required this.notifications});
}

class AppBarChangedState extends AppBarBlocState {
  final Widget? newAppBar;

  AppBarChangedState({this.newAppBar});
}

class AppBarLoadingNotificationsState extends AppBarBlocState {}

class AppBarLoadingNotificationsErrorState extends AppBarBlocState {
  final String message;

  AppBarLoadingNotificationsErrorState({required this.message});
}

class AppBarInitialState extends AppBarBlocState {}

class AppBarMarkedNotificationsAsReadState extends AppBarBlocState {}

class AppBarMarkedNotificationsAsReadErrorState extends AppBarBlocState {
  final String message;

  AppBarMarkedNotificationsAsReadErrorState({required this.message});
}

class AppBarDeletingNotificationsState extends AppBarBlocState {}

class AppBarDeletingNotificationsErrorState extends AppBarBlocState {
  final String message;

  AppBarDeletingNotificationsErrorState({required this.message});
}

class AppBarDeletedNotificationsSuccessfullyState extends AppBarBlocState {}

class DrawerSetIndex extends AppBarBlocState {
  final int index;

  DrawerSetIndex({required this.index});
}
