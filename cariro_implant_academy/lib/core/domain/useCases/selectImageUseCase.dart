import 'dart:typed_data';

import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker_web/image_picker_web.dart';

class SelectImageUseCase extends UseCases<Uint8List, NoParams> {
  @override
  Future<Either<Failure, Uint8List>> call(NoParams params) async {
    try{
      final imageBytes = await ImagePickerWeb.getImageAsBytes();
      return imageBytes==null?
      Left(SelectingImageFailure(failureMessage: "No image selected")):
      Right(imageBytes);
    }catch(e)
    {
      return Left(SelectingImageFailure(failureMessage: "Couldn't select image"));
    }
  }
}
