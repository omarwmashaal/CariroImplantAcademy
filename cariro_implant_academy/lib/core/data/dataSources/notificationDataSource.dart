import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/constants/remoteConstants.dart';
import 'package:cariro_implant_academy/core/data/models/notificationModel.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';

import '../../useCases/useCases.dart';

abstract class NotificationDataSource{
  Future<List<NotificationModel>> getNotifications();
  Future<NoParams> markAllAsRead();
  Future<NoParams> deleteNotification(int id);
}


class NotificationDataSourceImpl implements NotificationDataSource{
  final HttpRepo httpRepo;
  NotificationDataSourceImpl({required this.httpRepo});
  @override
  Future<NoParams> deleteNotification(int id) {
    // TODO: implement deleteNotification
    throw UnimplementedError();
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
      throw getHttpException(statusCode: response.statusCode);
    try{
      return (response.body as List<dynamic>).map((e) => NotificationModel.fromJson(e as Map<String,dynamic>)).toList();
    }
    catch(e)
    {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> markAllAsRead() {
    // TODO: implement markAllAsRead
    throw UnimplementedError();
  }

}