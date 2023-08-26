import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calender/bloc/calendar_bloc.dart';
import 'package:flutter_calender/data/model/event.dart';
import 'package:flutter_calender/utilities/const_colors.dart';

class EventItemGenerator extends StatefulWidget {
  final EventModel event;

  const EventItemGenerator({Key? key, required this.event}) : super(key: key);

  @override
  State<EventItemGenerator> createState() => _EventItemGeneratorState();
}

class _EventItemGeneratorState extends State<EventItemGenerator> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        BlocProvider.of<CalendarBloc>(context)
            .add(CalendarDeletedEvent(widget.event));

        BlocProvider.of<CalendarBloc>(context).add(
          CalendarAddedToCompletedEvent(widget.event.title, widget.event.date),
        );
      },
      child: Card(
        elevation: 1,
        color: AppColors.whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _buildDateShape(),
              const SizedBox(
                width: 16,
              ),
              _buildTitleDescription(),
              const Spacer(),
              _buildAlarmTime(),
              EventChekcedBox(eventModel: widget.event)
            ],
          ),
        ),
      ),
    );
  }

  Container _buildDateShape() {
    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
        color: AppColors.mainColor.withOpacity(0.7),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '${widget.event.date.day}',
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Column _buildTitleDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.event.title,
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
          widget.event.description,
          overflow: TextOverflow.ellipsis,
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
    );
  }

  Row _buildAlarmTime() {
    return Row(
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
          '${widget.event.time.hour}:${widget.event.time.minute}',
          style: TextStyle(
            color: AppColors.blackColor.withOpacity(0.9),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}

class EventChekcedBox extends StatefulWidget {
  final EventModel eventModel;
  const EventChekcedBox({super.key, required this.eventModel});

  @override
  State<EventChekcedBox> createState() => _EventChekcedBoxState();
}

class _EventChekcedBoxState extends State<EventChekcedBox> {
  bool _isBoxChecked = false;

  @override
  void initState() {
    super.initState();
    _isBoxChecked = widget.eventModel.isDone;
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
            widget.eventModel.isDone = _isBoxChecked;
            widget.eventModel.save();
          });
        },
      ),
    );
  }
}
