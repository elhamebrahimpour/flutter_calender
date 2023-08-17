part of 'calendar_bloc.dart';

abstract class CalendarState {}

class CalendarInitialState extends CalendarState {}

class CalendarFetchDataFromHiveState extends CalendarState {
  final List<EventModel> events;
  CalendarFetchDataFromHiveState(this.events);
}

class CalendarUpdateDataState extends CalendarState {}
