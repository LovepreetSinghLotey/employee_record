import 'package:employee_record/main_app.dart';
import 'package:employee_record/utils/date_time_ext.dart';
import 'package:employee_record/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';

/// Created by lovepreetsingh on 03,April,2025

enum SelectedType { today, nextMonday, nextTuesday, afterOneWeek, nodate, none }

class CustomDatePickerDialog extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final bool selectingStartDate;

  const CustomDatePickerDialog(
    this.startDate,
    this.endDate,
    this.selectingStartDate, {
    super.key,
  });

  @override
  State<CustomDatePickerDialog> createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  int increment = 0;
  DateTime? date;
  SelectedType selectedType = SelectedType.nextMonday;

  @override
  void initState() {
    if (!widget.selectingStartDate) {
      selectedType = SelectedType.nodate;
    }
    if (selectedType == SelectedType.nextMonday) {
      date = DateTime.now().next(DateTime.monday);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Wrap(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                widget.selectingStartDate
                    ? Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                        left: 16,
                        right: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: "Today",
                              color:
                                  selectedType == SelectedType.today
                                      ? Theme.of(context).colorScheme.buttonBlue
                                      : Theme.of(context).colorScheme.aliceBlue,
                              textColor:
                                  selectedType == SelectedType.today
                                      ? Colors.white
                                      : Theme.of(
                                        context,
                                      ).colorScheme.buttonBlue,
                              onPressed: () {
                                setState(() {
                                  date = DateTime.now();
                                  selectedType = SelectedType.today;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                              onPressed: () {
                                setState(() {
                                  date = DateTime.now().next(DateTime.monday);
                                  selectedType = SelectedType.nextMonday;
                                });
                              },
                              text: "Next Monday",
                              color:
                                  selectedType == SelectedType.nextMonday
                                      ? Theme.of(context).colorScheme.buttonBlue
                                      : Theme.of(context).colorScheme.aliceBlue,
                              textColor:
                                  selectedType == SelectedType.nextMonday
                                      ? Colors.white
                                      : Theme.of(
                                        context,
                                      ).colorScheme.buttonBlue,
                            ),
                          ),
                        ],
                      ),
                    )
                    : Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                        left: 16,
                        right: 16,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: () {
                                setState(() {
                                  date = null;
                                  selectedType = SelectedType.nodate;
                                });
                              },
                              text: "No date",
                              color:
                                  selectedType == SelectedType.nodate
                                      ? Theme.of(context).colorScheme.buttonBlue
                                      : Theme.of(context).colorScheme.aliceBlue,
                              textColor:
                                  selectedType == SelectedType.nodate
                                      ? Colors.white
                                      : Theme.of(
                                        context,
                                      ).colorScheme.buttonBlue,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                              onPressed: () {
                                setState(() {
                                  date = DateTime.now();
                                  selectedType = SelectedType.today;
                                });
                              },
                              text: "Today",
                              color:
                                  selectedType == SelectedType.today
                                      ? Theme.of(context).colorScheme.buttonBlue
                                      : Theme.of(context).colorScheme.aliceBlue,
                              textColor:
                                  selectedType == SelectedType.today
                                      ? Colors.white
                                      : Theme.of(
                                        context,
                                      ).colorScheme.buttonBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                const SizedBox(height: 16),
                widget.selectingStartDate
                    ? Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: () {
                                setState(() {
                                  date = DateTime.now().next(DateTime.tuesday);
                                  selectedType = SelectedType.nextTuesday;
                                });
                              },
                              text: "Next Tuesday",
                              color:
                                  selectedType == SelectedType.nextTuesday
                                      ? Theme.of(context).colorScheme.buttonBlue
                                      : Theme.of(context).colorScheme.aliceBlue,
                              textColor:
                                  selectedType == SelectedType.nextTuesday
                                      ? Colors.white
                                      : Theme.of(
                                        context,
                                      ).colorScheme.buttonBlue,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: CustomButton(
                              onPressed: () {
                                setState(() {
                                  date = DateTime.now().add(
                                    const Duration(days: 7),
                                  );
                                  selectedType = SelectedType.afterOneWeek;
                                });
                              },
                              text: "After 1 week",
                              color:
                                  selectedType == SelectedType.afterOneWeek
                                      ? Theme.of(context).colorScheme.buttonBlue
                                      : Theme.of(context).colorScheme.aliceBlue,
                              textColor:
                                  selectedType == SelectedType.afterOneWeek
                                      ? Colors.white
                                      : Theme.of(
                                        context,
                                      ).colorScheme.buttonBlue,
                            ),
                          ),
                        ],
                      ),
                    )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: TableCalendar(
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarStyle: const CalendarStyle(
                      weekNumberTextStyle: TextStyle(fontSize: 10),
                      markersMaxCount: 1,
                      selectedTextStyle: TextStyle(color: Colors.white),
                      selectedDecoration: BoxDecoration(
                        color: Color.fromRGBO(29, 161, 242, 1),
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: TextStyle(
                        color: Color.fromRGBO(29, 161, 242, 1),
                      ),
                      todayDecoration: BoxDecoration(color: Colors.transparent),
                    ),
                    onDaySelected: (date, value) {
                      setState(() {
                        this.date = date;
                        if (date.isSameDate(DateTime.now())) {
                          selectedType = SelectedType.today;
                        } else if (date.isSameDate(
                          DateTime.now().next(DateTime.monday),
                        )) {
                          selectedType = SelectedType.nextMonday;
                        } else if (date.isSameDate(
                          DateTime.now().next(DateTime.tuesday),
                        )) {
                          selectedType = SelectedType.nextTuesday;
                        } else if (date.isSameDate(
                          DateTime.now().add(const Duration(days: 7)),
                        )) {
                          selectedType = SelectedType.afterOneWeek;
                        } else {
                          selectedType = SelectedType.none;
                        }
                      });
                    },
                    firstDay: DateTime.now().subtract(
                      const Duration(days: 365 * 100),
                    ),
                    lastDay: DateTime.now().add(const Duration(days: 365)),
                    focusedDay: date ?? DateTime.now(),
                    currentDay: DateTime.now(),
                    selectedDayPredicate: (day) {
                      if (date != null) {
                        if (day.isSameDate(date!)) {
                          return true;
                        }
                      }
                      return false;
                    },
                  ),
                ),
                const Divider(height: 0.5),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                    left: 16,
                    right: 16,
                    bottom: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/date.svg",
                              width: 20,
                              height: 23,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              date != null ? date!.formatDate() : "No date",
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomButton(
                        text: "Cancel",
                        color: Theme.of(context).colorScheme.aliceBlue,
                        textColor: Theme.of(context).colorScheme.buttonBlue,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 16),
                      CustomButton(
                        text: "Save",
                        color: Theme.of(context).colorScheme.buttonBlue,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop(date);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
