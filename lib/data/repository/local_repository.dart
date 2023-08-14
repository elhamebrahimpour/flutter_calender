import 'package:flutter_calender/data/datasource/local_datasource.dart';
import 'package:flutter_calender/data/model/event.dart';

abstract class ILocalRepository {
  Future<void> addNewEvent(Calenderevent eventModel);

  Future<void> deleteEvent(Calenderevent eventModel);

  List<Calenderevent> getEventsByDay(DateTime day);
}

class HiveLocalRepository extends ILocalRepository {
  final ILocalDatasource _localDatasource = HiveLocalDatasource();

  @override
  Future<void> addNewEvent(Calenderevent eventModel) async {
    await _localDatasource.addNewEvent(eventModel);
  }

  @override
  Future<void> deleteEvent(Calenderevent eventModel) async {
    await _localDatasource.deleteEvent(eventModel);
  }

  @override
  List<Calenderevent> getEventsByDay(DateTime day) {
    return _localDatasource.getEventsByDay(day);
  }
}
