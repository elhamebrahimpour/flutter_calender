import 'package:flutter_calender/data/datasource/local_datasource.dart';
import 'package:flutter_calender/data/model/event.dart';

abstract class ILocalRepository {
  Future<void> addNewEvent(EventModel eventModel);

  Future<void> deleteEvent(EventModel eventModel);

  List<EventModel> getEventsByDay(DateTime day);
}

class HiveLocalRepository extends ILocalRepository {
  final ILocalDatasource _localDatasource = HiveLocalDatasource();

  @override
  Future<void> addNewEvent(EventModel eventModel) async {
    await _localDatasource.addNewEvent(eventModel);
  }

  @override
  Future<void> deleteEvent(EventModel eventModel) async {
    await _localDatasource.deleteEvent(eventModel);
  }

  @override
  List<EventModel> getEventsByDay(DateTime day) {
    return _localDatasource.getEventsByDay(day);
  }
}
