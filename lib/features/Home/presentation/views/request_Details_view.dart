import 'package:flutter/material.dart';
import 'package:sakeny_owners/features/Home/data/models/requset_model.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/Custom_app_bar%20copy.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/Custom_app_bar.dart';
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
                child: Text(
                  'User Name : ${request.user.name}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  'User phone : ${request.user.phoneNumber}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  'User type : ${request.user.isMail ?? true ? 'Mail' : 'Femail'}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  'owner name  : ${request.apartment.ownerName}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  'owner phone  : ${request.apartment.ownerPhone}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  'Apartment Type type : ${request.apartment.isForMales ?? true ? 'Mails only' : 'Femails only'}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  'Building ID : ${request.apartment.buildingID}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  'Time Requested : ${request.requestTime!.toDate()}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
