
import 'package:get_it/get_it.dart';
import 'package:push_notify/repository/CalendarRepository.dart';
import 'package:push_notify/ui/page/DetailViewModel.dart';

import '../data/database/database.dart';
import '../data/datasource/DataSource.dart';
import '../ui/page/CalendarViewModel.dart';
import '../ui/page/MainViewModel.dart';


GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => MyDatabase());
  locator.registerLazySingleton(() => DataSource(locator.get<MyDatabase>()));
  locator.registerLazySingleton(() => CalendarRepository(locator.get<DataSource>()));
  locator.registerFactory(() => CalendarViewModel(locator.get<CalendarRepository>()));
  locator.registerFactory(() => MainViewModel(locator.get<CalendarRepository>()));
  locator.registerFactory(() => DetailViewModel(locator.get<CalendarRepository>()));
}