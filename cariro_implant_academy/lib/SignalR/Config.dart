// Import the library.
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cariro_implant_academy/API/NotificationsAPI.dart';
import 'package:f_logs/model/flog/flog.dart';
import 'package:f_logs/model/flog/flog_config.dart';
import 'package:f_logs/utils/formatter/field_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signalr_netcore/ihub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:logging/logging.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../API/HTTP.dart';
import '../Constants/Connection.dart';
import '../Constants/Controllers.dart';

class SignalR {
  static HubConnection? hubConnection;

// Creates the connection by using the HubConnectionBuilder.

// When the connection is closed, print out a message to the console.

  static runConfig() async {

    // Configer the logging
    Logger.root.level = Level.ALL;
    // Writes the log messages to the console
    Logger.root.onRecord.listen(
      (LogRecord rec) {
        //print('${rec.level.name}: ${rec.time}: ${rec.message}');
      //  siteController.logs.add('${rec.level.name}: ${rec.time}: ${rec.message}');
      },
    );


// If you want only to log out the message for the higer level hub protocol:
    final hubProtLogger = Logger("SignalR - hub");
// If youn want to also to log out transport messages:
    final transportProtLogger = Logger("SignalR - transport");
    final connectionOptions = HttpConnectionOptions;
    var headers = MessageHeaders();

    headers.setHeaderValue("access_token", "${await siteController.getToken()}");

    hubConnection = HubConnectionBuilder()
        .withUrl(
          signalRHost,
          options: HttpConnectionOptions(
            logger: transportProtLogger,
            //   headers: headers,
            accessTokenFactory: () async => await siteController.getToken(),
          ),
        )
        .configureLogging(hubProtLogger)
        .build();
    hubConnection!.onclose(
      ({error}) {},
    );

    hubConnection!.on("NewNotification", (arguments) async {
      siteController.newNotification.value = true;
      await NotificationsAPI.GetNotifications();
    });

    try {
      await hubConnection!.start();
    } on Exception catch (e) {
      // TODO
    }
  }

  static bool checkConnection() {
    return hubConnection != null && hubConnection!.state == HubConnectionState.Connected;
  }
}
