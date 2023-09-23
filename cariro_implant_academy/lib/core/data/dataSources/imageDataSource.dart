import 'dart:convert';
import 'dart:typed_data';

import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/constants/remoteConstants.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';

import '../../domain/useCases/uploadImageUseCase.dart';

abstract class ImageDataSource {
  Future<Uint8List> downloadImage(int id);

  Future<bool> uploadImage(UploadImageParams imageParams);
}

class ImageDataSourceImpl implements ImageDataSource {
  final HttpRepo httpRepo;

  ImageDataSourceImpl({required this.httpRepo});

  @override
  Future<Uint8List> downloadImage(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(
        host: "$serverHost/$imageController/DownloadImage?id=$id",
      );
    } catch (e) {
      throw HttpInternalServerErrorException();
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);

    try {
      return base64Decode(response.body as String);
    } catch (e) {
      throw DataConversionException(message: "Couldn't Convert data");
    }
  }

  @override
  Future<bool> uploadImage(UploadImageParams imageParams) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.uploadImage(
        url: "$serverHost/$imageController/UploadImage?type=${imageParams.type.index}&id=${imageParams.id}",
        imageBytes: imageParams.data,
      );
    } catch (e) {
      throw HttpInternalServerErrorException();
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode,message: response.errorMessage);
    return true;
  }
}
