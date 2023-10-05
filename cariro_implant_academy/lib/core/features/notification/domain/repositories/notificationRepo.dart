import 'package:cariro_implant_academy/core/features/notification/data/models/notificationModel.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failure.dart';

abstract class NotificationRepo{
  Future<Either<Failure,List<NotificationModel>>> getNotifications();
  Future<Either<Failure,NoParams>> markAllAsRead();
  Future<Either<Failure,NoParams>> deleteNotification(int id);
}