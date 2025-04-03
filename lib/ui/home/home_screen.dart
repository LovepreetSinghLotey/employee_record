import 'package:employee_record/bloc/employee_bloc.dart';
import 'package:employee_record/main_app.dart';
import 'package:employee_record/model/employee.dart';
import 'package:employee_record/ui/add_edit/add_edit_screen.dart';
import 'package:employee_record/ui/home/employee_list_item.dart';
import 'package:employee_record/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Created by lovepreetsingh on 02,April,2025

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late EmployeeBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<EmployeeBloc>(context);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.add(SetupEmployeeListener());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.platinum,
      appBar: AppBar(
        title: Header("Employee List"),
        backgroundColor: Theme.of(context).colorScheme.buttonBlue,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.buttonBlue,
        onPressed: () {
          Navigator.of(context).push(AddEditScreen.route());
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: SafeArea(
        child: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            Map<EmployeeType, List<Employee>> employees =
                (state as EmployeeInitial).employees;
            return employees.values.every((list) => list.isEmpty)
                ? _noRecord()
                : _employeeList(employees);
          },
        ),
      ),
    );
  }

  Widget _employeeList(Map<EmployeeType, List<Employee>> data) {
    return CustomScrollView(
      shrinkWrap: true,
      primary: true,
      slivers: [
        ...data.entries.expand(
              (entry) => [
            SliverAppBar(
              pinned: false,
              primary: false,
              floating: false,
              flexibleSpace: Container(
                height: 56,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                color: Theme.of(context).colorScheme.platinum,
                child: Text(
                  entry.key.stringValue,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.buttonBlue,
                  ),
                ),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 108.0,
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final employee = entry.value[index];
                  return Dismissible(
                    key: Key(employee.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      _bloc.add(DeleteEmployee(employee));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 5),
                          content: Text("Employee data has been deleted"),
                          action: SnackBarAction(
                            label: "Undo",
                            onPressed: () {
                              _bloc.add(UndoDeleteEmployee());
                            },
                          ),
                        ),
                      );
                    },
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.of(
                          context,
                        ).push(AddEditScreen.route(employee: employee));
                      },
                      child: EmployeeListItem(employee),
                    ),
                  );
                },
                childCount: entry.value.length,
              ),
            ),
          ],
        ),
        // "Swipe left to delete" message appears only once at the bottom
        if (data.values.any((list) => list.isNotEmpty)) // Show only if there are employees
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Swipe left to delete",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.spanishGray,
                ),
              ),
            ),
          ),
      ],
    );
  }


  Widget _noRecord() => Container(
    width: double.infinity,
    height: double.infinity,
    alignment: Alignment.center,
    child: Image.asset(
      "assets/images/no_record.png",
      width: 261.79,
      fit: BoxFit.fitWidth,
    ),
  );
}
