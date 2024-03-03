import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:sakeny_owners/features/Home/data/models/requset_model.dart';
import 'package:sakeny_owners/features/Home/data/repos/home_repo.dart';

part 'fetch_requests_state.dart';

class FetchRequestsCubit extends Cubit<FetchRequestsState> {
  FetchRequestsCubit(this.homeRepo) : super(FetchRequestsInitial());
  final HomRepo homeRepo;

  Future<void> fetchNewRequests() async {
    emit(FetchRequestsLoading());
    var result = await homeRepo.fetchRequests(
        query: FirebaseFirestore.instance
            .collection('Requests')
            .orderBy('time', descending: true));

    result.fold((failure) {
      emit(FetchRequestsFaluire(failure.errMessage));
    }, (requests) {
      emit(FetchRequestsSuccess(requests));
    });
  }
}
