import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calender/data/model/done_event.dart';
import 'package:flutter_calender/utilities/const_colors.dart';

class CompletedEventItemGenerator extends StatefulWidget {
  final CompletedEvent completedEvents;

  const CompletedEventItemGenerator({Key? key, required this.completedEvents})
      : super(key: key);

  @override
  State<CompletedEventItemGenerator> createState() =>
      _CompletedEventItemGeneratorState();
}

class _CompletedEventItemGeneratorState
    extends State<CompletedEventItemGenerator> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
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
                  '${widget.completedEvents.date.day}',
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
            Text(
              widget.completedEvents.title,
              style: TextStyle(
                color: AppColors.blackColor.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Transform.scale(
              scale: 1.2,
              child: CupertinoCheckbox(
                value: true,
                activeColor: AppColors.whiteColor,
                checkColor: AppColors.mainColor,
                side: const BorderSide(
                  color: AppColors.mainColor,
                ),
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
