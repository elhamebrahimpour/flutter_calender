import 'package:flutter_calender/data/model/event.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

abstract class ILocalDatasource {
  Future<void> addNewEvent(Calenderevent eventModel);

  Future<void> deleteEvent(Calenderevent eventModel);

  List<Calenderevent> getEventsByDay(DateTime day);
}

class HiveLocalDatasource extends ILocalDatasource {
  var eventBox = Hive.box<Calenderevent>('eventBox');

  @override
  Future<void> addNewEvent(Calenderevent eventModel) async {
    await eventBox.add(eventModel);
  }

  @override
  Future<void> deleteEvent(Calenderevent eventModel) async {
    await eventModel.delete();
  }

  @override
  List<Calenderevent> getEventsByDay(DateTime day) {
    return eventBox.values
        .where((event) => isSameDay(event.date, day))
        .toList();
  }
}
