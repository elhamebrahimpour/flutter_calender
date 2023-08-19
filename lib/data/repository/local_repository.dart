import 'package:flutter_calender/data/datasource/local_datasource.dart';
import 'package:flutter_calender/data/model/done_event.dart';
import 'package:flutter_calender/data/model/event.dart';

abstract class ILocalRepository {
  Future<void> addNewEvent(EventModel eventModel);

  Future<void> deleteEvent(EventModel eventModel);

  List<EventModel> getAllEvents();

  Future<void> addToCompletedBox(CompletedEvent completedEvent);

  List<CompletedEvent> getCompletedEvents();
}

class HiveLocalRepository extends ILocalRepository {
  final ILocalDatasource _localDatasource;

  HiveLocalRepository(this._localDatasource);

  @override
  Future<void> addNewEvent(EventModel eventModel) async {
    await _localDatasource.addNewEvent(eventModel);
  }

  @override
  Future<void> deleteEvent(EventModel eventModel) async {
    await _localDatasource.deleteEvent(eventModel);
  }

  @override
  List<EventModel> getAllEvents() {
    return _localDatasource.getAllEvents();
  }

  @override
  Future<void> addToCompletedBox(CompletedEvent completedEvent) async {
    await _localDatasource.addToCompletedBox(completedEvent);
  }

  @override
  List<CompletedEvent> getCompletedEvents() {
    return _localDatasource.getCompletedEvents();
  }
}
