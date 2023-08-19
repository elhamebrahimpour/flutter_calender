part of 'calendar_bloc.dart';

abstract class CalendarState {}

class CalendarInitialState extends CalendarState {}

class CalendarFetchDataFromHiveState extends CalendarState {
  final List<EventModel> events;
  final List<CompletedEvent> completedEvents;
  CalendarFetchDataFromHiveState(this.events, this.completedEvents);
}

class CalendarUpdateDataState extends CalendarState {}
