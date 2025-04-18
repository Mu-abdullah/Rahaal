import 'package:get_it/get_it.dart';

import '../../../auth/data/repo/create_user_repo.dart';
import '../../../features/add_new_place/data/repo/add_images.dart';
import '../../../features/add_new_place/data/repo/add_place_info.dart';
import '../../../features/home_screen/data/repo/get_home_city_repo.dart';
import '../../../features/all_governorate/data/repo/governorates_repo.dart';
import '../../../features/home_screen/data/repo/get_home_governorates_repo.dart';
import '../../../features/policy/data/repo/policy_repo.dart';
import '../supabase/data_services.dart';
import '../supabase/supabase_services.dart';
import '../supabase/supabase_services_repo.dart';

final GetIt locator = GetIt.instance;
void setupLocator() {
  _registerRepositories();
  _registerServices();
}

void _registerRepositories() {
  locator.registerLazySingleton(() => GetGovernoratesRepo(locator()));
  locator.registerLazySingleton(() => GetHomeGovernoratesRepo(locator()));
  locator.registerLazySingleton(() => GetHomeCityRepo(locator()));
  // locator.registerLazySingleton(() => GetPlacesRepo(locator()));
  locator.registerLazySingleton(() => AddPlaceInfo(locator()));
  locator.registerLazySingleton(() => AddImages(locator()));
  locator.registerLazySingleton(() => PolicyRepo(locator()));
  locator.registerLazySingleton(() => CreateUserRepo(locator()));
}

void _registerServices() {
  locator.registerLazySingleton(() => SupabaseServicesRepo());
  locator
      .registerLazySingleton<DataService>(() => SupabaseDataService(locator()));
}
