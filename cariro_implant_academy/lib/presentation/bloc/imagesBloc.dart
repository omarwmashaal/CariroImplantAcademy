import 'dart:typed_data';

import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/presentation/bloc/imagesBloc_States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/domain/useCases/downloadImageUseCase.dart';
import '../../core/domain/useCases/selectImageUseCase.dart';
import '../../core/domain/useCases/uploadImageUseCase.dart';

class ImageBloc extends Cubit<ImageBloc_State> {
  final UploadImageUseCase uploadImageUseCase;
  final SelectImageUseCase selectImageUseCase;
  final DownloadImageUseCase downloadImageUseCase;
  bool reDownload = true;
  Uint8List?_image;
  ImageBloc({required this.uploadImageUseCase, required this.downloadImageUseCase, required this.selectImageUseCase}) : super(ImageInitialState()){
    _image = null;
  }

  void selectImage() async {
    emit(ImageLoadingState());
    final result = await selectImageUseCase(NoParams());
    result.fold(
      (l) => emit(ImageSelectingError(message: l.message ?? "")),
      (r) => emit(ImageLoadedState(image: r)),
    );
  }

  Future<bool> uploadImageEvent(UploadImageParams params) async {
    if(params.data==_image)
      return true;
    emit(ImageUploadingState());
    final result = await uploadImageUseCase(params);
   return result.fold(
      (l) {
        emit(ImageUploadErrorState(message: l.message ?? ""));
        return false;
      },
      (r) {
        emit(ImageLoadedState(image:params.data));
        return true;
      },
    );
  }

  void downloadImageEvent(int id) async {
    //if(!reDownload && _image!=null) return;
    emit(ImageLoadingState());
    final result = await downloadImageUseCase(id);
    result.fold(
      (l) => emit(ImageLoadingErrorState(message: "Failed to download image")),
      (r) {
        _image = r;
        emit(ImageLoadedState(image: r));
      },
    );
  }
}
