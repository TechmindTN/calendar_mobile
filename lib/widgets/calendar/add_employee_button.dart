import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import '../../screens/employee/dialogs/add_employee_dialog.dart';

// ignore: must_be_immutable
class AddEmployeeButton extends StatelessWidget {
  AddEmployeeButton({super.key});

  ThemeClass themeClass = ThemeClass();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: themeClass.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      child: const Text("Add employee"),
      onPressed: () {
        showDialog(
            context: context, builder: (context) => const AddEmployeeDialog());
      },
    );
  }
}
