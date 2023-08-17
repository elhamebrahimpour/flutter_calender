import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calender/bloc/calendar_bloc.dart';
import 'package:flutter_calender/cubit/change_cubit.dart';
import 'package:flutter_calender/di/get_it.dart';
import 'package:flutter_calender/ui/widgets/add_event_button.dart';
import 'package:flutter_calender/ui/widgets/tabbar_view_content.dart';
import 'package:flutter_calender/utilities/const_colors.dart';
import 'package:flutter_calender/utilities/utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen>
    with SingleTickerProviderStateMixin {
  final AppCubit appCubit = AppCubit();

  DateTime _today = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  TabController? _tabController;
  bool _isFabVisible = true;

  // calendar ui method
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _today = focusedDay;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, CubitState>(
      bloc: appCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          resizeToAvoidBottomInset: false,
          appBar: _buildCalenderAppbar(),
          body: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              setState(() {
                if (notification.direction == ScrollDirection.forward) {
                  _isFabVisible = true;
                }
                if (notification.direction == ScrollDirection.reverse) {
                  _isFabVisible = false;
                }
              });
              return true;
            },
            child: SafeArea(
              child: BlocBuilder<CalendarBloc, CalendarState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Card(
                        child: TableCalendar(
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: _today,
                          calendarFormat: CalendarFormat.month,
                          headerStyle: const HeaderStyle(
                            titleCentered: true,
                            formatButtonVisible: false,
                          ),
                          availableGestures: AvailableGestures.all,
                          calendarStyle: CalendarStyle(
                            canMarkersOverflow: true,
                            todayDecoration: FuncUtils.calenderDecoration(
                              AppColors.mainColor.withOpacity(0.2),
                            ),
                            todayTextStyle:
                                FuncUtils.dayTextStyle(AppColors.blackColor),
                            selectedDecoration: FuncUtils.calenderDecoration(
                              AppColors.mainColor,
                            ),
                            markersMaxCount: 1,
                            markerSize: 10,
                            markerDecoration: FuncUtils.calenderDecoration(
                              AppColors.markColor,
                            ),
                            selectedTextStyle:
                                FuncUtils.dayTextStyle(AppColors.whiteColor),
                          ),
                          selectedDayPredicate: (day) =>
                              isSameDay(day, _selectedDay),
                          onDaySelected: _onDaySelected,
                          onPageChanged: (focusedDay) =>
                              appCubit.onChanged(focusedDay),
                          eventLoader: (day) {
                            return (state is CalendarFetchDataFromHiveState)
                                ? getEventsByDay(state.events, day)
                                : [];
                          },
                        ),
                      ),
                      TabBarItems(tabController: _tabController),
                      if (state is CalendarFetchDataFromHiveState) ...[
                        Expanded(
                          child: TabBarViewContent(
                            _tabController,
                            _selectedDay,
                            state.events,
                          ),
                        )
                      ]
                    ],
                  );
                },
              ),
            ),
          ),
          floatingActionButton: Visibility(
            visible: _isFabVisible,
            child: FloatingActionButton(
              backgroundColor: AppColors.mainColor,
              onPressed: () => showModalBottomSheet(
                barrierColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return BlocProvider.value(
                    value: locator.get<CalendarBloc>(),
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddNewEventButtonsheet(
                        selectedDay: _selectedDay,
                      ),
                    ),
                  );
                },
              ).then((value) {
                context
                    .read<CalendarBloc>()
                    .add(CalendarFetchedDataFromHiveEvent());
              }),
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }

  AppBar _buildCalenderAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          const Text(
            'Calender',
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 26,
            ),
          ),
          const Spacer(),
          CircularPercentIndicator(
            radius: 24,
            lineWidth: 4,
            animation: true,
            animationDuration: 800,
            percent: 0.1,
            center: const Text(
              '10%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: AppColors.markColor,
          )
        ],
      ),
    );
  }
}

//tabBar tabs widget
class TabBarItems extends StatelessWidget {
  final TabController? tabController;

  const TabBarItems({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: 380,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: TabBar(
        controller: tabController,
        labelColor: AppColors.whiteColor,
        labelStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
        unselectedLabelColor: AppColors.blackColor.withOpacity(0.7),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.mainColor,
        ),
        indicatorPadding:
            const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        tabs: const [
          Text('Ongoing'),
          Text('Completed'),
        ],
      ),
    );
  }
}
