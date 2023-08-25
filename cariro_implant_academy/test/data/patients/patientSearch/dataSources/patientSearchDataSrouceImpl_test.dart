import 'dart:convert';
import 'dart:math';

import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/constants/remoteConstants.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/data/patients/dataSrouces/patientSearchDataSource.dart';
import 'package:cariro_implant_academy/data/patients/models/patientSearchResponseModel.dart';
import 'package:cariro_implant_academy/domain/patients/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/domain/patients/usecases/patientSearchUseCase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import '../../../authentication/dataSources/authASPDataSourceImpl_test.mocks.dart';

@GenerateMocks([HttpRepo])
void main() {
  late MockHttpRepo mockClient;
  late PatientSearchDataSourceImpl dataSource;

  final tResponseListString = fixture("patients/patientSearch/patientSearchListResponse.json");
  final tResponseSingleString = fixture("patients/patientSearch/patientSearchMaleSingleResponse.json");
  final tResponseList = (json.decode(tResponseListString) as List<dynamic>).map((e) => PatientInfoModel.fromMap(e as Map<String, dynamic>)).toList();
  final tResponseSingle = PatientInfoModel.fromMap(json.decode(tResponseSingleString));
  setUp(
    () {
      mockClient = MockHttpRepo();
      dataSource = PatientSearchDataSourceImpl(client: mockClient);
    },
  );
  setUpSuccess(String response) {
    when(mockClient.get(host: anyNamed("host"))).thenAnswer(
      (realInvocation) async => StandardHttpResponse(
        body: json.decode(response),
        statusCode: 200,
      ),
    );
  }

  setUpFailed() {
    when(mockClient.get(host: anyNamed("host"))).thenAnswer(
      (realInvocation) async => StandardHttpResponse(body: "", statusCode: 400, errorMessage: "error message"),
    );
  }

  setUpServerException() {
    when(mockClient.get(host: anyNamed("host"))).thenThrow(Exception());
  }

  setUpWrongResponseFormatwith200() {
    when(mockClient.get(host: anyNamed("host"))).thenAnswer(
      (realInvocation) async => StandardHttpResponse(
        body: "Server Error",
        statusCode: 200,
        errorMessage: "error message",
      ),
    );
  }

  setUpWrongResponseFormatwith400() {
    when(mockClient.get(host: anyNamed("host"))).thenAnswer(
      (realInvocation) async => StandardHttpResponse(
        body: "Server Error",
        statusCode: 400,
        errorMessage: "error message",
      ),
    );
  }

  setUpWrongResponseNotList() {
    when(mockClient.get(host: anyNamed("host"))).thenAnswer(
      (realInvocation) async => StandardHttpResponse(
        body: json.encode({"myname ahmed": "you name is wrong"}),
        statusCode: 200,
        errorMessage: "error message",
      ),
    );
  }

  setUpWrongResponseAlistButWrongValues() {
    when(mockClient.get(host: anyNamed("host"))).thenAnswer(
      (realInvocation) async => StandardHttpResponse(
        body: json.encode([
          {"myname ahmed": "you name is wrong"}
        ]),
        statusCode: 200,
        errorMessage: "error message",
      ),
    );
  }

  setUpWrongResponseAlistButNullRequiredValues() {
    when(mockClient.get(host: anyNamed("host"))).thenAnswer(
      (realInvocation) async => StandardHttpResponse(
        body: json.encode([
          {"name": "Omar", "doctor": "doctor", "id": 0}
        ]),
        statusCode: 200,
        errorMessage: "error message",
      ),
    );
  }

  setUpWrongResponseAlistButHaveIncorrectDataType() {
    when(mockClient.get(host: anyNamed("host"))).thenAnswer(
      (realInvocation) async => StandardHttpResponse(
        body: json.encode([
          {
            "id": "1",
            "name": "Maher Khattab",
            "phone": "01297587030",
            "maritalStatus": "Single",
            "gender": 0,
            "relativePatient": "Omar",
            "doctorId": 101,
            "dateOfBirth": "1998-0415",
            "doctor": "doctor name"
          }
        ]),
        statusCode: 200,
        errorMessage: "error message",
      ),
    );
  }

  final tQueryName = PatientSearchParams(myPatients: false, query: "om");

  String setUpBodyNamed(String query) {
    return "$serverHost/$patientInfoController/ListPatients?filter=Name&search=$query";
  }

  group("Testing Search By Name", () {
    test(
      "Should call client get",
      () async {
        setUpSuccess(tResponseListString);
        await dataSource.searchPatients(tQueryName);
        verify(mockClient.get(host: anyNamed("host")));
      },
    );
    test(
      "Should return correct format",
      () async {
        setUpSuccess(tResponseListString);
        final result = await dataSource.searchPatients(tQueryName);
        expect(result, tResponseList);
      },
    );
    test(
      "Should return throw server exception if exception ",
      () async {
        setUpServerException();
        final call = dataSource.searchPatients;
        expect(() => call(tQueryName), throwsA(TypeMatcher<HttpInternalServerErrorException>()));
      },
    );
    test(
      "Should return throw server exception if 400 ",
      () async {
        setUpFailed();
        final call = dataSource.searchPatients;
        expect(() => call(tQueryName), throwsA(TypeMatcher<HttpBadRequestException>()));
      },
    );
    test(
      "Should return throw DataConversionException exception if  incorrect data type ",
      () async {
        setUpWrongResponseAlistButHaveIncorrectDataType();
        final call = dataSource.searchPatients;
        expect(() => call(tQueryName), throwsA(TypeMatcher<DataConversionException>()));
      },
    );
    test(
      "Should return throw DataConversionException exception if null required values ",
      () async {
        setUpWrongResponseAlistButNullRequiredValues();
        final call = dataSource.searchPatients;
        expect(() => call(tQueryName), throwsA(TypeMatcher<DataConversionException>()));
      },
    );
    test(
      "Should return throw DataConversionException exception if wrong response ",
      () async {
        setUpWrongResponseAlistButWrongValues();
        final call = dataSource.searchPatients;
        expect(() => call(tQueryName), throwsA(TypeMatcher<DataConversionException>()));
      },
    );
    test(
      "Should return throw DataConversionException exception if wrong format not a map 200 ",
      () async {
        setUpWrongResponseFormatwith200();
        final call = dataSource.searchPatients;
        expect(() => call(tQueryName), throwsA(TypeMatcher<DataConversionException>()));
      },
    );
    test(
      "Should return throw badrequestif wrong format not a map 400",
      () async {
        setUpWrongResponseFormatwith400();
        final call = dataSource.searchPatients;
        expect(() => call(tQueryName), throwsA(TypeMatcher<HttpBadRequestException>()));
      },
    );
    test(
      "Should return throw server exception if not a list",
      () async {
        setUpWrongResponseNotList();
        final call = dataSource.searchPatients;
        expect(() => call(tQueryName), throwsA(TypeMatcher<DataConversionException>()));
      },
    );
    test(
      "Should return throw server exception if not a list",
      () async {
        setUpWrongResponseNotList();
        final call = dataSource.searchPatients;
        expect(() => call(tQueryName), throwsA(TypeMatcher<DataConversionException>()));
      },
    );
  });
  group("Testing Get Patient", () {
    test(
      "Should call client get",
      () async {
        setUpSuccess(tResponseSingleString);
        await dataSource.getPatient(4);
        verify(mockClient.get(host: anyNamed("host")));
      },
    );
    test(
      "Should return correct format",
      () async {
        setUpSuccess(tResponseSingleString);
        final result = await dataSource.getPatient(4);
        expect(result, tResponseSingle);
      },
    );
    test(
      "Should return throw server exception if exception ",
      () async {
        setUpServerException();
        final call = dataSource.getPatient;
        expect(() => call(5), throwsA(TypeMatcher<HttpInternalServerErrorException>()));
      },
    );
    test(
      "Should return throw server exception if 400 ",
      () async {
        setUpFailed();
        final call = dataSource.getPatient;
        expect(() => call(5), throwsA(TypeMatcher<HttpBadRequestException>()));
      },
    );
    test(
      "Should return throw DataConversionException exception if  incorrect data type ",
      () async {
        setUpWrongResponseAlistButHaveIncorrectDataType();
        final call = dataSource.getPatient;
        expect(() => call(5), throwsA(TypeMatcher<DataConversionException>()));
      },
    );
    test(
      "Should return throw DataConversionException exception if null required values ",
      () async {
        setUpWrongResponseAlistButNullRequiredValues();
        final call = dataSource.getPatient;
        expect(() => call(5), throwsA(TypeMatcher<DataConversionException>()));
      },
    );
    test(
      "Should return throw DataConversionException exception if wrong response ",
      () async {
        setUpWrongResponseAlistButWrongValues();
        final call = dataSource.getPatient;
        expect(() => call(6), throwsA(TypeMatcher<DataConversionException>()));
      },
    );
    test(
      "Should return throw DataConversionException exception if wrong format not a map 200 ",
      () async {
        setUpWrongResponseFormatwith200();
        final call = dataSource.getPatient;
        expect(() => call(8), throwsA(TypeMatcher<DataConversionException>()));
      },
    );
  });

  group(
    "Testing Get Next Available ID",
    () {
      test("Should call get", () async {
        when(mockClient.get(host: "$serverHost/$patientInfoController/GetNextAvailableId"))
            .thenAnswer((realInvocation) async => StandardHttpResponse(body: "2", statusCode: 200));
        await dataSource.getNextAvailableId();
        verify(mockClient.get(host: "$serverHost/$patientInfoController/GetNextAvailableId"));
      });
      test("Should return correct format if success", () async {
        when(mockClient.get(host: "$serverHost/$patientInfoController/GetNextAvailableId"))
            .thenAnswer((realInvocation) async => StandardHttpResponse(body: "2", statusCode: 200));
        final result = await dataSource.getNextAvailableId();
        expect(result, 2);
      });
      ;
      test("Should bad request exception if 400", () async {
        when(mockClient.get(host: "$serverHost/$patientInfoController/GetNextAvailableId"))
            .thenAnswer((realInvocation) async => StandardHttpResponse(body: "2", statusCode: 400));
        final call = dataSource.getNextAvailableId;
        expect(() => call(), throwsA(TypeMatcher<HttpBadRequestException>()));
      });
      test("Should Server Exception of failed", () async {
        when(mockClient.get(host: "$serverHost/$patientInfoController/GetNextAvailableId")).thenThrow(Exception());
        final call = dataSource.getNextAvailableId;
        expect(() => call(), throwsA(TypeMatcher<HttpInternalServerErrorException>()));
      });
      test("Should DataConversion Exception if wrong data", () async {
        when(mockClient.get(host: "$serverHost/$patientInfoController/GetNextAvailableId"))
            .thenAnswer((realInvocation) async => StandardHttpResponse(body: "body", statusCode: 200));
        final call = dataSource.getNextAvailableId;
        expect(() => call(), throwsA(TypeMatcher<DataConversionException>()));
      });
    },
  );
  group(
    "Testing CHECK Duplicate ID",
    () {
      int id = 5;
      test("Should call get", () async {
        when(mockClient.get(host: "$serverHost/$patientInfoController/CheckDuplicateId?id=$id"))
            .thenAnswer((realInvocation) async => StandardHttpResponse(body: "{}", statusCode: 200));
        await dataSource.checkDuplicateId(id);
        verify(mockClient.get(host: "$serverHost/$patientInfoController/CheckDuplicateId?id=$id"));
      });
      test("Should return correct true if body not null", () async {
        when(mockClient.get(host: "$serverHost/$patientInfoController/CheckDuplicateId?id=$id"))
            .thenAnswer((realInvocation) async => StandardHttpResponse(body: "2", statusCode: 200));
        final result = await dataSource.checkDuplicateId(id);
        expect(result, true);
      });
      test("Should return correct false if body null", () async {
        when(mockClient.get(host: "$serverHost/$patientInfoController/CheckDuplicateId?id=$id"))
            .thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 200));
        final result = await dataSource.checkDuplicateId(id);
        expect(result, false);
      });
      ;
      test("Should bad request exception if 400", () async {
        when(mockClient.get(host: "$serverHost/$patientInfoController/CheckDuplicateId?id=$id"))
            .thenAnswer((realInvocation) async => StandardHttpResponse(body: "2", statusCode: 400));
        final call = dataSource.checkDuplicateId;
        expect(() => call(id), throwsA(TypeMatcher<HttpBadRequestException>()));
      });
      test("Should Server Exception of failed", () async {
        when(mockClient.get(host: "$serverHost/$patientInfoController/CheckDuplicateId?id=$id")).thenThrow(Exception());
        final call = dataSource.checkDuplicateId;
        expect(() => call(id), throwsA(TypeMatcher<HttpInternalServerErrorException>()));
      });
    },
  );

  group(
    "Testing create patient",
    () {
      int id = 5;
      test("Should call post with correct toMap", () async {
        when(mockClient.post(host: anyNamed("host"), body: anyNamed("body"))).thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 200,body:(tResponseSingle.toMap()) ));
        await dataSource.createPatient(tResponseSingle);
        verify(mockClient.post(host: anyNamed("host"), body: tResponseSingle.toMap()));
      });
      test("Should return correct true if success", () async {
        when(mockClient.post(host: anyNamed("host"), body: anyNamed("body"))).thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 200,body:json.decode(tResponseSingleString)));
        final result = await dataSource.createPatient(tResponseSingle);
        expect(result, tResponseSingle);
      });
      test("Should throw bad request if failed or 400", () async {
        when(mockClient.post(host: anyNamed("host"), body: anyNamed("body"))).thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 400));
        final result = dataSource.createPatient;
        expect(() => result(tResponseSingle), throwsA(TypeMatcher<HttpBadRequestException>()));
      });

      test("Should throw serverexception if failed or 400", () async {
        when(mockClient.post(host: anyNamed("host"), body: anyNamed("body"))).thenThrow(HttpInternalServerErrorException());
        final result = dataSource.createPatient;
        expect(() => result(tResponseSingle), throwsA(TypeMatcher<HttpInternalServerErrorException>()));
      });
    },
  );
  group(
    "Testing check duplicate Number",
    () {
      test("Should call post with correct input", () async {
        when(mockClient.post(host: anyNamed("host"))).thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 200,body: "aom"));
        await dataSource.checkDuplicateNumber("123");
        verify(mockClient.post(host: "$serverHost/$patientInfoController/CompareDuplicateNumber?number=123"));
      });
      test("Should return String if found duplciate and success", () async {
        when(mockClient.post(host: anyNamed("host"))).thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 200, body: "Omar"));
        final result = await dataSource.checkDuplicateNumber("123");
        expect(result, "Omar");
      });
      test("Should throw exception if not success", () async {
        when(mockClient.post(host: anyNamed("host"))).thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 400, body: "Omar"));
        final call = dataSource.checkDuplicateNumber;
        expect(() => call("123"), throwsA(TypeMatcher<HttpInternalServerErrorException>()));
      });
      test("Should throw exception exception", () async {
        when(mockClient.post(host: anyNamed("host"))).thenThrow(Exception());
        final call = dataSource.checkDuplicateNumber;
        expect(() => call("123"), throwsA(TypeMatcher<HttpInternalServerErrorException>()));
      });
    },
  );
}
