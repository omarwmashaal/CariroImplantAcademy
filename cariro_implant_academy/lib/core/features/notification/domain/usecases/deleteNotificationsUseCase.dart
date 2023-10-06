import 'package:cariro_implant_academy/core/features/notification/domain/entities/notificationEntity.dart';
import 'package:cariro_implant_academy/core/features/notification/domain/repositories/notificationRepo.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class DeleteNotificationsUseCase extends UseCases<NoParams,int>
{

  final NotificationRepo notificationRepo;
  DeleteNotificationsUseCase({required this.notificationRepo});
  @override
  Future<Either<Failure, NoParams>> call(int id) async{
    return await notificationRepo.deleteNotification(id);
  }

}