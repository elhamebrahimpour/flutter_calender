import 'package:hive_flutter/hive_flutter.dart';

part 'done_event.g.dart';

@HiveType(typeId: 3)
class CompletedEvent extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  DateTime date;

  CompletedEvent(this.title, this.date);
}
