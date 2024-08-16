import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:project_calendar/controllers/task_controller.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ConfirmDeleteTaskDialog extends StatefulWidget {
  final String title;
  final String content;
  const ConfirmDeleteTaskDialog({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<ConfirmDeleteTaskDialog> createState() =>
      _ConfirmDeleteTaskDialogState();
}

class _ConfirmDeleteTaskDialogState extends State<ConfirmDeleteTaskDialog> {
  late TaskController taskController;
  ThemeClass themeClass = ThemeClass();
  @override
  void initState() {
    taskController = Provider.of<TaskController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: themeClass.backgroundColor,
      titlePadding: EdgeInsets.zero,
      title: Container(
        height: 6.h,
        decoration: BoxDecoration(
            color: themeClass.primaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 1.5.w, ),
              child: Text(
                widget.title,
                style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(color: Colors.white)),
              ),
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
                
                 taskController.deleteTask(taskController.selectedTask!.id!,context);
                                    Navigator.pop(context);
                                    final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Congratulations!',
                          message: 'You have succesfully deleted this task.',
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
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //       side: BorderSide.none,
            //       backgroundColor: themeClass.primaryColor,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(5.0))),
            //   child: Text(
            //     "Confirm",
            //     style: GoogleFonts.ubuntu(
            //         textStyle: const TextStyle(color: Colors.white)),
            //   ),
            //   onPressed: () async {
          
            //     taskController.deleteTask(
            //         taskController.selectedTask!.id!, context);
            //     Navigator.pop(context);
            //     final snackBar = SnackBar(
            //       elevation: 0,
            //       behavior: SnackBarBehavior.floating,
            //       backgroundColor: Colors.transparent,
            //       content: AwesomeSnackbarContent(
            //         title: 'Congratulations!',
            //         message: 'You have succesfully deleted this task.',
            //         contentType: ContentType.success,
            //       ),
            //     );
            //     ScaffoldMessenger.of(context)
            //       ..hideCurrentSnackBar()
            //       ..showSnackBar(snackBar);
            //   },
            // ),
          ],
        );
    
  }
}
