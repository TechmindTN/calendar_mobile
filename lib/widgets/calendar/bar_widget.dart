// ignore_for_file: prefer_const_constructors

import 'package:project_calendar/controllers/calendar_controller.dart';
import 'package:project_calendar/controllers/device_controller.dart';
import 'package:project_calendar/controllers/task_controller.dart';
import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/screens/calendar/dialogs/task_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/task.dart';

class BarWidget extends StatefulWidget {
  final int k;
  final int l;
  final int m;
  final Task task;

  const BarWidget(
      {super.key,
      required this.task,
      required this.k,
      required this.l,
      required this.m});

  @override
  // ignore: no_logic_in_create_state
  State<BarWidget> createState() => _BarWidgetState(task, k, l, m);
}

class _BarWidgetState extends State<BarWidget> {
  final int k;
  final int l;
  final int m;
  final Task task;
  double offsetX = 0;
  double offsetY = 0;
  // late Color textColor;
  double posX = 0;
  double posY = 0;
  late DeviceController deviceController;
  late TaskController taskController;
  late UserController userController;

  late CalendarController calendarController;
  double width = 0;
  _BarWidgetState(this.task, this.k, this.l, this.m);
  @override
  void initState() {
    deviceController = Provider.of<DeviceController>(context, listen: false);
    width = task.duration! *
        (((deviceController.device == "Desktop") ? 12.w : 59.4.w) / 8);
    taskController = Provider.of<TaskController>(context, listen: false);
    calendarController =
        Provider.of<CalendarController>(context, listen: false);
    userController = Provider.of<UserController>(context, listen: false);
        // textColor=taskController.getTextColor(Color(int.parse(taskController.selectedTask!.color!, radix: 16))
        //               .withOpacity(0.8),);

    super.initState();
  }

  panUpdate(DragUpdateDetails details) {
    setState(() {
      if ((width > 12.w / 8)) {
        width += details.delta.dx;
      } else {
        if (width <= 12.w / 8) {
          if (details.delta.dx >= 0) {
            width += details.delta.dx;
          }
        } else {
          if (details.delta.dx < 0) {
            width += details.delta.dx;
          }
        }
      }
    });
  }

  panEnd(DragEndDetails details,
      {required TaskController taskController,
      required int k,
      required int l,
      required int m}) {
    calendarController.isResizing = true;
    calendarController.notify();

    setState(() {
      if ((width > 12.w / 8) && (width < 2 * 12.w / 8)) {
        if ((2 * 12.w / 8) - width > width - (12.w / 8)) {
          width = 12.w / 8;
        } else {
          width = 2 * 12.w / 8;
        }
      } else if ((width > 2 * 12.w / 8) && (width < 3 * 12.w / 8)) {
        if ((3 * 12.w / 8) - width > width - (2 * 12.w / 8)) {
          width = 2 * 12.w / 8;
        } else {
          width = 3 * 12.w / 8;
        }
      } else if ((width > 3 * 12.w / 8) && (width < 4 * 12.w / 8)) {
        if ((4 * 12.w / 8) - width > width - (3 * 12.w / 8)) {
          width = 3 * 12.w / 8;
        } else {
          width = 4 * 12.w / 8;
        }
      } else if ((width > 4 * 12.w / 8) && (width < 5 * 12.w / 8)) {
        if ((5 * 12.w / 8) - width > width - (4 * 12.w / 8)) {
          width = 4 * 12.w / 8;
        } else {
          width = 5 * 12.w / 8;
        }
      } else if ((width > 5 * 12.w / 8) && (width < 6 * 12.w / 8)) {
        if ((6 * 12.w / 8) - width > width - (5 * 12.w / 8)) {
          width = 5 * 12.w / 8;
        } else {
          width = 6 * 12.w / 8;
        }
      } else if ((width > 6 * 12.w / 8) && (width < 7 * 12.w / 8)) {
        if ((7 * 12.w / 8) - width > width - (6 * 12.w / 8)) {
          width = 6 * 12.w / 8;
        } else {
          width = 7 * 12.w / 8;
        }
      } else if ((width > 7 * 12.w / 8) && (width < 8 * 12.w / 8)) {
        if ((8 * 12.w / 8) - width > width - (7 * 12.w / 8)) {
          width = 7 * 12.w / 8;
        } else {
          width = 12.w;
        }
      }
      if (taskController.currentTasks[k][l].length > 1) {
        if (width >
            12.w -
                taskController.totalDuration[k][l] * 12.w / 8 +
                task.duration! * 12.w / 8) {
          width = 12.w -
              taskController.totalDuration[k][l] * 12.w / 8 +
              task.duration! * 12.w / 8;
          taskController.duplicate(k: k, l: l, m: m, context: context);
        }
      } else {
        if (width > 12.w) {
          width = 12.w;
          taskController.duplicate(k: k, l: l, m: m, context: context);
        }
      }
    });
    Map<String, dynamic> data = {
      "k": k,
      "l": l,
      "m": m,
      "newDuration": width / (12.w / 8),
      "task": task
    };
    taskController.resizedTasks.add(data);
  }

  verticalPanEnd(DragEndDetails details) async {
    offsetY = posY;
    int empCounts = (offsetY / 5.h).round();

    int totalDuration = 0;
    for (int i = 0;
        i < taskController.currentTasks[k + empCounts][l].length;
        i++) {
      totalDuration +=
          taskController.currentTasks[k + empCounts][l][i]!.duration!;
    }
    if (empCounts != 0) {
      if (totalDuration + taskController.currentTasks[k][l][m]!.duration! <=
          8) {
        taskController.duplicateVerticalTask(
            taskController.currentTasks[k][l][m],
            taskController.currentTasks[k][l][m]!,
            k + empCounts,
            l,
            taskController.currentTasks[k][l][m]!.employee,
            taskController.currentTasks[k][l][m]!.project,
            context,
            k,
            m);
      } else {
        offsetY = 0;
      }
    } else {
      offsetY = 0;
    }
  }

  horizontalDragEnd(DragEndDetails details) {
    offsetX = posX;
    double x = offsetX;
    int daysCounts = 0;
    int otherDuration = 0;
    if (x.sign >= 0) {
      if (m == 0) {
        daysCounts = (x / 12.w).floor();
      } else {
        for (int i = m - 1; i >= 0; i--) {
          otherDuration += taskController.currentTasks[k][l][i]!.duration!;
        }
        daysCounts = ((x + ((12.w / 8) * otherDuration)) / 12.w).floor();
      }
    } else {
      if (m == 0) {
        daysCounts = daysCounts = (x / 12.w).floor();
      } else {
        for (int i = m - 1; i >= 0; i--) {
          otherDuration += taskController.currentTasks[k][l][i]!.duration!;
        }

        if (x.abs() > 12.w / 8 * otherDuration) {
          if (x.abs() < 12.w + 12.w / 8 * otherDuration) {
            daysCounts = -1;
          } else {
            daysCounts =
                ((x / 12.w) - (12.w / 8 * otherDuration) / 12.w).ceil();
          }
        }
      }
    }
    if (daysCounts != 0) {
      if (taskController.currentTasks[k][l + daysCounts].isEmpty) {
        taskController.duplicateHorizontalTask(
            taskController.currentTasks[k][l][m],
            taskController.currentTasks[k][l][m]!,
            k,
            l + daysCounts,
            taskController.currentTasks[k][l][m]!.employee,
            taskController.currentTasks[k][l][m]!.project,
            context,
            l,
            m,
            daysCounts);
      } else {
        int filledDuration = 0;
        for (int i = 0;
            i < taskController.currentTasks[k][l + daysCounts].length;
            i++) {
          filledDuration +=
              taskController.currentTasks[k][l + daysCounts][i]!.duration!;
        }
        if (taskController.currentTasks[k][l][m]!.duration! >
            8 - filledDuration) {
          offsetX = 0;
        } else {
          taskController.duplicateHorizontalTask(
              taskController.currentTasks[k][l][m],
              taskController.currentTasks[k][l][m]!,
              k,
              l + daysCounts,
              taskController.currentTasks[k][l][m]!.employee,
              taskController.currentTasks[k][l][m]!.project,
              context,
              l,
              m,
              daysCounts);
        }
      }
    } else {
      offsetX = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(task.duration);
    return InkWell(
      onTap: () {
          taskController.selectedTask = task;
              showDialog(
                  context: context,
                  builder: ((context) {
                    return TaskDetailDialog(
                      k: k,
                      l: l,
                      m: m,
                    );
                  }));
      },
      child: Container(
                  // duration: Duration(seconds: 1),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(-1, 4))
                    ],
                    color: Color(int.parse(widget.task.color!, radix: 16))
                        .withOpacity(0.8),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: 11.w,
                  height: 7.5.h*m,
                  child: SizedBox(
                    // width: width - 20,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Center(
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: FittedBox(
                                                  fit: BoxFit.fitHeight,
                                                  child: Text(
                            widget.task.title!,
                            style: const TextStyle(color: Colors.white),
                                                  ),
                                                ),
                          )),
                    ),
                  ),
                ),
    );
    // return Tooltip(
    //   message:"aaaa",
    //   //  taskController.currentTasks[k][l][m]!.project!.name,
    //   child: Transform.translate(
    //     offset: Offset(offsetX, offsetY),
    //     child: InkWell(
    //         onSecondaryTap: () {},
    //         onTap: () {
    //           taskController.selectedTask = task;
    //           showDialog(
    //               context: context,
    //               builder: ((context) {
    //                 return TaskDetailDialog(
    //                   k: k,
    //                   l: l,
    //                   m: m,
    //                 );
    //               }));
    //         },
    //         child: GestureDetector(
    //           dragStartBehavior: DragStartBehavior.start,
    //           onHorizontalDragUpdate: (details) {
    //             if (userController.currentUser.isSuperuser == true) {
    //               if (calendarController.canResize == true) {
    //                 panUpdate(details);
    //               } else {
    //                 if (calendarController.canDrag &&
    //                     calendarController.isDragging == true) {
    //                   offsetX += details.delta.dx;
    //                   posX = offsetX;
    //                   taskController.notify();
    //                   calendarController.notify();
    //                 }
    //               }
    //             }
    //           },
    //           onVerticalDragUpdate: (details) {
    //             if (userController.currentUser.isSuperuser == true) {
    //               if (calendarController.canDrag) {
    //                 offsetY += details.delta.dy;
    //                 posY = offsetY;
    //                 taskController.notify();
    //                 calendarController.notify();
    //               }
    //             }
    //           },
    //           onVerticalDragEnd: (details) {
    //             if (userController.currentUser.isSuperuser == true) {
    //               if (calendarController.canDrag) {
    //                 verticalPanEnd(details);
    //                 taskController.notify();
    //                 calendarController.notify();
    //               }
    //             }
    //           },
    //           onHorizontalDragEnd: (details) {
    //             if (userController.currentUser.isSuperuser == true) {
    //               if (calendarController.canResize == true) {
    //                 panEnd(details,
    //                     taskController: taskController, k: k, l: l, m: m);
    //               } else {
    //                 if (calendarController.canDrag) {
    //                   horizontalDragEnd(details);
    //                 }
    //               }
    //               taskController.notify();
    //               calendarController.notify();
    //             }
    //           },
    //           child: AnimatedContainer(
    //             duration: Duration(seconds: 1),
    //             decoration: BoxDecoration(
    //               boxShadow: const [
    //                 BoxShadow(
    //                     color: Colors.black26,
    //                     blurRadius: 6,
    //                     offset: Offset(-1, 4))
    //               ],
    //               color: Color(int.parse(widget.task.color!, radix: 16))
    //                   .withOpacity(0.8),
    //               borderRadius: BorderRadius.circular(5),
    //             ),
    //             width: 11.w,
    //             height: 7.5.h*m,
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 (calendarController.canDrag == true)
    //                     ? InkWell(
    //                         onTapDown: (details) {
    //                           calendarController.isDragging = true;
    //                           calendarController.notify();
    //                         },
    //                         onTapUp: (details) {
    //                           calendarController.isDragging = false;
    //                           calendarController.notify();
    //                         },
    //                         child: const Visibility(
    //                             child: Icon(
    //                           Icons.drag_indicator,
    //                         )))
    //                     : SizedBox(),
    //                 const Visibility(child: SizedBox()),
    //                 SizedBox(
    //                   // width: width - 20,
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(6.0),
    //                     child: Center(
    //                         child: RotatedBox(
    //                           quarterTurns: 1,
    //                           child: FittedBox(
    //                                                 fit: BoxFit.fitHeight,
    //                                                 child: Text(
    //                           widget.task.title!,
    //                           style: const TextStyle(color: Colors.white),
    //                                                 ),
    //                                               ),
    //                         )),
    //                   ),
    //                 ),
    //                 (calendarController.canResize == true)
    //                     ? const Visibility(child: Icon(Icons.arrow_right))
    //                     : SizedBox()
    //               ],
    //             ),
    //           ),
    //         )),
    //   ),
    // );
  }
}
