import 'package:hive_flutter/hive_flutter.dart';

part 'event.g.dart';

@HiveType(typeId: 0)
class EventModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  DateTime time;
  @HiveField(3)
  String description;
  @HiveField(4)
  bool isDone;

  EventModel(
    this.title,
    this.date,
    this.time,
    this.description, {
    this.isDone = false,
  });
}
