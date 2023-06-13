// Import the library.
import 'package:cariro_implant_academy/API/NotificationsAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:logging/logging.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../API/HTTP.dart';
import '../Constants/Connection.dart';
import '../Constants/Controllers.dart';

class SignalR {
  static late HubConnection hubConnection;
// Creates the connection by using the HubConnectionBuilder.

// When the connection is closed, print out a message to the console.

  static runConfig() async {
// Configer the logging
   // Logger.root.level = Level.ALL;
// Writes the log messages to the console
   Logger.root.onRecord.listen((LogRecord rec) {
   //
    });

// If you want only to log out the message for the higer level hub protocol:
    final hubProtLogger = Logger("SignalR - hub");
// If youn want to also to log out transport messages:
    final transportProtLogger = Logger("SignalR - transport");
    final connectionOptions = HttpConnectionOptions;
    final httpOptions = HttpConnectionOptions(
      logger: transportProtLogger
    );
     hubConnection = HubConnectionBuilder()
        .withUrl(signalRHost, options: httpOptions).
    configureLogging(hubProtLogger).build();
    hubConnection.onclose(
      ({error}) {

      },
    );
    hubConnection.on("NewNotification", (arguments) async{
      siteController.newNotification.value = true;
      await NotificationsAPI.GetNotifications();
    });

   
    try {
      await hubConnection.start();
    } on Exception catch (e) {
      // TODO
    }



  }

  static AssignConnection()async{
    if(hubConnection.state==HubConnectionState.Connected)
    {
      var t = siteController.getUser().idInt;
      try {
        hubConnection.invoke("AssignConnection", args: [t as int]);
      } on Exception catch (e) {
        // TODO
      }
    }
  }



}
