import 'package:flutter_calender/data/datasource/local_datasource.dart';
import 'package:flutter_calender/data/model/event.dart';

abstract class ILocalRepository {
  Future<void> addNewEvent(EventModel eventModel);

  Future<void> deleteEvent(EventModel eventModel);

  Future<List<EventModel>> getAllEvents();
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
  Future<List<EventModel>> getAllEvents() async {
    return await _localDatasource.getAllEvents();
  }
}
