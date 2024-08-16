import 'package:project_calendar/controllers/permatask_controller.dart';
import 'package:project_calendar/utils/theme.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ConfirmDeletePermataskDialog extends StatefulWidget {
  final String title;
  final String content;
  final int rowIndex;

  const ConfirmDeletePermataskDialog({
    super.key,
    required this.title,
    required this.content,
    required this.rowIndex,
  });

  @override
  State<ConfirmDeletePermataskDialog> createState() =>
      _ConfirmDeletePermataskDialogState();
}

class _ConfirmDeletePermataskDialogState
    extends State<ConfirmDeletePermataskDialog> {
  late PermataskController permataskController;
  ThemeClass themeClass = ThemeClass();

  @override
  void initState() {
    permataskController = Provider.of<PermataskController>(context, listen: false);
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 1.25.w,),
              child: Text(
                widget.title,
                style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(color: Colors.white)),
              ),
            ),
             Padding(
                  padding:  EdgeInsets.only(right: 1.25.w, ),
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
                permataskController.deletePermatask(
                  id:permataskController.permatasks[widget.rowIndex].id!,
                 context:context,
                   index:widget.rowIndex,
                );
                // Navigator.pop(context);
                // final snackBar = SnackBar(
                //   elevation: 0,
                //   behavior: SnackBarBehavior.floating,
                //   backgroundColor: Colors.transparent,
                //   content: AwesomeSnackbarContent(
                //     title: 'Congratulations!',
                //     message: 'You have succesfully deleted this permatask.',
                //     contentType: ContentType.success,
                //   ),
                // );
                // ScaffoldMessenger.of(context)
                //   ..hideCurrentSnackBar()
                //   ..showSnackBar(snackBar);
              },
            ),
          ],
        ),
      ],
    );
  }
}
