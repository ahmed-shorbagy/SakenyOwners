import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sakeny_owners/features/Home/data/models/apartment_model.dart';
import 'package:sakeny_owners/features/Home/data/models/user_model.dart';

class Request {
  ApartmentModel apartment;
  UserModel user;

  Request({required this.apartment, required this.user});

  factory Request.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return Request(
      apartment: ApartmentModel.fromFirestore(data['apartment']),
      user: UserModel.fromFirestore(data['user']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'apartment': apartment.toMap(),
      'user': user.toMap(),
    };
  }
}