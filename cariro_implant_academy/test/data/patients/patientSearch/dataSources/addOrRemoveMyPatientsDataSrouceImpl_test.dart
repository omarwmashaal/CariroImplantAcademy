import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/constants/remoteConstants.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/data/patients/dataSrouces/addOrRemoveMyPatientsDataSource.dart';
import 'package:cariro_implant_academy/domain/patients/usecases/addRangeToMyPatientsUseCase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../core/checkLoginStatus_test.mocks.dart';

void main() {
  late MockHttpRepo client;
  late AddOrRemoveMyPatientsDataSourceImpl dataSourceImpl;

  setUp(() {
    client = MockHttpRepo();
    dataSourceImpl = AddOrRemoveMyPatientsDataSourceImpl(client);
  });

  setUpSuccess() {
    when(client.post(host: anyNamed("host"))).thenAnswer((realInvocation) async => StandardHttpResponse(body: "true", statusCode: 200));
  }

  setUpFailed() {
    when(client.post(host: anyNamed("host"))).thenAnswer((realInvocation) async => StandardHttpResponse(body: "true", statusCode: 400));
  }

  setUpException() {
    when(client.post(host: anyNamed("host"))).thenThrow(Exception());
  }

  group("Testing Add Range", () {
    test(
      "Should call post with client",
      () async {
        setUpSuccess();
        await dataSourceImpl.addToMyPatientsRange(AddRangePatientsParams(from: 100, to: 200));
        verify(client.post(host: "$serverHost/$patientInfoController/AddRangeToMyPatients?from=100&to=200"));
      },
    );
    test(
      "Should throw Server Exception if status 400",
      () async {
        setUpFailed();
        final call = dataSourceImpl.addToMyPatientsRange;
        expect(() => call(AddRangePatientsParams(from: 100, to: 200)), throwsA(TypeMatcher<HttpInternalServerErrorException>()));
      },
    );
    test(
      "Should throw Server Exception if any exception in client",
      () async {
        setUpException();
        final call = dataSourceImpl.addToMyPatientsRange;
        expect(() => call(AddRangePatientsParams(from: 100, to: 200)), throwsA(TypeMatcher<HttpInternalServerErrorException>()));
      },
    );
  });
  group("Testing Add Single", () {
    test(
      "Should call post with client",
      () async {
        setUpSuccess();
        await dataSourceImpl.addToMyPatients(3);
        verify(client.post(host: "$serverHost/$patientInfoController/AddToMyPatients?id=3"));
      },
    );
    test(
      "Should throw Server Exception if status 400",
      () async {
        setUpFailed();
        final call = dataSourceImpl.addToMyPatients;
        expect(() => call(5), throwsA(TypeMatcher<HttpInternalServerErrorException>()));
      },
    );
    test(
      "Should throw Server Exception if any exception in client",
      () async {
        setUpException();
        final call = dataSourceImpl.addToMyPatients;
        expect(() => call(7), throwsA(TypeMatcher<HttpInternalServerErrorException>()));
      },
    );
  });
}
