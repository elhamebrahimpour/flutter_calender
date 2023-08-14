import 'package:day_night_time_picker/day_night_time_picker.dart';

extension DateTimeCombinition on DateTime {
  DateTime toCombine(Time time) {
    return DateTime(
      year,
      month,
      day,
      time.hour,
      time.minute,
    );
  }
}
