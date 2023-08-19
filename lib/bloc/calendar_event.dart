part of 'calendar_bloc.dart';

abstract class CalendarEvent {}

class CalendarFetchedDataFromHiveEvent extends CalendarEvent {}

class CalendarAddedNewEvent extends CalendarEvent {
  final String eventTitle;
  final String eventDescription;
  final DateTime date;
  final DateTime time;

  CalendarAddedNewEvent(
      this.eventTitle, this.eventDescription, this.date, this.time);
}

class CalendarDeletedEvent extends CalendarEvent {
  final EventModel eventModel;
  CalendarDeletedEvent(this.eventModel);
}

class CalendarCompletedEvent extends CalendarEvent {
  final String title;
  final DateTime date;
  CalendarCompletedEvent(this.title, this.date);
}
