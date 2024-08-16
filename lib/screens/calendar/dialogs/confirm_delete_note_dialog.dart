import 'package:project_calendar/controllers/note_controller.dart';
import 'package:project_calendar/controllers/task_controller.dart';
import 'package:project_calendar/models/note.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ConfirmDeleteNoteDialog extends StatefulWidget {
  final String title;
  final String content;
  final Note note;
  final NoteController noteController;
  const ConfirmDeleteNoteDialog({
    super.key,
    required this.title,
    required this.content, required this.note, required this.noteController,
  });

  @override
  State<ConfirmDeleteNoteDialog> createState() =>
      _ConfirmDeleteNoteDialogState(note: note,noteController: noteController);
}

class _ConfirmDeleteNoteDialogState extends State<ConfirmDeleteNoteDialog> {
    final Note note;
  final NoteController noteController;
  late TaskController taskController;
  ThemeClass themeClass = ThemeClass();

  _ConfirmDeleteNoteDialogState({required this.note, required this.noteController});
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
        height: 8.h,
        decoration: BoxDecoration(
            color: themeClass.primaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        child: Padding(
          padding: EdgeInsets.only(left: 1.5.w, top: 2.5.h),
          child: Text(
            widget.title,
            style: GoogleFonts.ubuntu(
                textStyle: const TextStyle(color: Colors.white)),
          ),
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
                
                noteController.deleteNote(
                    note.id!);
                Navigator.pop(context);
              //   final snackBar = SnackBar(
              //     elevation: 0,
              //     behavior: SnackBarBehavior.floating,
              //     backgroundColor: Colors.transparent,
              //     content: AwesomeSnackbarContent(
              //       title: 'Congratulations!',
              //       message: 'You have succesfully deleted this task.',
              //       contentType: ContentType.success,
              //     ),
              //   );
              //   ScaffoldMessenger.of(context)
              //     ..hideCurrentSnackBar()
              //     ..showSnackBar(snackBar);
              },
            ),
          ],
        ),
      ],
    );
  }
}
