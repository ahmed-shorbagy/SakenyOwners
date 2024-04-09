import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sakeny_owners/features/Home/data/models/requset_model.dart';

class CustomListItem extends StatelessWidget {
  final RequestModel request;
  final void Function() onTap;
  const CustomListItem({super.key, required this.request, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 10,
        shadowColor: Theme.of(context).colorScheme.primary,
        surfaceTintColor: Theme.of(context).colorScheme.primary,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    image: request.apartment.photosUrls != null &&
                            request.apartment.photosUrls!.isNotEmpty
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(
                                request.apartment.photosUrls!.first),
                            fit: BoxFit.cover,
                          )
                        : null, // If photosUrls is empty or null, do not set image
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User Name : ${request.user.name}',
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 8.0),
                      Text(
                        'building ID : ${request.apartment.buildingID}',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        request.apartment.isForMales ?? true
                            ? 'males only'
                            : 'females only',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
