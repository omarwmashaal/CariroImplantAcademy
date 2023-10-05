import 'dart:convert';
import 'dart:math';

import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/features/notification/data/datasource/notificationDataSource.dart';
import 'package:cariro_implant_academy/core/features/notification/data/models/notificationModel.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../data/authentication/dataSources/authASPDataSourceImpl_test.mocks.dart';
import '../../../fixtures/fixture.dart';

void main() {
  late MockHttpRepo mockHttpRepo;
  late NotificationDataSourceImpl dataSourceImpl;

  setUp(
    () {
      mockHttpRepo = MockHttpRepo();
      dataSourceImpl = NotificationDataSourceImpl(httpRepo: mockHttpRepo);
    },
  );
  final tResponseList = json.decode(fixture("core/notificationsListResponse.json"));
  final tResponseModel = [
    NotificationModel.fromJson(json.decode(fixture("core/notificationsUnreadType0Response.json"))),
    NotificationModel.fromJson(json.decode(fixture("core/notificationsReadType1Response.json"))),
  ];
  group(
    "Testing get notifications",
    () {
      test("Should call clientget", () async {
        when(mockHttpRepo.get(host: anyNamed("host"))).thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 200, body: tResponseList));
        await dataSourceImpl.getNotifications();
        verify(mockHttpRepo.get(host: anyNamed("host")));
      });

      test("Should return correct response if success", () async {
        when(mockHttpRepo.get(host: anyNamed("host"))).thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 200, body: tResponseList));
        final result = await dataSourceImpl.getNotifications();
        expect(result, tResponseModel);
      });
      test("Should throw correct http exception on != 200 status code", () async {
        when(mockHttpRepo.get(host: anyNamed("host"))).thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 400, body: tResponseList));
        final call =  dataSourceImpl.getNotifications;
        expect(()=>call(), throwsA(TypeMatcher<HttpBadRequestException>()));
      });
      test("Should throw data conversion exception on bad response", () async {
        when(mockHttpRepo.get(host: anyNamed("host"))).thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 200, body: "sadasdsa"));
        final call =  dataSourceImpl.getNotifications;
        expect(()=>call(), throwsA(TypeMatcher<DataConversionException>()));
      });
      test("Should throw intenal server error on error", () async {
        when(mockHttpRepo.get(host: anyNamed("host"))).thenThrow(Exception());
        final call =  dataSourceImpl.getNotifications;
        expect(()=>call(), throwsA(TypeMatcher<HttpInternalServerErrorException>()));
      });
    },
  );
}
