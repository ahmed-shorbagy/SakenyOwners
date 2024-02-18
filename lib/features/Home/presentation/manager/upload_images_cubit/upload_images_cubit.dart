import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:sakeny_owners/features/Home/data/repos/home_repo.dart';

part 'upload_images_state.dart';

class UploadImagesCubit extends Cubit<UploadImagesState> {
  static List<XFile> imageFileList = [];
  UploadImagesCubit(this._homRepo) : super(UploadImagesInitial());
  final HomRepo _homRepo;

  Future<void> uploadImage({required List<XFile> images}) async {
    emit(UploadImagesLoading());

    try {
      var urls = await _homRepo.uploadPhotos(images);

      emit(UploadImagesSuccess(urls));
    } on FirebaseException catch (e) {
      emit(UploadImagesFaluire(e.code));
    }
  }
}
