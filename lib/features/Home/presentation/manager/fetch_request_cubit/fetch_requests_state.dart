part of 'fetch_requests_cubit.dart';

@immutable
sealed class FetchRequestsState {}

final class FetchRequestsInitial extends FetchRequestsState {}

final class FetchRequestsSuccess extends FetchRequestsState {
  final List<RequestModel> requestsList;
  FetchRequestsSuccess(this.requestsList);
}

final class FetchRequestsLoading extends FetchRequestsState {}

final class FetchRequestsFaluire extends FetchRequestsState {
  final String errMessage;

  FetchRequestsFaluire(this.errMessage);
}
