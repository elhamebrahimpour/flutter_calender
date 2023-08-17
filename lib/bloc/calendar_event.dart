part of 'calendar_bloc.dart';

abstract class CalendarEvent {}

class CalendarFetchedDataFromHiveEvent extends CalendarEvent {}

class CalendarAddedNewEvent extends CalendarEvent {
  final String eventTitle;
  final DateTime date;
  final DateTime time;
  final String eventDescription;

  CalendarAddedNewEvent(
      this.eventTitle, this.date, this.time, this.eventDescription);
}

class CalendarDeletedEvent extends CalendarEvent {
  final EventModel eventModel;
  CalendarDeletedEvent(this.eventModel);
}
