import 'package:employee_record/main_app.dart';
import 'package:employee_record/model/employee.dart';
import 'package:employee_record/utils/date_time_ext.dart';
import 'package:flutter/material.dart';

/// Created by lovepreetsingh on 02,April,2025
class EmployeeListItem extends StatelessWidget {
  final Employee employee;
  const EmployeeListItem(this.employee, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.jet,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  employee.designation,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.spanishGray,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _getDate(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.spanishGray,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.platinum,
            height: 0,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  String _getDate() {
    if (employee.endDate == null) return employee.startDate.formatDate();
    return "${employee.startDate.formatDate()} - ${employee.endDate!.formatDate()}";
  }
}
