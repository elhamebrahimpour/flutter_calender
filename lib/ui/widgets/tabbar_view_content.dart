import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calender/bloc/calendar_bloc.dart';
import 'package:flutter_calender/data/model/done_event.dart';
import 'package:flutter_calender/data/model/event.dart';
import 'package:flutter_calender/ui/widgets/completed_event_item.dart';
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
    return completedEvents.isEmpty
        ? const Center(
            child: Text('empty'),
          )
        : CustomScrollView(
            slivers: [
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return CompletedEventItemGenerator(
                        completedEvents: completedEvents[index],
                      );
                    },
                    childCount: completedEvents.length,
                  ),
                ),
              ),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                sliver: SliverToBoxAdapter(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.5,
                      backgroundColor: AppColors.buttonColor,
                      minimumSize: const Size(120, 42),
                    ),
                    onPressed: () => BlocProvider.of<CalendarBloc>(context).add(
                      ClearAllEvent(),
                    ),
                    child: const Text(
                      'Clear All',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
