// Import the library.
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cariro_implant_academy/API/NotificationsAPI.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc_Events.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/ihub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:logging/logging.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../API/HTTP.dart';
import '../Constants/Connection.dart';
import '../Constants/Controllers.dart';
import '../Controllers/SiteController.dart';
import '../Widgets/AppBarBloc.dart';
import '../core/injection_contianer.dart';

class SignalR {
  HubConnection? _hubConnection;
  final AppBarBloc bloc;

  SignalR({required this.bloc}) {
    _runConfig();
  }

// Creates the connection by using the HubConnectionBuilder.

// When the connection is closed, print out a message to the console.

  _runConfig() async {
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

    if (!checkConnection())
      _hubConnection = HubConnectionBuilder()
          .withUrl(
            signalRHost,
            options: HttpConnectionOptions(
              logger: transportProtLogger,
              //   headers: headers,
              accessTokenFactory: () async => siteController.getToken() ?? "",
            ),
          )
          .configureLogging(hubProtLogger)
          .build();
    _hubConnection!.onclose(
      ({error}) {},
    );
    _hubConnection!.onreconnected(({connectionId}) {
      print("asdfklhsdfl;jsahlksadjfhaskldfhasdk");
    });

    _hubConnection!.on("NewNotification", (arguments) {

      bloc.add(AppBarGetNotificationsEvent());
      // await NotificationsAPI.GetNotifications();
    });

    try {
      await _hubConnection!.start();
      bloc.add(AppBarGetNotificationsEvent());
    } on Exception catch (e) {
      // TODO
    }
  }

  bool checkConnection() {
    return _hubConnection != null && _hubConnection!.state == HubConnectionState.Connected;
  }
}
