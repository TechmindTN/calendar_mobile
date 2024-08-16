import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  ThemeClass themeClass=ThemeClass();
  late UserController userController;
  @override
  void initState() {
     userController=Provider.of<UserController>(context,listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: themeClass.backgroundColor,
      titlePadding: EdgeInsets.zero,
      title: Container(
        height: 8.h,
        decoration:  BoxDecoration(
            color: themeClass.primaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 1.5.w, top: 2.5.h),
              child: Text(
                "Logout",
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
      actionsPadding: EdgeInsets.only(bottom: 2.h, top: 2.h),
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
                'Cancel',
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
                'Confirm',
                style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(color: Colors.white)),
              ),
              onPressed: () {
                userController.logout(context);
              },
            ),
          ],
        ),
      ],
      content: SizedBox(
        width: 20.w,
        height: 10.h,
        child: Center(
          child: Text(
            "Are you sure you want to log out?",
            style: GoogleFonts.ubuntu(
                textStyle: const TextStyle(color: Colors.black)),
          ),
        ),
      ),
    );
  }
}
