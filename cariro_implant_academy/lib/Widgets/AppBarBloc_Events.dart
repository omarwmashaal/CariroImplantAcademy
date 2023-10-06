import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AppBarBlocEvents extends Equatable {}

class AppBarChangeAppBarEvent extends AppBarBlocEvents{
  final Widget newAppBar;
  AppBarChangeAppBarEvent({required this.newAppBar});
  @override
  // TODO: implement props
  List<Object?> get props => [newAppBar];

}
class AppBarRemoveAppBarEvent extends AppBarBlocEvents{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class AppBarDeleteNotificationEvent extends AppBarBlocEvents{
  final int id;
  AppBarDeleteNotificationEvent({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
class AppBarGetNotificationsEvent extends AppBarBlocEvents{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class AppBarMarkAllNotificationsAsReadEvent extends AppBarBlocEvents{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}