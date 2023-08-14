import 'package:flutter/material.dart';
import 'package:flutter_calender/data/model/event.dart';
import 'package:flutter_calender/service/notification_service.dart';
import 'package:flutter_calender/ui/screens/calender_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CalendereventAdapter());
  await Hive.openBox<Calenderevent>('eventBox');

  NotificationApi.initNotification();

  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalenderScreen(),
    );
  }
}
