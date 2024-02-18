part of 'upload_apartment_cubit.dart';

@immutable
sealed class UploadApartmentState {}

final class UploadApartmentInitial extends UploadApartmentState {}

final class UploadApartmentLoading extends UploadApartmentState {}

final class UploadApartmentSuccess extends UploadApartmentState {}

final class UploadApartmentFaluire extends UploadApartmentState {
  final String errMessage;

  UploadApartmentFaluire(this.errMessage);
}
