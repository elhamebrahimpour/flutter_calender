import 'package:flutter_calender/data/model/done_event.dart';
import 'package:flutter_calender/data/model/event.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ILocalDatasource {
  Future<void> addNewEvent(EventModel eventModel);

  Future<void> deleteEvent(EventModel eventModel);

  List<EventModel> getAllEvents();

  Future<void> addToCompletedBox(CompletedEvent completedEvent);

  List<CompletedEvent> getCompletedEvents();

  Future<void> deleteAllEvents();
}

class HiveLocalDatasource extends ILocalDatasource {
  var eventBox = Hive.box<EventModel>('eventBox');
  var completedEventBox = Hive.box<CompletedEvent>('completedEventBox');

  @override
  Future<void> addNewEvent(EventModel eventModel) async {
    await eventBox.add(eventModel);
  }

  @override
  Future<void> deleteEvent(EventModel eventModel) async {
    await eventModel.delete();
  }

  @override
  List<EventModel> getAllEvents() {
    return eventBox.values.toList();
  }

  @override
  Future<void> addToCompletedBox(CompletedEvent completedEvent) async {
    await completedEventBox.add(completedEvent);
  }

  @override
  List<CompletedEvent> getCompletedEvents() {
    return completedEventBox.values.toList();
  }

  @override
  Future<void> deleteAllEvents() async {
    await completedEventBox.delete('completedEventBox');
  }
}
