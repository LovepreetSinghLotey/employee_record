import 'package:realm/realm.dart';

/// Created by lovepreetsingh on 02,April,2025

part 'employee.realm.dart';

enum EmployeeType {
  current("Current employees"),
  previous("Previous employees");

  final String stringValue;
  const EmployeeType(this.stringValue);
}

@RealmModel()
class _Employee {
  @PrimaryKey()
  late int id;
  late String name;
  late String designation;
  late DateTime startDate;
  late DateTime? endDate;
}

/// Add JSON serialization in the generated `Employee` class
extension EmployeeJson on Employee {
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'designation': designation,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
    };
  }

  static Employee fromJson(Map<String, Object?> json) {
    return Employee(
      json['id'] as int,
      json['name'] as String,
      json['designation'] as String,
      DateTime.parse(json['startDate'] as String),
      endDate:
          json['endDate'] != null
              ? DateTime.parse(json['endDate'] as String)
              : null,
    );
  }
}
