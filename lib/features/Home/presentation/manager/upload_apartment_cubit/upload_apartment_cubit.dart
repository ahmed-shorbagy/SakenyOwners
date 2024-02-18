import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sakeny_owners/features/Home/data/models/apartment_model.dart';
import 'package:sakeny_owners/features/Home/data/repos/home_repo.dart';

part 'upload_apartment_state.dart';

class UploadApartmentCubit extends Cubit<UploadApartmentState> {
  UploadApartmentCubit(this.homRepo) : super(UploadApartmentInitial());
  final HomRepo homRepo;
  Future<void> addNewApartmentToFireStore(
      {required int buildingID, required ApartmentModel apartment}) async {
    emit(UploadApartmentLoading());
    var createBuilding = await homRepo.addNewApartmentToFireStore(
        apartment: apartment, buildingID: buildingID);
    createBuilding.fold((faluire) {
      emit(UploadApartmentFaluire(faluire.errMessage));
    }, (success) {
      emit(UploadApartmentSuccess());
    });
  }
}
