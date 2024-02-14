import 'package:get_it/get_it.dart';
import 'package:sakeny_owners/features/Home/data/repos/home_repo.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<HomRepo>(
    HomRepo(),
  );
}
