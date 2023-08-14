import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calender/data/model/event.dart';
import 'package:flutter_calender/utilities/const_colors.dart';

class EventItemGenerator extends StatelessWidget {
  final Calenderevent event;

  const EventItemGenerator({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: EventItemContent(event: event),
      ),
    );
  }
}

class EventItemContent extends StatelessWidget {
  final Calenderevent event;

  const EventItemContent({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            color: AppColors.mainColor.withOpacity(0.7),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${event.date.day}',
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: TextStyle(
                color: AppColors.blackColor.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              event.description,
              style: TextStyle(
                color: AppColors.blackColor.withOpacity(0.7),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            Icon(
              Icons.alarm_add,
              size: 22,
              color: AppColors.blackColor.withOpacity(0.6),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              '${event.time.hour}:${event.time.minute}',
              style: TextStyle(
                color: AppColors.blackColor.withOpacity(0.9),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        CheckBoxItem(event: event)
      ],
    );
  }
}

class CheckBoxItem extends StatefulWidget {
  final Calenderevent event;
  const CheckBoxItem({
    required this.event,
    super.key,
  });

  @override
  State<CheckBoxItem> createState() => _CheckBoxItemState();
}

class _CheckBoxItemState extends State<CheckBoxItem> {
  bool _isBoxChecked = false;

  @override
  void initState() {
    super.initState();
    _isBoxChecked = widget.event.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: CupertinoCheckbox(
        value: _isBoxChecked,
        activeColor: AppColors.whiteColor,
        checkColor: AppColors.mainColor,
        side: const BorderSide(
          color: AppColors.mainColor,
        ),
        onChanged: (newValue) {
          setState(() {
            _isBoxChecked = newValue!;
            widget.event.isDone = _isBoxChecked;
            widget.event.save();
          });
        },
      ),
    );
  }
}
