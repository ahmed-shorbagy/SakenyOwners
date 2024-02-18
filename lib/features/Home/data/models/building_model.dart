import 'package:sakeny_owners/features/Home/data/models/apartment_model.dart';

class BuildingModel {
  int? id;
  List<ApartmentModel>? apartments;
  BuildingModel({this.id, this.apartments});

  Map<String, dynamic> toMap() {
    return {'id': id, 'apartments': apartments};
  }
}
