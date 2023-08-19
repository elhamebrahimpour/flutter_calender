import 'package:hive_flutter/hive_flutter.dart';

part 'event.g.dart';

@HiveType(typeId: 2)
class EventModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  DateTime time;
  @HiveField(4)
  bool isDone;

  EventModel(
    this.title,
    this.description,
    this.date,
    this.time, {
    this.isDone = false,
  });
}
