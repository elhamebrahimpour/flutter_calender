import 'package:flutter_calender/data/model/event.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ILocalDatasource {
  Future<void> addNewEvent(EventModel eventModel);

  Future<void> deleteEvent(EventModel eventModel);

  Future<List<EventModel>> getAllEvents();
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
  Future<List<EventModel>> getAllEvents() async {
    return eventBox.values.toList();
  }
}
