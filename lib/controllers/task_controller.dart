// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:project_calendar/controllers/calendar_controller.dart';
import 'package:project_calendar/controllers/employees_controller.dart';
import 'package:project_calendar/controllers/project_controller.dart';
import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/models/employee.dart';
import 'package:project_calendar/models/project.dart';
import 'package:project_calendar/models/task.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../network/task_network.dart';

class TaskController extends ChangeNotifier {
  List<List<int>> totalDuration = [];
  bool isLoading = false;
  List<Map<String, dynamic>> resizedTasks = [];
  Task? selectedTask;
  TaskNetwork taskNetwork = TaskNetwork();
  List<List<List<Task?>>> currentTasks = [];
  List<List<Task?>> myCurrentTasks = [];
  List<Task?> nonFoundTasks = [];
  List<String?> nonFoundColors = [];
  List<Task> tasks = [];

  resizeTasks() async {
    for (int i = 0; i < resizedTasks.length; i++) {
      int k = resizedTasks[i]["k"];
      int l = resizedTasks[i]["l"];
      int m = resizedTasks[i]["m"];
      int newDuration = resizedTasks[i]["newDuration"];
      currentTasks[k][l][m]!.duration = newDuration;
      Map<String, dynamic> data = currentTasks[k][l][m]!.toJson();
      data['duration'] = newDuration;
      await taskNetwork.editTask(
          id: currentTasks[k][l][m]!.id!.toString(), data: data);
      int index = tasks
          .indexWhere((element) => element.id == currentTasks[k][l][m]!.id!);
      tasks[index] = currentTasks[k][l][m]!;
    }
    notify();
    resizedTasks.clear();
  }

  addCalendarTask(int k, int l, context,
      {required Employee emp,
      required int priority,
      required project,
      required title,
      required description,
      required status,
      required Color color,
      required String duration,
      required DateTime? start,
      end}) async {
    EmployeesController empController =
        Provider.of<EmployeesController>(context, listen: false);

    List<Employee> employees = empController.employees;

    Employee employee = employees.firstWhere((element) => element.id == emp.id);

    String hexValue =
        color.value.toRadixString(16).padLeft(8, '0').toUpperCase();

    DateTime now = DateTime.now();

    DateTime startDate = DateTime(
        start!.year, start.month, start.day, now.hour, now.minute, now.second);

    int dur = int.parse(duration.split(' ')[0]);

    Task task = Task(
      color: hexValue,
      description: description,
      duration: dur,
      employee: emp,
      priority: priority,
      project: project,
      title: title,
      status: status,
      date: startDate,
    );

    Map<String, dynamic> data = task.toJson();

    addTask(data, task, k, l, employee, project);

    Navigator.pop(context);
  }

  duplicateCalendarTask(int k, int l, context,
      {required Employee emp,
      required Project project,
      required priority,
      required title,
      required description,
      required status,
      required Color color,
      required String duration,
      required DateTime? start,
      end}) async {
    String hexValue =
        color.value.toRadixString(16).padLeft(8, '0').toUpperCase();
    DateTime now = DateTime.now();
    DateTime startDate = DateTime(
        start!.year, start.month, start.day, now.hour, now.minute, now.second);

    int dur = int.parse(duration.split(' ')[0]);
    Task task = Task(
      color: hexValue,
      description: description,
      duration: dur,
      priority: priority,
      employee: emp,
      project: project,
      title: title,
      status: status,
      date: startDate,
    );
    Map<String, dynamic> data = task.toJson();
    duplicateTask(
      data,
      task,
      k,
      l,
    );
  }

  Future getTasks(context) async {
    tasks.clear();
    Response res = await taskNetwork.getTasks();
    for (int i = 0; i < res.data.length; i++) {
      Map<String, dynamic> data = res.data[i] as Map<String, dynamic>;
      Task task = Task.fromJson(data);
      tasks.add(task);
    }
    notifyListeners();
  }

  duplicateTask(
    data,
    Task task,
    k,
    int l,
  ) async {
    int nbr = l + 1;

    tasks.add(task);
    if (task.date!.weekday != 7) {
      while (currentTasks[k][nbr].isNotEmpty) {
        nbr++;
      }
      currentTasks[k][nbr].add(task);
    }
    task.date = task.date!.add(Duration(days: nbr - l));
    data['date'] = task.date!.year.toString() +
        '-' +
        task.date!.month.toString() +
        "-" +
        task.date!.day.toString();
    Response res = await taskNetwork.addTask(data);
    task.id = res.data['id'];
  }



 Future getMobileTasks(context,int employee,startDate,endDate) async {
    tasks.clear();
    Map<String,dynamic> data={
      "employee":employee,
      "start_date":startDate.year.toString()+"-"+startDate.month.toString()+"-"+startDate.day.toString(),
      "end_date":endDate.year.toString()+"-"+endDate.month.toString()+"-"+endDate.day.toString()
    };
    Response res = await taskNetwork.getTasksMobile(data);
    for (int i = 0; i < res.data.length; i++) {
      Map<String, dynamic> data = res.data[i] as Map<String, dynamic>;
      Task task = Task.fromJson(data);
      tasks.add(task);
    }
    notifyListeners();
  }

 

  addTask(data, Task task, k, l, employee, project) async {
    print(data);
    Response res = await taskNetwork.addTask(data);

    task.id = res.data['id'];
    tasks.add(task);
    currentTasks[k][l].add(task);
    notifyListeners();
  }

  getMultiCurrentWeekTasks(context) async {
    getTasks(context).then((value)  {
      totalDuration = [];
    List<Employee> employees =
        Provider.of<EmployeesController>(context, listen: false).employees;
    isLoading = true;
    List currentWeek =
        Provider.of<CalendarController>(context, listen: false).datesColumn;
    DateTime firstDate =
        DateTime.parse(gettingDateFromCalendar(currentWeek.first));
    DateTime lastDate =
        DateTime.parse(gettingDateFromCalendar(currentWeek.last));

    lastDate = lastDate.add(const Duration(days: 1));
    currentTasks = [];

    for (int i = 0; i < employees.length; i++) {
      currentTasks.add([]);
      totalDuration.add([]);
      for (int j = 0; j < 7; j++) {
        currentTasks[i].add([]);
      }
    }
    List<Task> tasksList = [];
    for (int i = 0; i < tasks.length; i++) {
      if ((tasks[i].date!.compareTo(firstDate) >= 0) &&
          (tasks[i].date!.compareTo(lastDate) < 0)) {
        tasksList.add(tasks[i]);
      }
    }
    for (int i = 0; i < tasksList.length; i++) {
      int j = employees
          .indexWhere((element) => element.id == tasksList[i].employee!.id);
      int dayIndex = tasksList[i].date!.weekday - 1;
      currentTasks[j][dayIndex].add(tasksList[i]);
    }
    notifyListeners();
    for (int i = 0; i < currentTasks.length; i++) {
      for (int j = 0; j < currentTasks[i].length; j++) {
        currentTasks[i][j].sort((a, b) => a!.priority!.compareTo(b!.priority!));
      }
    }
    notifyListeners();
    
    });
      // print(currentTasks);
    
    isLoading = false;

  }

getMyMultiCurrentWeekTasks(context) async {
  myCurrentTasks.clear();
  List currentWeek =
        Provider.of<CalendarController>(context, listen: false).datesColumn;
    DateTime firstDate =
        DateTime.parse(gettingDateFromCalendar(currentWeek.first));
    DateTime lastDate =
        DateTime.parse(gettingDateFromCalendar(currentWeek.last));
  int empId=Provider.of<UserController>(context, listen: false).currentEmployee.id!;
    getMobileTasks(context,empId,firstDate,lastDate).then((value)  {
      // print('got tasks');
      totalDuration = [];
    // List<Employee> employees =
    //     Provider.of<EmployeesController>(context, listen: false).employees;
    isLoading = true;
    
        
    
    

    lastDate = lastDate.add(const Duration(days: 1));
    // print('got week');
    myCurrentTasks = [];

    // for (int i = 0; i < employees.length; i++) {
    //   currentTasks.add([]);
    //   totalDuration.add([]);
      for (int j = 0; j < 7; j++) {
        myCurrentTasks.add([]);
      }
      // print(myCurrentTasks);
    // }
    List<Task> tasksList = tasks;
    // for (int i = 0; i < tasks.length; i++) {
    //   if ((tasks[i].date!.compareTo(firstDate) >= 0) &&
    //       (tasks[i].date!.compareTo(lastDate) < 0)&&(tasks[i].employee!.id==empId)) {
    //     tasksList.add(tasks[i]);
    //   }
    // }
    // print(tasksList);
    for (int i = 0; i < tasksList.length; i++) {
      // int j = employees
      //     .indexWhere((element) => element.id == tasksList[i].employee!.id);
      // print(tasksList[i].date!.weekday);
      int dayIndex = tasksList[i].date!.weekday - 1;
      myCurrentTasks[dayIndex].add(tasksList[i]);
    }
    notifyListeners();
    for (int i = 0; i < myCurrentTasks.length; i++) {
      
        myCurrentTasks[i].sort((a, b) => a!.priority!.compareTo(b!.priority!));
      
    }
    notifyListeners();
    
    });
    // print('aaaa');
      // print(myCurrentTasks);
    
    isLoading = false;

  }


  Color getTextColor(Color color) {
  int d = 0;

  // Counting the perceptive luminance - human eye favors green color...
  double luminance =
      (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

  if (luminance > 0.5) {
    d = 0; // bright colors - black font
  } else {
    d = 255; // dark colors - white font
  }

  Color textColor= Color.fromARGB(color.alpha, d, d, d);
  print(textColor);
  return textColor;
}
  

  duplicate({required int k, required int l, required int m, context}) {
    Task? task = currentTasks[k][l][m];
    duplicateCalendarTask(k, l, context,
        priority: task!.priority,
        emp: task.employee!,
        color: Color(int.parse(task.color!, radix: 16)),
        duration: '8 hours',
        project: task.project!,
        title: task.title,
        description: task.description,
        status: task.status,
        start: task.date!);
  }

  gettingDateFromCalendar(String date) {
    String firstYear = date.split(',')[2].trim();
    String firstMonth = date.split(',')[1].trim().split(' ')[1];
    String firstday = date.split(',')[1].trim().split(' ')[0];
    if (int.parse(firstday) < 10) {
      firstday = '0$firstday';
    }
    if (firstMonth == 'Jan') {
      firstMonth = '01';
    } else if (firstMonth == "Feb") {
      firstMonth = "02";
    } else if (firstMonth == "Mar") {
      firstMonth = "03";
    } else if (firstMonth == "Apr") {
      firstMonth = "04";
    } else if (firstMonth == "May") {
      firstMonth = "05";
    } else if (firstMonth == "Jun") {
      firstMonth = "06";
    } else if (firstMonth == "Jul") {
      firstMonth = "07";
    } else if (firstMonth == "Aug") {
      firstMonth = "08";
    } else if (firstMonth == "Sep") {
      firstMonth = "09";
    } else if (firstMonth == "Oct") {
      firstMonth = "10";
    } else if (firstMonth == "Nov") {
      firstMonth = "11";
    } else if (firstMonth == "Dec") {
      firstMonth = "12";
    }

    return '$firstYear-$firstMonth-$firstday';
  }

  deleteTask(int id, context) async {
    await taskNetwork.deleteTask(id.toString());
    int taskIndex = tasks.indexWhere((element) => id == element.id);
    bool found = false;
    for (int i = 0; i < currentTasks.length; i++) {
      if (found) {
        break;
      }
      for (int j = 0; j < currentTasks[i].length; j++) {
        if (found) {
          break;
        }
        for (int k = 0; k < currentTasks[i][j].length; k++) {
          if (currentTasks[i][j][k]!.id == id) {
            currentTasks[i][j].removeAt(k);
            notifyListeners();
            found = true;
            break;
          }
          if (found) {
            break;
          }
        }
      }
    }
    tasks.removeAt(taskIndex);


    Navigator.pop(context);
    notifyListeners();
    // final snackBar = SnackBar(
    //   elevation: 0,
    //   behavior: SnackBarBehavior.floating,
    //   backgroundColor: Colors.transparent,
    //   content: AwesomeSnackbarContent(
    //     title: 'Success!',
    //     message: 'Task succussfully deleted.',
    //     contentType: ContentType.success,
    //   ),
    // );
    // ScaffoldMessenger.of(context)
    //   ..hideCurrentSnackBar()
    //   ..showSnackBar(snackBar);
  }

  duplicateVerticalTask(
      data, Task task, k, l, employee, project, context, i, m) async {
    EmployeesController empController =
        Provider.of<EmployeesController>(context, listen: false);

    task.employee = empController.employees[k];
    Map<String, dynamic> mapData = task.toJson();
    int index = tasks.indexWhere((element) => element.id == task.id);
    Response res = await taskNetwork.addTask(mapData);

    tasks[index] = Task.fromJson(res.data);

    currentTasks[k][l].add(tasks[index]);

    await taskNetwork.deleteTask(task.id.toString());
    currentTasks[i][l].removeAt(m);
    notifyListeners();
  }

  duplicateHorizontalTask(
      data, Task task, k, l, employee, project, context, i, m, days) async {
    currentTasks[k][i][m]!.date =
        currentTasks[k][i][m]!.date!.add(Duration(days: days));
    Map<String, dynamic> mapData = currentTasks[k][i][m]!.toJson();
    int index =
        tasks.indexWhere((element) => element.id == currentTasks[k][i][m]!.id);
    Response res = await taskNetwork.addTask(mapData);
    Task newTask = Task.fromJson(res.data);
    newTask.id=res.data['id'];
    tasks[index] = newTask;
    currentTasks[k][l].add(newTask);
    await taskNetwork.deleteTask(task.id.toString());
    currentTasks[k][i].removeAt(m);
    notifyListeners();
  }

  editTask(k, l, m, context,
      {required int id,
      required int priority,
      required String title,
      required String duration,
      required int empId,
      required int projectId,
      required String status,
      required String description,
      required DateTime start,
      required Color color}) async {
    int i = tasks.indexWhere((element) => element.id == id);
    Task task = tasks[i];
    EmployeesController empController =
        Provider.of<EmployeesController>(context, listen: false);

    ProjectController proController =
        Provider.of<ProjectController>(context, listen: false);

    task.status = status;
    task.duration = int.parse(duration.split(' ')[0]);
    task.date = start;
    task.title = title;
    task.description = description;
    task.employee =
        empController.employees.firstWhere((element) => element.id == empId);
    task.project =
        proController.projects.firstWhere((element) => element.id == projectId);
    task.priority = priority;
    String hexValue =
        color.value.toRadixString(16).padLeft(8, '0').toUpperCase();
    task.color = hexValue;
    tasks[i] = task;
    currentTasks[k][l][m] = task;
    Map<String, dynamic> data = task.toJson();
    await taskNetwork.editTask(id: id.toString(), data: data);

    notifyListeners();
  }

  clearSearch(keywordController) {
    if (nonFoundTasks.isNotEmpty) {
      keywordController.text = "";
      for (int l = 0; l < nonFoundColors.length; l++) {
        bool found = false;
        for (int i = 0; i < currentTasks.length; i++) {
          for (int j = 0; j < currentTasks[i].length; j++) {
            for (int k = 0; k < currentTasks[i][j].length; k++) {
              if (currentTasks[i][j][k]!.id == nonFoundTasks[l]!.id) {
                currentTasks[i][j][k]!.color = nonFoundColors[l];
                found = true;
                break;
              }
            }
            if (found == true) {
              break;
            }
          }
          if (found == true) {
            break;
          }
        }
      }
      nonFoundTasks.clear();
      nonFoundColors.clear();
      notify();
    }
  }

  searchTasks(String keyword, keywordController) {
    clearSearch(keywordController);
    for (int i = 0; i < currentTasks.length; i++) {
      for (int j = 0; j < currentTasks[i].length; j++) {
        for (int k = 0; k < currentTasks[i][j].length; k++) {
          if (currentTasks[i][j][k]!
              .title!
              .toUpperCase()
              .contains(keyword.toUpperCase())) {
            // //notifylisteners();
          } else {
            nonFoundTasks.add(currentTasks[i][j][k]);
            nonFoundColors.add(currentTasks[i][j][k]!.color);
            currentTasks[i][j][k]!.color = 'ff52514e';
          }
        }
      }
    }
    keywordController.text = "";
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }
}
