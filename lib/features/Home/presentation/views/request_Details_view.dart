import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sakeny_owners/features/Home/data/models/requset_model.dart';
import 'package:sakeny_owners/features/Home/data/repos/home_repo.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/Custom_app_bar%20copy.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/custom_images_slider.dart';

class RequestDetailsView extends StatelessWidget {
  const RequestDetailsView({super.key, required this.request});
  final RequestModel request;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomAppBar2(
                title: 'Apartment Details',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: CustomImagesSlider(apartment: request.apartment),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ExpansionTile(
                  title: Text('User Description',
                      style: Theme.of(context).textTheme.bodyLarge),
                  iconColor: Theme.of(context).colorScheme.primary,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary)),
                  collapsedShape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline)),
                  children: [Text('${request.apartment.userDescription}')],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ExpansionTile(
                  title: Text('Owner Description',
                      style: Theme.of(context).textTheme.bodyLarge),
                  iconColor: Theme.of(context).colorScheme.primary,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary)),
                  collapsedShape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline)),
                  children: [Text('${request.apartment.ownerDescription}')],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: SelectableText(
                  'User Name : ${request.user.name}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: SelectableText(
                  'User phone : ${request.user.phoneNumber}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: SelectableText(
                  'User type : ${request.user.isMail! ? 'Mail' : 'Femail'}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: SelectableText(
                  'owner name  : ${request.apartment.ownerName}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: SelectableText(
                  'owner phone  : ${request.apartment.ownerPhone}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: SelectableText(
                  'Apartment Type : ${request.apartment.isForMales ?? true ? 'Mails only' : 'Femails only'}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: SelectableText(
                  'Building ID : ${request.apartment.buildingID}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: SelectableText(
                  'Time Requested: ${DateFormat('EEE, MMM d, hh:mm a', 'en_US').format(request.requestTime!.toDate().toLocal()).toString()}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: SelectableText(
                  'bed Type : ${request.bedType.name}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ElevatedButton(
                  onPressed: () async {
                    final DocumentSnapshot<Map<String, dynamic>> snapshot =
                        await FirebaseFirestore.instance
                            .collection('Apartments')
                            .doc(request.apartment.apartmentID)
                            .get();
                    if (request.bedType.name == 'single') {
                      // Parse the current value to an integer
                      int currentValue =
                          int.parse(snapshot.data()!['numberOfSingleBeds']);

                      // Decrement the value by 1
                      currentValue -= 1;

                      // Update the value in Firestore
                      await FirebaseFirestore.instance
                          .collection('Apartments')
                          .doc(request.apartment.apartmentID)
                          .update({
                        'numberOfSingleBeds': currentValue.toString(),
                      });
                    } else if (request.bedType.name == 'doublee') {
                      int currentValue =
                          int.parse(snapshot.data()!['numberOfDoubleBeds']);

                      // Decrement the value by 1
                      currentValue -= 1;

                      await FirebaseFirestore.instance
                          .collection('Apartments')
                          .doc(request.apartment.apartmentID)
                          .update(
                              {'numberOfDoubleBeds': currentValue.toString()});
                    } else if (request.bedType.name == 'triple') {
                      int currentValue =
                          int.parse(snapshot.data()!['numberOfTripleBeds']);

                      // Decrement the value by 1
                      currentValue -= 1;
                      await FirebaseFirestore.instance
                          .collection('Apartments')
                          .doc(request.apartment.apartmentID)
                          .update(
                              {'numberOfTripleBeds': currentValue.toString()});
                    }
                  },
                  child:
                      const Text('click here only if the bed already rented'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('Requests')
                        .doc(request.requestID)
                        .delete();
                    GoRouter.of(context).pop();
                  },
                  child: const Text('Reject'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("Apartments")
                        .doc(request.apartment.apartmentID)
                        .delete();
                    await HomRepo().deleteRequestAndImages(request);

                    GoRouter.of(context).pop();
                  },
                  child: const Text('Delete this Request and Apartment'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
