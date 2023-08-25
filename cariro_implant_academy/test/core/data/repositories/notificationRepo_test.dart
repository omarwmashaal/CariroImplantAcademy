import 'dart:convert';

import 'package:cariro_implant_academy/core/data/dataSources/notificationDataSource.dart';
import 'package:cariro_implant_academy/core/data/models/notificationModel.dart';
import 'package:cariro_implant_academy/core/data/repositories/notificationRepoImpl.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture.dart';
import 'notificationRepo_test.mocks.dart';

@GenerateMocks([NotificationDataSource])
void main() {
  late MockNotificationDataSource mockDataSrouce;
  late NotificationRepoImpl repo;
  setUp(() {
    mockDataSrouce = MockNotificationDataSource();
    repo = NotificationRepoImpl(notificationDataSource: mockDataSrouce);
  });

  final tNotificationsResponse = <NotificationModel>[
    NotificationModel.fromJson(json.decode(fixture("core/notificationsReadType1Response.json"))),
    NotificationModel.fromJson(json.decode(fixture("core/notificationsUnreadType0Response.json"))),
  ];
  group(
    "Testing get notifications",
    () {
      test(
        "Should call get notification from datasource",
        () async {
          when(mockDataSrouce.getNotifications()).thenAnswer((realInvocation) async => tNotificationsResponse);
          await repo.getNotifications();
          verify(mockDataSrouce.getNotifications());
        },
      );
      test(
        "Should return right correct response if success",
        () async {
          when(mockDataSrouce.getNotifications()).thenAnswer((realInvocation) async => tNotificationsResponse);
          final result = await repo.getNotifications();
          expect(result, Right(tNotificationsResponse));
        },
      );
      test(
        "Should return Left failure on Exception",
        () async {
          when(mockDataSrouce.getNotifications()).thenThrow(DataConversionException(message: ""));
          final result = await repo.getNotifications();
          expect(result, Left(DataConversionFailure(failureMessage: "")));
        },
      );
    },
  );
}
