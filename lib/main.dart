import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sakeny_owners/core/errors/simple_bloc_observer.dart';
import 'package:sakeny_owners/core/theme/theme_manager.dart';
import 'package:sakeny_owners/core/utils/App_router.dart';
import 'package:sakeny_owners/core/utils/service_locator.dart';
import 'package:sakeny_owners/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupServiceLocator();

  runApp(ChangeNotifierProvider(
      create: (context) {
        return ThemeProvider();
      },
      child: const SakenyOwners()));

  Bloc.observer = SimpleBLocObserver();
}

class SakenyOwners extends StatelessWidget {
  const SakenyOwners({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
