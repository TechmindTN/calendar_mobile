import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:project_calendar/models/department.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/employees_controller.dart';
import '../../../controllers/task_controller.dart';

class AddEmployeeDialog extends StatefulWidget {
  const AddEmployeeDialog({super.key});

  @override
  State<AddEmployeeDialog> createState() => _AddEmployeeDialogState();
}

class _AddEmployeeDialogState extends State<AddEmployeeDialog> {
  ThemeClass themeClass = ThemeClass();
  TextEditingController employeeTextController = TextEditingController();
  TextEditingController userTextController = TextEditingController();
  TextEditingController companyTextController = TextEditingController();
  TextEditingController psdTextController = TextEditingController();
  late EmployeesController empController;
  late TaskController taskController;
  int? selectedDepartmentValue;
  @override
  void initState() {
    empController = Provider.of<EmployeesController>(context, listen: false);
    taskController = Provider.of<TaskController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
          backgroundColor: themeClass.backgroundColor,
          title: Container(
            decoration: BoxDecoration(
                color: themeClass.primaryColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            height: 6.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 1.5.w,),
                  child: const Text("Add employee",
                      style: TextStyle(color: Colors.white)),
                ),
                 Padding(
                  padding:  EdgeInsets.only(right: 1.5.w,),
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.close,
                  color: Colors.white,
                  )),
                ),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.only(bottom: 1.h),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: BorderSide.none,
                        backgroundColor: themeClass.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: BorderSide.none,
                        backgroundColor: themeClass.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () {
                      Navigator.pop(context);
                      if ((employeeTextController.text == '') ||
                              (psdTextController.text == '') ||
                              (userTextController.text == '')
                          // ||
                          // (companyTextController.text == '')
                          ) {
                        final snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Error!',
                            message: 'Every field must be filled.',
                            contentType: ContentType.failure,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      } else {
                        empController.addEmployee(context, taskController,
                            username: userTextController.text,
                            password: psdTextController.text,
                            name: employeeTextController.text,
                            department: selectedDepartmentValue);
                        final snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Congratulations!',
                            message:
                                'You have succesfully added a new employee.',
                            contentType: ContentType.success,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }
                    },
                    child: const Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ],
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
              width: 30.w,
              height: 25.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Username:"),
                          SizedBox(
                              width: 10.w,
                              height: 5.h,
                              child: TextField(
                                controller: userTextController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 0.5.h, left: 0.7.w),
                                  filled: true,
                                  fillColor: const Color(0xffffffff),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                ),
                              ))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Password:"),
                          SizedBox(
                              width: 10.w,
                              height: 5.h,
                              child: TextField(
                                controller: psdTextController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 0.5.h, left: 0.7.w),
                                  filled: true,
                                  fillColor: const Color(0xffffffff),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Employee's name:"),
                          SizedBox(
                              width: 10.w,
                              height: 5.h,
                              child: TextField(
                                controller: employeeTextController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 0.5.h, left: 0.7.w),
                                  filled: true,
                                  fillColor: const Color(0xffffffff),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                ),
                              ))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Department:"),
                          SizedBox(
                            width: 10.w,
                            height: 5.h,
                            child: DropdownButton2<int>(
                              underline: const SizedBox(),
                              isExpanded: true,
                              hint: Padding(
                                padding:
                                    EdgeInsets.only(top: 0.3.h, left: 0.7.w),
                                child: Text(
                                  'Select the department...',
                                  style: GoogleFonts.ubuntu(
                                      textStyle:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ),
                              items: empController.departments
                                  .map((Department item) =>
                                      DropdownMenuItem<int>(
                                        value: item.id,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 0.5.w),
                                          child: Text(item.name!,
                                              style: GoogleFonts.ubuntu(
                                                  textStyle: const TextStyle(
                                                      color: Colors.black))),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedDepartmentValue,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedDepartmentValue = value!;
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white),
                                height: 5.h,
                                width: 18.w,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //     width: 10.w,
                          //     height: 5.h,
                          //     child: TextField(
                          //       controller: companyTextController,
                          //       decoration: InputDecoration(
                          //         contentPadding: EdgeInsets.only(
                          //             top: 0.5.h, left: 0.7.w),
                          //         filled: true,
                          //         fillColor:
                          //             const Color(0xffffffff),
                          //         border: const OutlineInputBorder(
                          //           borderSide: BorderSide(
                          //               width: 1,
                          //               color: Colors.black),
                          //         ),
                          //       ),
                          //     ))
                        ],
                      )
                    ],
                  ),
                ],
              ))),
    );
  }
}
