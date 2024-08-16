import 'package:project_calendar/controllers/calendar_controller.dart';
import 'package:project_calendar/controllers/device_controller.dart';
import 'package:project_calendar/controllers/task_controller.dart';
import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/calendar/calendar_widget.dart';
import '../../widgets/calendar/toolbar_widgets.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  ThemeClass themeClass = ThemeClass();
  late CalendarController calendarController;
    late TaskController taskController;
 late Future myFuture;
  late UserController userController;
  late DeviceController deviceController;

  @override
  void initState() {
    calendarController =
        Provider.of<CalendarController>(context, listen: false);
        taskController =
        Provider.of<TaskController>(context, listen: false);
        
    calendarController.getCurrentWeek(date: calendarController.currentday);
    userController = Provider.of<UserController>(context, listen: false);
    deviceController = Provider.of<DeviceController>(context, listen: false);

    super.initState();
  }

  
  @override
  void didChangeDependencies() {
    myFuture=taskController.getMyMultiCurrentWeekTasks(context);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarController>(
        builder: (context, calendarController, child) {
      return Consumer<TaskController>(
        builder: (context,taskController,child) {
          print(taskController.myCurrentTasks);
          return Scaffold(
              backgroundColor: themeClass.backgroundColor,
              body: FutureBuilder(
                future: myFuture,
                builder: (context,snapshot) {
                  if(snapshot.connectionState==ConnectionState.done){
                    return SizedBox(
                    height: 100.h,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text(taskController.myCurrentTasks[0].length.toString()),
                        // Text(taskController.myCurrentTasks[1].length.toString()),
                        // Text(taskController.myCurrentTasks[2].length.toString()),
                        // Text(taskController.myCurrentTasks[3].length.toString()),
                        // Text(taskController.myCurrentTasks[4].length.toString()),
                        // Text(taskController.myCurrentTasks[5].length.toString()),
                        // Text(taskController.myCurrentTasks[6].length.toString()),
                        Toolbar(
                          calendarController: calendarController,
                        ),
                        SizedBox(height: 1.h,),
                         const CalendarWidget(),
                      ],
                    ),
                  );
                  }
                  else if(snapshot.connectionState==ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator());
                  }
                  else{
                    return const Center(
                     child: Text("There is a problem")
                    );
                  }
                  
                }
              ),
              // floatingActionButton:
              //     // (
              //       (userController.currentUser.isSuperuser == true) 
              //     // &&
              //     //         (deviceController.device == "Desktop"))
              //         ? FloatingButton(
                      
              //             calendarController: calendarController,
              //           )
              //         : const SizedBox()
              );
        }
      );
    });
  }
}
