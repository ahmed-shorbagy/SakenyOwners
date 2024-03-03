import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakeny_owners/core/errors/faluire.dart';
import 'package:sakeny_owners/features/Home/data/models/apartment_model.dart';
import 'package:sakeny_owners/features/Home/data/models/requset_model.dart';

class HomRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Either<Faluire, void>> addNewApartmentToFireStore(
      {required ApartmentModel apartment, required int buildingID}) async {
    try {
      final apartmentRef = firestore.collection('Apartments').doc();
      await apartmentRef.set(apartment.toMap());
      return right(null);
    } on FirebaseException catch (e) {
      return left(FirebaseFaluire.fromFireStore(e.code));
    }
  }

  Future<List<String>> uploadPhotos(List<XFile> photos) async {
    List<String> photoUrls = [];

    for (XFile photo in photos) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = _storage.ref().child('apartment_photos/$fileName');
      UploadTask uploadTask = storageRef.putFile(File(photo.path));
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      photoUrls.add(downloadUrl);
    }

    return photoUrls;
  }

  Future<Either<Faluire, List<RequestModel>>> fetchRequests(
      {required Query query}) async {
    try {
      final QuerySnapshot querySnapshot = await query.get();

      final List<RequestModel> requests = [];
      for (final doc in querySnapshot.docs) {
        requests.add(RequestModel.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>));
      }

      return Right(requests);
    } on FirebaseException catch (e) {
      // Handle Firebase exception
      return left(FirebaseFaluire.fromFireStore(e.code));
    }
  }
}
