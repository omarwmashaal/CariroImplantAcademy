import 'dart:convert';
import 'dart:typed_data';

import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/constants/remoteConstants.dart';
import 'package:cariro_implant_academy/core/data/dataSources/imageDataSource.dart';
import 'package:cariro_implant_academy/core/domain/useCases/uploadImageUseCase.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../data/authentication/dataSources/authASPDataSourceImpl_test.mocks.dart';
import '../../../fixtures/fixture.dart';

void main() {
  late MockHttpRepo mockHttpRepo;
  late ImageDataSourceImpl dataSource;

  setUp(() {
    mockHttpRepo = MockHttpRepo();
    dataSource = ImageDataSourceImpl(httpRepo: mockHttpRepo);
  });

  final tImageParams = UploadImageParams(id: 0, type: EnumImageType.UserProfile, data: Uint8List.fromList([1, 2]));
  final tImageDate = json.decode(fixture("imageDataBase64.json"))['result'];
  final tImageUintList = Uint8List.fromList(base64Decode(tImageDate));
  group(
    "Testing upload dataSource",
    () {
      test(
        "Should call httpRepo upload",
        () async {
          when(mockHttpRepo.uploadImage(imageBytes: anyNamed("imageBytes"), url: anyNamed("url")))
              .thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 200));
          await dataSource.uploadImage(tImageParams);
          verify(
            mockHttpRepo.uploadImage(
              url: "$serverHost/$patientInfoController/UploadImage?type=${tImageParams.type.index}&id=${tImageParams.id}",
              imageBytes: tImageParams.data,
            ),
          );
        },
      );
      test("Should return true if success", () async {
        when(mockHttpRepo.uploadImage(imageBytes: anyNamed("imageBytes"), url: anyNamed("url")))
            .thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 200));
        final result =await dataSource.uploadImage(tImageParams);
        expect(result, true);

      });
      test("Should throw Exception failed", () async {
        when(mockHttpRepo.uploadImage(imageBytes: anyNamed("imageBytes"), url: anyNamed("url")))
            .thenThrow(Exception());
        final call = dataSource.uploadImage;
        expect(()=>call(tImageParams), throwsA(TypeMatcher<HttpInternalServerErrorException>()));

      });

      test("Should throw httpbadrequest if 400 ", () async {
        when(mockHttpRepo.uploadImage(imageBytes: anyNamed("imageBytes"), url: anyNamed("url")))
            .thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 400));
        final call = dataSource.uploadImage;
        expect(()=>call(tImageParams), throwsA(TypeMatcher<HttpBadRequestException>()));

      });
    },
  );
  group(
    "Testing Download dataSource",
    () {
      test(
        "Should call httpRepo get",
        () async {
          when(mockHttpRepo.get(host: anyNamed("host")))
              .thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 200,body: tImageDate));
          await dataSource.downloadImage(1);
          verify(
            mockHttpRepo.get(
              host: "$serverHost/$patientInfoController/DownloadImage?id=1",
            ),
          );
        },
      );
      test("Should return uintlist if success", () async {
        when(mockHttpRepo.get(host: anyNamed("host")))
            .thenAnswer((realInvocation) async => StandardHttpResponse(statusCode: 200,body: tImageDate));
        final result =await dataSource.downloadImage(1);
        expect(result, tImageUintList);

      });
    },
  );
}
