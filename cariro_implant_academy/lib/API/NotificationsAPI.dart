import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Models/CashFlow.dart';
import 'package:cariro_implant_academy/Models/NotificationModel.dart';

import '../Models/API_Response.dart';
import 'HTTP.dart';

class NotificationsAPI{
  static Future<API_Response> GetNotifications() async {
    var response = await HTTPRequest.Get("Notifications/GetNotifications");
    if(response.statusCode==200)
      {
        response.result = (response.result as List<dynamic>).map((e) => NotificationModel.fromJson(e??Map<String,dynamic>())).toList();
       // siteController.notifications.value = response.result as List<NotificationModel>;
      }
    return response;
  }
  static Future<API_Response> MarkAllAsRead() async {
    var response = await HTTPRequest.Post("Notifications/MarkAllAsRead", null);

    return response;
  }
  static Future<API_Response> DeleteNotification(int id) async {
    var response = await HTTPRequest.Delete("Notifications/DeleteNotification?id=$id");

    return response;
  }
}