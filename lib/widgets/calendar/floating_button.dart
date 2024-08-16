// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:project_calendar/controllers/calendar_controller.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final CalendarController calendarController;

  ThemeClass themeclass = ThemeClass();

  FloatingButton({super.key, required this.calendarController});
  @override
  Widget build(BuildContext context) {
    return AnimatedFloatingActionButton(
      
      fabButtons: [ResizeButton(calendarController: calendarController,),DragButton(calendarController: calendarController,)], animatedIconData: AnimatedIcons.menu_close,

    
    colorStartAnimation: themeclass.primaryColor,
    colorEndAnimation: Colors.red,
    );
  }
}

class ResizeButton extends StatefulWidget {
  final CalendarController calendarController;

  const ResizeButton({super.key, required this.calendarController});

  @override
  State<ResizeButton> createState() =>
      _ResizeButtonState(calendarController: calendarController);
}

class _ResizeButtonState extends State<ResizeButton> {
  final CalendarController calendarController;

  _ResizeButtonState({required this.calendarController});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (widget.calendarController.isResizing==true)?FloatingActionButton(
         heroTag: "btn1",
        onPressed: (){
            widget.calendarController.confirmEdit(context);
          },
          child: const Icon(Icons.check),
          ):FloatingActionButton(
             heroTag: "btn2",
            onPressed: (){
            if(calendarController.canDrag==false){
            widget.calendarController.startEdit();
            }
            else{
              final snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Dragging Active',
                                  message:
                                      'Please Confirm Or Cancel The Dragging Button First',
                                  contentType: ContentType.warning,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
            }
          },
          child: const Icon(Icons.compress),
          )
    );

  }
}

class DragButton extends StatefulWidget {
  final CalendarController calendarController;

  const DragButton({super.key, required this.calendarController});

  @override
  State<DragButton> createState() =>
      _DragButtonState(calendarController: calendarController);
}

class _DragButtonState extends State<DragButton> {
  final CalendarController calendarController;

  _DragButtonState({required this.calendarController});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (calendarController.canDrag==true)?FloatingActionButton(
         heroTag: "btn3",
         onPressed: (){

            calendarController.confirmDrag(context);
          },
          child: const Icon(Icons.check),
          ):FloatingActionButton(
             heroTag: "btn4",
            onPressed: (){

            if(calendarController.canResize==false){
            calendarController.startDrag();
            }
            else{
              final snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Resizing Active',
                                  message:
                                      'Please Confirm Or Cancel The Resizing Button First',
                                  contentType: ContentType.warning,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
            }
          },
          child: const Icon(Icons.open_with),
          )
    );

  }
}
