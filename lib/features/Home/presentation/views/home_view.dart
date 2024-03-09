import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeny_owners/core/utils/App_router.dart';
import 'package:sakeny_owners/features/Home/data/models/requset_model.dart';

import 'package:sakeny_owners/features/Home/presentation/views/widgets/custom_list_itme.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello my Owner ❤️'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        bottomOpacity: 2.5,
        elevation: 2.5,
      ),
      body: StreamBuilder<List<RequestModel>>(
        stream: _fetchRentalRequests(), // Stream of rental requests
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            log(snapshot.error.toString());
            return const Center(
                child:
                    Text('Error: some thing is wrong please come back later'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          List<RequestModel>? requests = snapshot.data;
          if (requests == null || requests.isEmpty) {
            return const Center(child: Text('No rental requests found.'));
          }

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: CustomListItem(
                  request: request,
                  onTap: () {
                    GoRouter.of(context)
                        .push(AppRouter.kRequestDetailsView, extra: request);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 7,
          shape: const CircleBorder(),
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kAddNewAppartmentView);
          },
          child: const Icon(Icons.add)),
    );
  }

  Stream<List<RequestModel>> _fetchRentalRequests() {
    // Assuming you have a Firestore collection named 'requests'
    // where each document represents a rental request

    // Replace 'requests' with your actual Firestore collection name
    // Also, adjust the query as per your Firestore database structure
    return FirebaseFirestore.instance
        .collection('Requests')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              // Convert each document to a RequestModel object
              return RequestModel.fromFirestore(doc);
            }).toList());
  }
}
