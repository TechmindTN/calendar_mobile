import 'package:project_calendar/controllers/device_controller.dart';
import 'package:project_calendar/controllers/employees_controller.dart';
import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/screens/calendar/dialogs/add_task_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/task_controller.dart';

class EmptyTask extends StatelessWidget {
  final int k;
  final int l;
  final TaskController taskController;
  final UserController userController;
  final DeviceController deviceController;
  final EmployeesController empController;
  final int duration;

  const EmptyTask(
      {super.key,
      required this.k,
      required this.l,
      required this.taskController,
      required this.empController,
      required this.duration,
      required this.userController,
      required this.deviceController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if ((userController.currentUser.isSuperuser == true) &&
            (deviceController.device == 'Desktop')) {
              if(empController.employees[k].name!=null){
                showDialog(
              context: context,
              builder: (context) =>
                  AddTaskDialog(k: k, l: l, totalDuration: duration));
              }
          
        }
      },
      child: Center(
        child: SizedBox(
          height: 10.h,
          width: (deviceController.device == 'Desktop')
              ? duration * 1.5.w
              : duration * 4.w,
          child: const Row(
            children: [],
          ),
        ),
      ),
    );
  }
}
