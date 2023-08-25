import 'dart:typed_data';
import 'dart:ui';

import 'package:cariro_implant_academy/core/data/dataSources/imageDataSource.dart';
import 'package:cariro_implant_academy/core/domain/repositories/imagesRepo.dart';
import 'package:cariro_implant_academy/core/domain/useCases/uploadImageUseCase.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../constants/enums/enums.dart';

class ImageRepoImpl implements ImageRepo{
  final ImageDataSource dataSource;
  ImageRepoImpl({required this.dataSource});
  @override
  Future<Either<Failure, Uint8List>> downloadImage(int id)async {
    try{
      final result = await dataSource.downloadImage(id);
      return Right(result);
    }on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> uploadImage(UploadImageParams imageParams) async{
    try{
      final result = await dataSource.uploadImage(imageParams);
      return Right(result);
    }on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }



}