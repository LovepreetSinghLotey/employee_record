import 'package:employee_record/bloc/employee_bloc.dart';
import 'package:employee_record/main_app.dart';
import 'package:employee_record/model/employee.dart';
import 'package:employee_record/utils/date_time_ext.dart';
import 'package:employee_record/widgets/custom_button.dart';
import 'package:employee_record/widgets/custom_date_picker_dialog.dart';
import 'package:employee_record/widgets/header.dart';
import 'package:employee_record/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Created by lovepreetsingh on 02,April,2025

class AddEditScreen extends StatefulWidget {
  final Employee? employee;
  const AddEditScreen(this.employee, {super.key});

  static Route route({Employee? employee}) {
    return MaterialPageRoute(builder: (_) => AddEditScreen(employee));
  }

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  late EmployeeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<EmployeeBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.employee != null) {
        _nameController.text = widget.employee!.name;
        _roleController.text = widget.employee!.designation;
        _bloc.startDate = widget.employee!.startDate;
        _startDateController.text = widget.employee!.startDate.formatDate();
        if (widget.employee?.endDate != null) {
          _bloc.endDate = widget.employee!.endDate;
          _endDateController.text = widget.employee!.endDate!.formatDate();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(
          widget.employee == null
              ? "Add Employee Details"
              : "Edit Employee Details",
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.buttonBlue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InputFieldWidget(
                _nameController,
                prefixIcon: "assets/svg/person.svg",
                hintText: "Employee name",
              ),
            ),
            const SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () => _showRoleSheet(),
                child: InputFieldWidget(
                  _roleController,
                  enabled: false,
                  prefixIcon: "assets/svg/job.svg",
                  hintText: "Job type",
                  suffixIcon: "assets/svg/arrow_drop.svg",
                ),
              ),
            ),
            const SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _choseDate(true),
                      child: InputFieldWidget(
                        _startDateController,
                        enabled: false,
                        prefixIcon: "assets/svg/date.svg",
                        hintText: "Start date",
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SvgPicture.asset("assets/svg/arrow_right.svg"),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _choseDate(false),
                      child: InputFieldWidget(
                        enabled: false,
                        _endDateController,
                        prefixIcon: "assets/svg/date.svg",
                        hintText: "End date",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Divider(
              height: 1,
              thickness: 0,
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  text: "Cancel",
                  color: Theme.of(context).colorScheme.aliceBlue,
                  textColor: Theme.of(context).colorScheme.buttonBlue,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 8),
                CustomButton(
                  text: "Save",
                  color: Theme.of(context).colorScheme.buttonBlue,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_isValidated()) {
                      _bloc.add(
                        SaveEmployee(
                          Employee(
                            widget.employee == null
                                ? UniqueKey().hashCode
                                : widget.employee!.id,
                            _nameController.text,
                            _roleController.text,
                            _bloc.startDate!,
                            endDate: _bloc.endDate,
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }

  bool _isValidated() {
    if (_nameController.text.isEmpty) {
      _showError("Please enter the name of employee!");
      return false;
    }
    if (_nameController.text.isEmpty) {
      _showError("Please choose a role!");
      return false;
    }
    if (_startDateController.text.isEmpty) {
      _showError("Please choose a starting date!");
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: TextStyle(fontSize: 12))),
    );
  }

  Future _showRoleSheet() async => await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: _bloc.roles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: SizedBox(
                  height: 52,
                  child: Center(
                    child: Text(
                      _bloc.roles[index],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () {
                  _roleController.text = _bloc.roles[index];
                  Navigator.pop(context);
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(height: 0.5);
            },
          ),
        ],
      );
    },
  );

  void _choseDate(bool chooseStartDate) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDatePickerDialog(
        _bloc.startDate,
        _bloc.endDate,
        chooseStartDate,
      );
    },
  ).then((value) {
    DateTime? date = value as DateTime?;
    if (chooseStartDate && date != null) {
      _bloc.startDate = date;
      _startDateController.text = date.formatDate();
    } else {
      if (date == null) {
        //current employee
        _bloc.endDate = date;
        _endDateController.text = "No date";
      } else {
        //previous employee
        _bloc.endDate = date;
        _endDateController.text = date.formatDate();
      }
    }
  });
}
