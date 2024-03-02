import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sakeny_owners/features/Home/data/models/apartment_model.dart';

part 'apartment_state.dart';

class ApartmentCubit extends Cubit<ApartmentState> {
  static ApartmentModel apartment = ApartmentModel(type: []);


  ApartmentCubit() : super(ApartmentInitial());
}
