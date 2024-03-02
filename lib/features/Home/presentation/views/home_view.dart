import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeny_owners/core/utils/App_router.dart';
import 'package:sakeny_owners/core/utils/firebase_messaging_api.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FireBaseAPi().sendMessage(
              title: 'test', messageBody: 'This is the frist succes test');
          GoRouter.of(context).push(AppRouter.kAddNewAppartmentView);
        },
        elevation: 2.5,
        child: Icon(
          FontAwesomeIcons.plus,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }
}
