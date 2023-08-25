import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class ImageBloc_State extends Equatable{}

class ImageUploadingState extends ImageBloc_State{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}class ImageDownloadingState extends ImageBloc_State{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}class ImageLoadingState extends ImageBloc_State{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ImageUploadedState extends ImageBloc_State{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ImageUploadErrorState extends ImageBloc_State{
  final String message;
  ImageUploadErrorState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class ImageInitialState extends ImageBloc_State{
   @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ImageSelectingError extends ImageBloc_State{
  final String message;
  ImageSelectingError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class ImageLoadedState extends ImageBloc_State{
  final Uint8List image;
  ImageLoadedState({required this.image});
  @override
  // TODO: implement props
  List<Object?> get props => [image];
}


class ImageLoadingErrorState extends ImageBloc_State{
  final String message;
  ImageLoadingErrorState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}



