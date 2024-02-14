import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeny_owners/features/Home/presentation/views/add_new_apartment_view.dart';
import 'package:sakeny_owners/features/Home/presentation/views/home_view.dart';
import 'package:sakeny_owners/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const String kHomeView = '/HomeView';

  static const String kAddNewAppartmentView = '/AddNewAppartmentView';
  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
        path: kHomeView,
        pageBuilder: (context, state) {
          return stylishSideTransition(child: const HomeView());
        }),
    GoRoute(
      path: kAddNewAppartmentView,
      pageBuilder: (context, state) {
        return basicTransition(child: const AddNewAppartmentView());
      },
    ),
  ]);
}

CustomTransitionPage stylishSideTransition({required child}) {
  return CustomTransitionPage(
    transitionDuration: const Duration(milliseconds: 300),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .animate(animation),
        child: child,
      );
    },
  );
}

CustomTransitionPage basicTransition({required child}) {
  return CustomTransitionPage(
    transitionDuration: const Duration(milliseconds: 400),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}
