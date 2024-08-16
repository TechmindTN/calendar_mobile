// ignore_for_file: use_build_context_synchronously

import 'package:project_calendar/controllers/employees_controller.dart';
import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/screens/employee/dialogs/add_employee_dialog.dart';
import 'package:project_calendar/screens/employee/dialogs/edit_employee_dialog.dart';
import 'package:project_calendar/screens/employee/toolbar_employee_list.dart';
import 'package:project_calendar/screens/employee/dialogs/confirm_delete_employee_dialog.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_table/table_sticky_headers.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../widgets/employee/activate_button.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  ThemeClass themeClass = ThemeClass();
  // ignore: non_constant_identifier_names
  List<String> ColumnTitles = [
    'N°',
    'Name',
    'Department',
    'Role',
    'Status',
    'Actions'
  ];
  // ignore: non_constant_identifier_names
  List<String> RowTitles = ['', '', '', '', '', '', '', ''];
  late EmployeesController empController;
  late UserController userController;

  @override
  void initState() {
    empController = Provider.of<EmployeesController>(context, listen: false);
    userController = Provider.of<UserController>(context, listen: false);
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    await empController.getEmployees(context);
    await empController.getDepartments(context);
    super.didChangeDependencies();
  }

  @override
  Future<void> dispose() async {
    await empController.initEmployees(context);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeClass.backgroundColor,
      padding: EdgeInsets.only(right: 3.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EmployeeListToolbar(empController: empController),
          Container(
            padding: EdgeInsets.only(top: 3.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60.w,
                ),
                SizedBox(
                  width: 29.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: themeClass.primaryColor,
                            fixedSize: Size(6.w, 5.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        child: const Text('Add'),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: ((context) =>
                                  const AddEmployeeDialog()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Consumer<EmployeesController>(
              builder: (context, empController, child) {
            return (empController.employees.isNotEmpty)
                ? SizedBox(
                    width: 100.w,
                    height: 70.h,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: StickyHeadersTable(
                        columnsTitleBuilder: (int columnIndex) {
                          return Container(
                              decoration: BoxDecoration(
                                color: themeClass.primaryColor,
                              ),
                              width: 15.15.w,
                              height: 9.h,
                              child: Center(
                                  child: Text(
                                ColumnTitles[columnIndex],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              )));
                        },
                        contentCellBuilder: (int columnIndex, int rowIndex) {
                          String txt = '';
                          if (columnIndex == 0) {
                            txt = rowIndex.toString();
                            return Container(
                                color: (rowIndex % 2 == 0)
                                    ? Colors.white
                                    : Colors.grey.shade300,
                                width: 15.15.w,
                                height: 9.h,
                                child: Center(
                                    child: Text(
                                  txt,
                                  textAlign: TextAlign.center,
                                )));
                          } else if (columnIndex == 1) {
                            txt = empController.employees[rowIndex].name
                                .toString();
                            return Container(
                                color: (rowIndex % 2 == 0)
                                    ? Colors.white
                                    : Colors.grey.shade300,
                                width: 15.15.w,
                                height: 9.h,
                                child: Center(
                                    child: SelectableText(
                                  txt,
                                  textAlign: TextAlign.center,
                                )));
                          } else if (columnIndex == 2) {
                            txt = empController
                                .employees[rowIndex].department!.name
                                .toString();
                            return Container(
                                color: (rowIndex % 2 == 0)
                                    ? Colors.white
                                    : Colors.grey.shade300,
                                width: 15.15.w,
                                height: 9.h,
                                child: Center(
                                    child: SelectableText(
                                  txt,
                                  textAlign: TextAlign.center,
                                )));
                          } else if (columnIndex == 3) {
                            return Consumer<UserController>(
                                builder: (context, userController, child) {
                              return Container(
                                  color: (rowIndex % 2 == 0)
                                      ? Colors.white
                                      : Colors.grey.shade300,
                                  width: 15.15.w,
                                  height: 9.h,
                                  child: Center(
                                      child: Text(
                                    (empController.employees[rowIndex].user!
                                                .isSuperuser ==
                                            true)
                                        ? 'Admin'
                                        : 'Employee',
                                    textAlign: TextAlign.center,
                                  )));
                            });
                          } else if (columnIndex == 4) {
                            txt = (empController
                                        .employees[rowIndex].user!.isActive ==
                                    true)
                                ? "Active"
                                : "Inactive";
                            return Container(
                                color: (rowIndex % 2 == 0)
                                    ? Colors.white
                                    : Colors.grey.shade300,
                                width: 15.15.w,
                                height: 9.h,
                                child: Center(
                                  child: ActivateButton(
                                    txt: txt,
                                    rowIndex: rowIndex,
                                    empController: empController,
                                  ),
                                ));
                          } else {
                            return Container(
                              color: (rowIndex % 2 == 0)
                                  ? Colors.white
                                  : Colors.grey.shade300,
                              width: 15.15.w,
                              height: 9.h,
                              child: Row(
                                mainAxisAlignment:
                                    (userController.currentUser.isSuperuser ==
                                            true)
                                        ? MainAxisAlignment.spaceEvenly
                                        : MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 5, 101, 180),
                                        fixedSize: Size(3.w, 4.h),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                    child: const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.white,
                                    ),
                                  ),
                                  (userController.currentUser.isSuperuser ==
                                          true)
                                      ? ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return EditEmployeeDialog(
                                                      emp: empController
                                                          .employees[rowIndex]);
                                                });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 194, 122, 7),
                                              fixedSize: Size(3.w, 4.h),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const SizedBox(),
                                  (userController.currentUser.isSuperuser ==
                                          true)
                                      ? ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return ConfirmDeleteEmployeeDialog(
                                                    title: 'Delete Employee',
                                                    content:
                                                        'Are you sure you want to delete this employee',
                                                    rowIndex: rowIndex,
                                                  );
                                                });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 200, 24, 11),
                                              fixedSize: Size(3.w, 4.h),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            );
                          }
                        },
                        columnsLength: ColumnTitles.length,
                        rowsLength: empController.employees.length,
                        rowsTitleBuilder: (int rowIndex) {
                          return SizedBox(
                            width: 0.w,
                            height: 9.h,
                          );
                        },
                        cellDimensions: CellDimensions.fixed(
                            contentCellWidth: 15.24.w,
                            contentCellHeight: 9.h,
                            stickyLegendWidth: 2.5.w,
                            stickyLegendHeight: 9.h),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          })
        ],
      ),
    );
  }
}
