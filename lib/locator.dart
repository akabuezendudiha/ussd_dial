import 'package:ussd_dial/services/api.dart';
import 'package:ussd_dial/services/shared_pref.dart';

import 'main.dart';

void setupLocator() {
  locator.registerLazySingleton<ApiService>(() => ApiService());
  locator.registerLazySingleton<AppSharedPreference>(() => AppSharedPreference());
}