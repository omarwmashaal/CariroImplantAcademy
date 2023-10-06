import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/constants/remoteConstants.dart';
import 'package:cariro_implant_academy/core/features/notification/data/models/notificationModel.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';

import '../../../../useCases/useCases.dart';

abstract class NotificationDataSource{
  Future<List<NotificationModel>> getNotifications();
  Future<NoParams> markAllAsRead();
  Future<NoParams> deleteNotification(int id);
}


class NotificationDataSourceImpl implements NotificationDataSource{
  final HttpRepo httpRepo;
  NotificationDataSourceImpl({required this.httpRepo});
  @override
  Future<NoParams> deleteNotification(int id) async{
    late StandardHttpResponse response;
    try{
      response = await httpRepo.delete(host: "$serverHost/$notificationController/DeleteNotification");
    }catch(e){
      throw HttpInternalServerErrorException();
    }
    if(response.statusCode!=200)
      throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<List<NotificationModel>> getNotifications() async{
    late StandardHttpResponse response;
    try{
      response = await httpRepo.get(host: "$serverHost/$notificationController/GetNotifications");
    }catch(e){
      throw HttpInternalServerErrorException();
    }
    if(response.statusCode!=200)
      throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    try{
      return (response.body as List<dynamic>).map((e) => NotificationModel.fromJson(e as Map<String,dynamic>)).toList();
    }
    catch(e)
    {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> markAllAsRead() async{
    late StandardHttpResponse response;
    try{
      response = await httpRepo.post(host: "$serverHost/$notificationController/MarkAllAsRead");
    }catch(e){
      throw HttpInternalServerErrorException();
    }
    if(response.statusCode!=200)
      throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    return NoParams();
  }

}