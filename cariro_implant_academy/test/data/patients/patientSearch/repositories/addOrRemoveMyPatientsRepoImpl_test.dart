import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/features/patient/data/datasources/addOrRemoveMyPatientsDataSource.dart';
import 'package:cariro_implant_academy/features/patient/data/repositories/addOrRemoveMyPatientsRepoImpl.dart';
import 'package:cariro_implant_academy/features/patient/domain/usecases/addRangeToMyPatientsUseCase.dart';import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'addOrRemoveMyPatientsRepoImpl_test.mocks.dart';


@GenerateMocks([AddOrRemoveMyPatientsDataSource])
void main() {
  late MockAddOrRemoveMyPatientsDataSource mockDataSource;
  late AddOrRemoveMyPatientsRepoImpl repoImpl;
  setUp(() {
    mockDataSource = MockAddOrRemoveMyPatientsDataSource();
    repoImpl = AddOrRemoveMyPatientsRepoImpl(mockDataSource);
  });

  final tParams = AddRangePatientsParams(from: 100, to: 200);

  group("Testing Adding Range", () {
    test(
      "Should call dataSource",
          () async{
        when(mockDataSource.addToMyPatientsRange(tParams)).thenAnswer((realInvocation) async  => true);
        await repoImpl.addToMyPatientsRange(tParams);
        verify(mockDataSource.addToMyPatientsRange(tParams));
      },
    );
    test(
      "Should call return right true if success",
          () async{
        when(mockDataSource.addToMyPatientsRange(tParams)).thenAnswer((realInvocation) async  => true);
        final result = await repoImpl.addToMyPatientsRange(tParams);
        expect(result, Right(true));
      },
    );
    test(
      "Should call return Left ServerFailure if ServerException",
          () async{
        when(mockDataSource.addToMyPatientsRange(tParams)).thenThrow(HttpInternalServerErrorException());
        final result = await repoImpl.addToMyPatientsRange(tParams);
        expect(result, Left(HttpInternalServerErrorFailure()));
      },
    );
    test(
      "Should call return Left InputValidationFailure if InputValidationException",
          () async{
        when(mockDataSource.addToMyPatientsRange(tParams)).thenThrow(InputValidationException(message: "Wrong"));
        final result = await repoImpl.addToMyPatientsRange(tParams);
        expect(result, Left(InputValidationFailure(failureMessage: "Wrong")));
      },
    );
  },);
  group( "Testing Adding Single Patient", () {
    test(
      "Should call dataSource",
          () async{
        when(mockDataSource.addToMyPatients(1)).thenAnswer((realInvocation) async  => true);
        await repoImpl.addToMyPatients(1);
        verify(mockDataSource.addToMyPatients(1));
      },
    );
    test(
      "Should call return right true if success",
          () async{
        when(mockDataSource.addToMyPatients(2)).thenAnswer((realInvocation) async  => true);
        final result = await repoImpl.addToMyPatients(2);
        expect(result, Right(true));
      },
    );
    test(
      "Should call return Left ServerFailure if ServerException",
          () async{
        when(mockDataSource.addToMyPatients(3)).thenThrow(HttpInternalServerErrorException());
        final result = await repoImpl.addToMyPatients(3);
        expect(result, Left(HttpInternalServerErrorFailure()));
      },
    );
  },);
}
