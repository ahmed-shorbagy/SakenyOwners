import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sakeny_owners/features/Home/data/models/apartment_model.dart';
import 'package:sakeny_owners/features/Home/data/models/user_model.dart';

enum BedType {
  single,
  doublee,
  triple,
}

class RequestModel {
  ApartmentModel apartment;
  UserModel user;
  BedType bedType; // Added field for bed type
  Timestamp? requestTime;
  String? requestID;

  RequestModel(
      {required this.apartment,
      required this.user,
      required this.bedType,
      this.requestTime,
      this.requestID});

  factory RequestModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return RequestModel(
        requestID: snapshot.id,
        apartment: ApartmentModel.fromFirestore(data['apartment']),
        user: UserModel.fromFirestore(data['user']),
        bedType: _parseBedType(data['bedType']),
        requestTime: data['requestTime'] // Parse bed type from Firestore data
        );
  }

  Map<String, dynamic> toMap() {
    return {
      'apartment': apartment.toMap(docID: apartment.apartmentID ?? ''),
      'user': user.toMap(),
      'bedType': _encodeBedType(bedType),
      'requestTime': requestTime
    };
  }

  static BedType _parseBedType(String value) {
    switch (value) {
      case 'single':
        return BedType.single;
      case 'doublee':
        return BedType.doublee;
      case 'triple':
        return BedType.triple;
      default:
        throw ArgumentError('Invalid bed type: $value');
    }
  }

  static String _encodeBedType(BedType type) {
    return type.toString().split('.').last;
  }
}
