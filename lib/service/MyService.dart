
import 'package:get_it/get_it.dart';
import 'package:push_notify/data/database/database.dart';
import 'package:push_notify/data/datasource/DataSource.dart';
import 'package:push_notify/data/repository/CalendarRepository.dart';
import 'package:push_notify/ui/page/MainViewModel.dart';
import 'package:push_notify/ui/page/calendar/CalendarViewModel.dart';
import 'package:push_notify/ui/page/detail/DetailViewModel.dart';



GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => MyDatabase());
  locator.registerLazySingleton(() => DataSource(locator.get<MyDatabase>()));
  locator.registerLazySingleton(() => CalendarRepository(locator.get<DataSource>()));
  locator.registerFactory(() => CalendarViewModel(locator.get<CalendarRepository>()));
  locator.registerFactory(() => MainViewModel(locator.get<CalendarRepository>()));
  locator.registerFactory(() => DetailViewModel(locator.get<CalendarRepository>()));
}