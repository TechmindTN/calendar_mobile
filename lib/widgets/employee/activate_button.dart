import 'package:project_calendar/controllers/employees_controller.dart';
import 'package:project_calendar/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ActivateButton extends StatefulWidget {
  const ActivateButton({
    super.key,
    required this.txt,
    required this.rowIndex,
    required this.empController,
  });
  final int rowIndex;
  final EmployeesController empController;
  final String txt;

  @override
  // ignore: no_logic_in_create_state
  State<ActivateButton> createState() =>
      _ActivateButtonState(rowIndex, empController);
}

class _ActivateButtonState extends State<ActivateButton> {
  final int rowIndex;
  final EmployeesController empController;
  late UserController userController;
  _ActivateButtonState(this.rowIndex, this.empController);

  @override
  void initState() {
    userController = Provider.of<UserController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (userController.currentUser.isSuperuser == true) {
          // userController.userActivation(
          //     empController.employees[rowIndex].user!.id!,
          //     empController.employees[rowIndex].user!,
          //     context,
          //     rowIndex);
          // empController.employees[rowIndex].user!.isActive =
          //     (empController.employees[rowIndex].user!.isActive == true)
          //         ? false
          //         : true;
          // empController.notify();
          // userController.notify();
        }
      },
      child: Consumer<EmployeesController>(
          builder: (context, empController, child) {
        return Container(
          decoration: BoxDecoration(
              color: (empController.employees[rowIndex].user!.isActive == true)
                  ? const Color.fromARGB(255, 4, 124, 8)
                  : const Color.fromARGB(255, 200, 24, 11),
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(2, 3),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ]),
          width: 5.w,
          height: 4.h,
          child: Center(
            child: Text(
              widget.txt,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }),
    );
  }
}
