import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:project_calendar/controllers/employees_controller.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ConfirmDeleteEmployeeDialog extends StatefulWidget {
  final String title;
  final String content;
  final int rowIndex;

  const ConfirmDeleteEmployeeDialog({
    super.key,
    required this.title,
    required this.content,
    required this.rowIndex,
  });

  @override
  State<ConfirmDeleteEmployeeDialog> createState() =>
      _ConfirmDeleteEmployeeDialogState();
}

class _ConfirmDeleteEmployeeDialogState
    extends State<ConfirmDeleteEmployeeDialog> {
  late EmployeesController empController;
  ThemeClass themeClass = ThemeClass();
  @override
  void initState() {
    empController = Provider.of<EmployeesController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: themeClass.backgroundColor,
      titlePadding: EdgeInsets.zero,
      title: Container(
        height: 8.h,
        decoration: BoxDecoration(
            color: themeClass.primaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 1.5.w, top: 2.5.h),
              child: Text(
                widget.title,
                style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(color: Colors.white)),
              ),
            ),
             Padding(
                  padding:  EdgeInsets.only(right: 1.5.w, top: 1.h),
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
      content: Text(widget.content),
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
              child: Text(
                "Cancel",
                style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(color: Colors.white)),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  side: BorderSide.none,
                  backgroundColor: themeClass.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              child: Text(
                "Confirm",
                style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(color: Colors.white)),
              ),
              onPressed: () async {
                empController.deleteEmployee(
                    empController.employees[widget.rowIndex].id.toString(),
                    context,
                    widget.rowIndex);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Congratulations!',
                    message:
                        'You have succesfully deleted this employee!!! \n Please note that you\'ll lose any tasks connected to this employee',
                    contentType: ContentType.success,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              },
            ),
          ],
        ),
      ],
    );
  }
}
