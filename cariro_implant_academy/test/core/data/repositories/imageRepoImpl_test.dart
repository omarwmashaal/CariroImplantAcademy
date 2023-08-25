import 'dart:typed_data';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/data/dataSources/imageDataSource.dart';
import 'package:cariro_implant_academy/core/data/repositories/imageRepoImpl.dart';
import 'package:cariro_implant_academy/core/domain/useCases/uploadImageUseCase.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'imageRepoImpl_test.mocks.dart';

@GenerateMocks([ImageDataSource])
void main() {
  late MockImageDataSource mockDataSource;
  late ImageRepoImpl repo;

  setUp(() {
    mockDataSource = MockImageDataSource();
    repo = ImageRepoImpl(dataSource: mockDataSource);
  });

  final tImageParams = UploadImageParams(id: 0, type: EnumImageType.UserProfile, data: Uint8List.fromList([1, 2]));
  group(
    "Testing upload",
    () {
      test("Should call dataSource upload", () async {
        when(mockDataSource.uploadImage(any)).thenAnswer((realInvocation) async => true);
        await repo.uploadImage(tImageParams);
        verify(mockDataSource.uploadImage(tImageParams));
      });
      test("Should return true if success", () async {
        when(mockDataSource.uploadImage(any)).thenAnswer((realInvocation) async => true);
        final result = await repo.uploadImage(tImageParams);
        expect(result, Right(true));
      });
      test("Should return failure if failed", () async {
        when(mockDataSource.uploadImage(any)).thenThrow(HttpBadRequestException(message: "my message"));
        final result = await repo.uploadImage(tImageParams);
        expect(result, Left(HttpBadRequestFailure(failureMessage: "my message")));
      });
    },
  );
}
