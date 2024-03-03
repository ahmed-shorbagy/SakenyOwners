import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeny_owners/core/utils/service_locator.dart';
import 'package:sakeny_owners/features/Home/data/models/requset_model.dart';
import 'package:sakeny_owners/features/Home/data/repos/home_repo.dart';
import 'package:sakeny_owners/features/Home/presentation/manager/fetch_request_cubit/fetch_requests_cubit.dart';
import 'package:sakeny_owners/features/Home/presentation/manager/upload_apartment_cubit/upload_apartment_cubit.dart';
import 'package:sakeny_owners/features/Home/presentation/manager/upload_images_cubit/upload_images_cubit.dart';
import 'package:sakeny_owners/features/Home/presentation/views/add_new_appartment_view.dart';
import 'package:sakeny_owners/features/Home/presentation/views/home_view.dart';
import 'package:sakeny_owners/features/Home/presentation/views/request_Details_view.dart';
import 'package:sakeny_owners/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const String kHomeView = '/HomeView';

  static const String kAddNewAppartmentView = '/AddNewAppartmentView';
  static const String kRequestDetailsView = '/RequestDetailsView';
  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
        path: kHomeView,
        pageBuilder: (context, state) {
          return stylishSideTransition(
              child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => UploadImagesCubit(getIt.get<HomRepo>())),
              BlocProvider(
                  create: (context) => FetchRequestsCubit(getIt.get<HomRepo>()))
            ],
            child: const HomeView(),
          ));
        }),
    GoRoute(
      path: kAddNewAppartmentView,
      pageBuilder: (context, state) {
        return basicTransition(
            child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => UploadImagesCubit(getIt.get<HomRepo>()),
            ),
            BlocProvider(
              create: (context) => UploadApartmentCubit(getIt.get<HomRepo>()),
            )
          ],
          child: const AddNewAppartmentView(),
        ));
      },
    ),
    GoRoute(
        path: kRequestDetailsView,
        pageBuilder: (context, state) {
          return stylishSideTransition(
              child: RequestDetailsView(
            request: state.extra as RequestModel,
          ));
        }),
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
