import 'dart:typed_data';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../error/failure.dart';
import '../useCases/uploadImageUseCase.dart';

abstract class ImageRepo{
  Future<Either<Failure,Uint8List>> downloadImage(int id);
  Future<Either<Failure,bool>> uploadImage(UploadImageParams imageParams);
}
