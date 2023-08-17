import 'package:bloc/bloc.dart';
import 'package:flutter_calender/data/model/event.dart';
import 'package:flutter_calender/data/repository/local_repository.dart';
import 'package:flutter_calender/service/notification_service.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final ILocalRepository _localRepository;

  CalendarBloc(this._localRepository) : super(CalendarInitialState()) {
    on<CalendarFetchedDataFromHiveEvent>((event, emit) async {
      final events = await _localRepository.getAllEvents();

      emit(CalendarFetchDataFromHiveState(events));
    });

    on<CalendarAddedNewEvent>((event, emit) async {
      var newEvent = EventModel(
        event.eventTitle,
        event.date,
        event.time,
        event.eventDescription,
      );

      await _localRepository.addNewEvent(newEvent);
      emit(CalendarUpdateDataState());

      //pass the event that you want to schedule it
      NotificationApi.onScheduledEvent(newEvent);
    });

    on<CalendarDeletedEvent>((event, emit) async {
      await _localRepository.deleteEvent(event.eventModel);
      emit(CalendarUpdateDataState());
    });
  }
}

// this method uses in ui section
List<EventModel> getEventsByDay(List<EventModel> events, DateTime day) {
  return events.where((event) => isSameDay(event.date, day)).toList();
}
