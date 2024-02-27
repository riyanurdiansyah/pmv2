import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pman/src/entities/project_task_date.dart';
import 'package:pman/src/presentation/controllers/event_controller.dart';
import 'package:pman/src/presentation/views/loading_page.dart';
import 'package:pman/src/utils/common/app_common.dart';
import 'package:table_calendar/table_calendar.dart';

class EventIndicator extends StatelessWidget {
  final List events;

  const EventIndicator(this.events, {super.key});

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return const SizedBox();
    }
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red, // Customize the color of the indicator
      ),
      width: 8,
      height: 8,
    );
  }
}

class EventPage extends StatelessWidget {
  EventPage({super.key});

  final _eC = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Obx(
          () => AppText.labelW600(
            DateFormat("MMMM yyyy").format(_eC.focusedDay.value),
            16,
            Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Obx(() {
            if (_eC.isLoading.value) {
              return SizedBox(
                height: size.height / 1.5,
                child: const LoadingPage(),
              );
            }
            return SizedBox(
              height: 280,
              child: TableCalendar(
                currentDay: DateTime.now(),
                focusedDay: _eC.focusedDay.value,
                firstDay: DateTime.now().subtract(
                  const Duration(
                    days: 90,
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                  weekendStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
                lastDay: DateTime.now().add(
                  const Duration(
                    days: 365,
                  ),
                ),
                headerVisible: false,
                selectedDayPredicate: _eC.onSelectedDayPredicate,
                onDaySelected: _eC.onChangeSelectedDay,
                onPageChanged: _eC.onChangeFocusedDay,
                eventLoader: _eC.getEvents,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarFormat: CalendarFormat.month,
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, data) {
                    final list = (data as List<ProjectTaskDateObjData>)
                        .where((e) => e.color.toLowerCase() != "green");
                    if (list.isEmpty) {
                      return null;
                    }
                    return Positioned(
                      right: 10,
                      top: 10,
                      child: Container(
                        alignment: Alignment.center,
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: AppText.labelBold(
                          list.length.toString(),
                          11,
                          Colors.white,
                        ),
                      ),
                    );
                  },
                  todayBuilder: (_, day, dday) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorAccent.withOpacity(0.6),
                        ),
                        child: AppText.labelW600(
                          day.day.toString(),
                          16,
                          Colors.white,
                        ),
                      ),
                    );
                  },
                  dowBuilder: (context, day) {
                    final text = DateFormat.E().format(day);

                    if (day.weekday == DateTime.sunday ||
                        day.weekday == DateTime.saturday) {
                      return Center(
                        child: AppText.labelW600(
                          text,
                          14,
                          Colors.red,
                        ),
                      );
                    }
                    return Center(
                      child: AppText.labelW600(
                        text,
                        14,
                        Colors.black,
                      ),
                    );
                  },
                ),
              ),
            );
          }),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: Obx(
              () => SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    _eC.getEvents(_eC.selectedDay.value).length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: DateTime.parse(_eC
                                      .getEvents(_eC.selectedDay.value)[index]
                                      .end)
                                  .isBefore(DateTime.now())
                              ? Colors.red
                              : _eC
                                          .getEvents(
                                              _eC.selectedDay.value)[index]
                                          .color ==
                                      "green"
                                  ? colorPrimaryDark
                                  : Colors.black45,
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 10),
                      width: double.infinity,
                      child: AppText.labelW500(
                        _eC.getEvents(_eC.selectedDay.value)[index].title,
                        14,
                        DateTime.parse(_eC
                                    .getEvents(_eC.selectedDay.value)[index]
                                    .end)
                                .isBefore(DateTime.now())
                            ? Colors.red
                            : _eC
                                        .getEvents(_eC.selectedDay.value)[index]
                                        .color ==
                                    "green"
                                ? colorPrimaryDark
                                : Colors.black45,
                        height: 1.25,
                        maxLines: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
