import 'dart:typed_data';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/repositories/imagesRepo.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UploadImageUseCase extends UseCases<bool,UploadImageParams>{
  final ImageRepo imageRepo;
  UploadImageUseCase({required this.imageRepo});
  @override
  Future<Either<Failure, bool>> call(UploadImageParams params)async {
   return await imageRepo.uploadImage(params);
  }

}

class UploadImageParams extends Equatable{
  final int id;
  final EnumImageType type;
  final Uint8List data;
  UploadImageParams({required this.id,required this.type,required this.data});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}