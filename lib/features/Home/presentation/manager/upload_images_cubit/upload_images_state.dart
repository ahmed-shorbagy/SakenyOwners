part of 'upload_images_cubit.dart';

@immutable
sealed class UploadImagesState {}

final class UploadImagesInitial extends UploadImagesState {}

final class UploadImagesLoading extends UploadImagesState {}

final class UploadImagesFaluire extends UploadImagesState {
  final String errMessage;

  UploadImagesFaluire(this.errMessage);
}

final class UploadImagesSuccess extends UploadImagesState {
  final List<String> photosUrl;

  UploadImagesSuccess(this.photosUrl);
}
