import 'package:flutter_calender/bloc/calendar_bloc.dart';
import 'package:flutter_calender/data/datasource/local_datasource.dart';
import 'package:flutter_calender/data/repository/local_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future initGetIt() async {
  locator.registerSingleton<ILocalDatasource>(HiveLocalDatasource());

  locator.registerSingleton<ILocalRepository>(
    HiveLocalRepository(locator.get()),
  );

  locator.registerSingleton<CalendarBloc>(
    CalendarBloc(locator.get()),
  );
}
