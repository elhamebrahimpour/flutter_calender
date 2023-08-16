import 'package:flutter_calender/data/model/event.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

abstract class ILocalDatasource {
  Future<void> addNewEvent(EventModel eventModel);

  Future<void> deleteEvent(EventModel eventModel);

  List<EventModel> getEventsByDay(DateTime day);
}

class HiveLocalDatasource extends ILocalDatasource {
  var eventBox = Hive.box<EventModel>('eventBox');

  @override
  Future<void> addNewEvent(EventModel eventModel) async {
    await eventBox.add(eventModel);
  }

  @override
  Future<void> deleteEvent(EventModel eventModel) async {
    await eventModel.delete();
  }

  @override
  List<EventModel> getEventsByDay(DateTime day) {
    final events = eventBox.values.toList();
    return events.where((event) => isSameDay(event.date, day)).toList();
  }
}
