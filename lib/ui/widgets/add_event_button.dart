import 'package:flutter/material.dart';
import 'package:flutter_calender/data/model/event.dart';
import 'package:flutter_calender/data/repository/local_repository.dart';
import 'package:flutter_calender/service/notification_service.dart';
import 'package:flutter_calender/utilities/const_colors.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter_calender/utilities/extension/time_extention.dart';

class AddNewEventButtonsheet extends StatefulWidget {
  final DateTime selectedDay;
  const AddNewEventButtonsheet({
    required this.selectedDay,
    super.key,
  });

  @override
  State<AddNewEventButtonsheet> createState() => _AddNewEventButtonsheetState();
}

class _AddNewEventButtonsheetState extends State<AddNewEventButtonsheet> {
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descriptionTextController =
      TextEditingController();

  DateTime scheduleReminder = DateTime.now();

  Time _time = Time.fromTimeOfDay(TimeOfDay.now(), 60);

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
      scheduleReminder = widget.selectedDay.toCombine(_time);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 22),
      height: 300,
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor,
            offset: Offset(0.0, 1.0),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: titleTextController,
            cursorColor: Colors.blue,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'title',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          TextField(
            controller: descriptionTextController,
            cursorColor: Colors.blue,
            decoration: const InputDecoration(
              hintText: 'description',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                showPicker(
                  context: context,
                  value: _time,
                  duskSpanInMinutes: 120,
                  onChange: onTimeChanged,
                ),
              );
            },
            child: const Text(
              'Select Reminder Time',
              style: TextStyle(
                color: AppColors.mainColor,
                fontSize: 16,
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 160,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
              ),
              onPressed: () async {
                if (titleTextController.text.isEmpty &&
                    descriptionTextController.text.isEmpty) {
                  return;
                } else {
                  final newEvent = EventModel(
                    titleTextController.text.trim(),
                    widget.selectedDay,
                    scheduleReminder,
                    descriptionTextController.text.trim(),
                  );
                  await HiveLocalRepository().addNewEvent(newEvent);
                  await NotificationApi.onScheduledEvent(newEvent);

                  if (mounted) Navigator.pop(context);

                  titleTextController.clear();
                  descriptionTextController.clear();
                }
              },
              child: const Text('Add Event'),
            ),
          )
        ],
      ),
    );
  }
}
