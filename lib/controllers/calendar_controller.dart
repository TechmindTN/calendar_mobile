import 'package:project_calendar/controllers/task_controller.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalendarController extends ChangeNotifier {
  List<String> datesColumn = [];
  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List<String> testingDays = [];
  bool isResizing = false;
  bool isDragging = false;
  bool canDrag = false;
  List<String> Months=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

 bool canResize=false;
 bool displayEditFAB=false;
  DateTime currentday=DateTime.now();
  DateTime latestDate=DateTime.now();
  
  getNextWeek(context,keywordController) async {
    TaskController taskController=Provider.of<TaskController>(context,listen: false);

    keywordController.text="";

    taskController.clearSearch(keywordController);
    currentday=currentday.add(const Duration(days: 7));
    getCurrentWeek(date:currentday);
    taskController.currentTasks.clear();
    await taskController.getMyMultiCurrentWeekTasks(context);
    canDrag=false;
    isDragging=false;
    isResizing=false;
    isDragging=false;
    notifyListeners();
    taskController.notify();
  }

  getPreviousWeek(context,keywordController) async {
    TaskController taskController=Provider.of<TaskController>(context,listen: false);

    keywordController.text="";
    
    taskController.clearSearch(keywordController);
    currentday=currentday.subtract(const Duration(days: 7));
    getCurrentWeek(date:currentday);
    taskController.currentTasks.clear();
    await taskController.getMyMultiCurrentWeekTasks(context);
    canDrag=false;
    isDragging=false;
    isResizing=false;
    isDragging=false;
    notifyListeners();
    taskController.notify();

  }

  getCurrentWeek({DateTime? date}) {
    if (testingDays.isNotEmpty) {
      testingDays.clear();
    }
    if (datesColumn.isNotEmpty) {
      datesColumn.clear();
    }
    DateTime nowDate;
    if (date == null) {
      nowDate = DateTime.now();
    } else {
      nowDate = date;
    }
    int today = nowDate.weekday;
    if (today == 1) {
      for (int i = 0; i < 7; i++) {
        testingDays.add(DateFormat('EEEE, d MMM, yyyy')
            .format(nowDate.add(Duration(days: i))));
      }
    } else if (today == 2) {
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 1))));
      for (int i = 0; i < 6; i++) {
        testingDays.add(DateFormat('EEEE, d MMM, yyyy')
            .format(nowDate.add(Duration(days: i))));
      }
    } else if (today == 3) {
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 2))));
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 1))));
      for (int i = 0; i < 5; i++) {
        testingDays.add(DateFormat('EEEE, d MMM, yyyy')
            .format(nowDate.add(Duration(days: i))));
      }
    } else if (today == 4) {
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 3))));
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 2))));
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 1))));
      for (int i = 0; i < 4; i++) {
        testingDays.add(DateFormat('EEEE, d MMM, yyyy')
            .format(nowDate.add(Duration(days: i))));
      }
    } else if (today == 5) {
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 4))));
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 3))));
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 2))));
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 1))));
      for (int i = 0; i < 3; i++) {
        testingDays.add(DateFormat('EEEE, d MMM, yyyy')
            .format(nowDate.add(Duration(days: i))));
      }
    } else if (today == 6) {
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 5))));
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 4))));
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 3))));
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 2))));
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 1))));
      for (int i = 0; i < 2; i++) {
        testingDays.add(DateFormat('EEEE, d MMM, yyyy')
            .format(nowDate.add(Duration(days: i))));
      }
    } else if (today == 7) {
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 6))));
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 5))));
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 4))));
      testingDays.add(DateFormat('EEEE, dd MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 3))));
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 2))));
      testingDays.add(DateFormat('EEEE, d MMM, yyyy')
          .format(nowDate.subtract(const Duration(days: 1))));
      testingDays.add(DateFormat('EEEE, d MMM, yyyy').format(nowDate));
    }
    datesColumn=testingDays;
  }    

  confirmEdit(context) async {
    if (canResize == true) {
      isResizing = false;
      canResize = false;
      await Provider.of<TaskController>(context, listen: false).resizeTasks();
      notifyListeners();
    }
  }

  startEdit() {
    canResize = true;
    isResizing = true;
    notifyListeners();
  }
  
   confirmDrag(context) async {
    if(canDrag==true){
    canDrag=false;

    notifyListeners();
    }
  }

  startDrag(){
    canDrag=true;
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }
}
