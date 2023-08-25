import 'dart:typed_data';

import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/domain/repositories/imagesRepo.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DownloadImageUseCase extends UseCases<Uint8List,int>{
  final ImageRepo imageRepo;
  DownloadImageUseCase({required this.imageRepo});
  @override
  Future<Either<Failure, Uint8List>> call(int id)async {
   return await imageRepo.downloadImage(id);
  }

}
