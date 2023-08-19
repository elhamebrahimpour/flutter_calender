import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calender/bloc/calendar_bloc.dart';
import 'package:flutter_calender/data/model/done_event.dart';
import 'package:flutter_calender/data/model/event.dart';
import 'package:flutter_calender/di/get_it.dart';
import 'package:flutter_calender/service/notification_service.dart';
import 'package:flutter_calender/ui/screens/calender_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(EventModelAdapter());
  Hive.registerAdapter(CompletedEventAdapter());

  await Hive.openBox<EventModel>('eventBox');
  await Hive.openBox<CompletedEvent>('completedEventBox');

  await initGetIt();

  NotificationApi.initNotification();

  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => locator.get<CalendarBloc>(),
        child: const CalenderScreen(),
      ),
    );
  }
}
