import 'package:cariro_implant_academy/core/features/notification/data/datasource/notificationDataSource.dart';
import 'package:cariro_implant_academy/core/features/notification/data/models/notificationModel.dart';
import 'package:cariro_implant_academy/core/features/notification/domain/repositories/notificationRepo.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class NotificationRepoImpl implements NotificationRepo{
  final NotificationDataSource notificationDataSource;
  NotificationRepoImpl({required this.notificationDataSource});
  @override
  Future<Either<Failure, NoParams>> deleteNotification(int id) async {
    try{
      final result = await notificationDataSource.deleteNotification(id);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications()async {
    try{
      final result = await notificationDataSource.getNotifications();
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> markAllAsRead() async {
    try{
      final result = await notificationDataSource.markAllAsRead();
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

}