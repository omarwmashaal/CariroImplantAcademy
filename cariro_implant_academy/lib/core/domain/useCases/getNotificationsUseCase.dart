import 'package:cariro_implant_academy/core/domain/entities/notificationEntity.dart';
import 'package:cariro_implant_academy/core/domain/repositories/notificationRepo.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class GetNotificationsUseCase extends UseCases<List<NotificationEntity>,NoParams>
{

  final NotificationRepo notificationRepo;
  GetNotificationsUseCase({required this.notificationRepo});
  @override
  Future<Either<Failure, List<NotificationEntity>>> call(NoParams params) async{
    return await notificationRepo.getNotifications();
  }

}