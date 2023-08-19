import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calender/bloc/calendar_bloc.dart';
import 'package:flutter_calender/data/model/done_event.dart';
import 'package:flutter_calender/data/model/event.dart';
import 'package:flutter_calender/ui/widgets/event_item.dart';
import 'package:flutter_calender/utilities/const_colors.dart';

//tabBar content widget
class TabBarViewContent extends StatelessWidget {
  final TabController? tabController;
  final DateTime selectedDay;
  final List<EventModel> events;
  final List<CompletedEvent> completedEvents;

  const TabBarViewContent(
      this.tabController, this.selectedDay, this.events, this.completedEvents,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        return TabBarView(
          controller: tabController,
          children: [
            OngoingEvents(
              selectedDay: selectedDay,
              events: events,
            ),
            CompletedEvents(
              selectedDay: selectedDay,
              completedEvents: completedEvents,
            )
          ],
        );
      },
    );
  }
}

class CompletedEvents extends StatelessWidget {
  final DateTime selectedDay;
  final List<CompletedEvent> completedEvents;

  const CompletedEvents({
    super.key,
    required this.selectedDay,
    required this.completedEvents,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Card(
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
                                    '${completedEvents[index].date.day}',
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
                                completedEvents[index].title,
                                style: TextStyle(
                                  color: AppColors.blackColor.withOpacity(0.9),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      right: 4,
                      bottom: 12,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.blackColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                );
              },
              childCount: completedEvents.length,
            ),
          ),
        ),
      ],
    );
  }
}

class OngoingEvents extends StatelessWidget {
  final DateTime selectedDay;
  final List<EventModel> events;

  const OngoingEvents(
      {super.key, required this.selectedDay, required this.events});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: EventItemGenerator(
                    event: getEventsByDay(events, selectedDay)[index],
                  ),
                );
              },
              childCount: getEventsByDay(events, selectedDay).length,
            ),
          ),
        ),
      ],
    );
  }
}
