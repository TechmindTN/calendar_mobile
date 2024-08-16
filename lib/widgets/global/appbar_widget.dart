
import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: non_constant_identifier_names
PreferredSizeWidget MyAppBar(UserController userController,context) {
  // final UserController userController;
  ThemeClass themeClass = ThemeClass();
  return AppBar(
      backgroundColor: themeClass.primaryColor,
      title: Text(
        'Calendar Project',
        style: GoogleFonts.ubuntu(),
      ),
      centerTitle: false,
      actions:  [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: InkWell(
            onTap: () {
              // userController.logout(context);
            },
            child: const CircleAvatar(
                backgroundColor: Colors.white, child: Icon(Icons.person)),
          ),
        ),
      ]);
}
