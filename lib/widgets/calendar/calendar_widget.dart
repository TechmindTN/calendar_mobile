import 'package:project_calendar/controllers/calendar_controller.dart';
import 'package:project_calendar/controllers/device_controller.dart';
import 'package:project_calendar/controllers/employees_controller.dart';
import 'package:project_calendar/controllers/project_controller.dart';
import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:project_calendar/widgets/calendar/bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/task_controller.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  ThemeClass themeClass = ThemeClass();
  late CalendarController calendarController;
  late EmployeesController employeesController;
  late TaskController taskController;
  late UserController userController;
  late ProjectController proController;
  late DeviceController deviceController;

  List<int> numbers = [0, 1, 2, 3, 4];
  final ScrollController _horizontal = ScrollController(),
      _vertical = ScrollController();
  final double _scrollOffsetX = 0.0;
  final double _scrollOffsetY = 0.0;
  

  @override
  void initState() {
    calendarController =
        Provider.of<CalendarController>(context, listen: false);
    employeesController =
        Provider.of<EmployeesController>(context, listen: false);
    taskController = Provider.of<TaskController>(context, listen: false);
    proController = Provider.of<ProjectController>(context, listen: false);
    userController = Provider.of<UserController>(context, listen: false);
    deviceController = Provider.of<DeviceController>(context, listen: false);
    // if(employeesController.employeesRow.length<14)
    // employeesController.initEmployees(context);
    taskController.isLoading = true;
    // taskController.getMyMultiCurrentWeekTasks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(
      builder: (context,taskController,child) {
        return SizedBox(
          height: 60.h,
          width: 100.w,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [ 
              SizedBox(width: 2.w,),
              const SideTimeWidget(),
                  SizedBox(width: 2.w,),
              MyCalendarWidget(taskController: taskController,),
            ],
          ),
        );
        // (taskController.isLoading==false)?
        // Container(
        //   color: themeClass.backgroundColor,
        //   width: (deviceController.device=="Desktop")?100.w:200.w,
        //       height: (deviceController.device=="Desktop")?82.h:70.h,
        //     child: Consumer<CalendarController>(
        //       builder: (context,calendarController,child) {
        //         return Consumer<EmployeesController>(
        //           builder: (context,employeesController,child) {
        //             return SizedBox(
        //               width: (deviceController.device=="Desktop")?121.w:242,
        //               height: 82.h,
        //               child: Padding(
        //                 padding:  (deviceController.device=="Desktop")?const EdgeInsets.all(16):const EdgeInsets.all(0),
        //                  child: (taskController.currentTasks.isNotEmpty)?
        //                  StickyHeadersTable(
                          
        //                   // legendCell: ((userController.currentUser.isSuperuser==true)&&(deviceController.device=="Desktop"))?AddEmployeeButton():const SizedBox(),
        //   initialScrollOffsetX: _scrollOffsetX,
        //   initialScrollOffsetY: _scrollOffsetY,
        //   scrollControllers: ScrollControllers(
        //             horizontalTitleController: _horizontal,
        //             verticalTitleController: _vertical,
        //   ),
        //  onEndScrolling: (scrollOffsetX, scrollOffsetY) {
        //   _scrollOffsetX = scrollOffsetX;
        //   _scrollOffsetY = scrollOffsetY;
        //  },
         

        //                 columnsLength: calendarController.datesColumn.length,
        //                 rowsLength: employeesController.employeesRow.length,
        //                 cellDimensions: CellDimensions.variableColumnWidthAndRowHeight(columnWidths: [(deviceController.device=="Desktop")?12.2.w:60.w,(deviceController.device=="Desktop")?12.2.w:60.w,(deviceController.device=="Desktop")?12.2.w:60.w,(deviceController.device=="Desktop")?12.2.w:60.w,(deviceController.device=="Desktop")?12.2.w:60.w,(deviceController.device=="Desktop")?12.2.w:60.w,(deviceController.device=="Desktop")?12.2.w:60.w,], rowHeights: employeesController.heights, stickyLegendWidth: (deviceController.device=="Desktop")?8.w:30.w, stickyLegendHeight: 10.h),
        //                 columnsTitleBuilder: (i) => CalendarDayItem(calendarController:calendarController,i: i,deviceController: deviceController,),
        //                 rowsTitleBuilder: (i) => employeesController.employeesRow[i],
        //                 contentCellBuilder: (k, l) { 
        //                   // return Text(taskController.currentTasks.length.toString());
        //                  List<Widget> contentList=[];
        //                   if(k<=7&&l<18) {
        //                   int totalDuration=0;
        //                   // ignore: prefer_is_empty
        //                   if(taskController.currentTasks[l][k].length!=0){
        //                     for(int i=0;i<taskController.currentTasks[l][k].length;i++){
        //                       contentList.add(
        //                         BarWidget(task: taskController.currentTasks[l][k][i]!, k: l, l: k,m:i)
        //                           );
        //                       totalDuration+=taskController.currentTasks[l][k][i]!.duration!;
        //                     }
        //                     taskController.totalDuration[l].add(totalDuration);
        //                     if(totalDuration<8){
        //                       contentList.add(
        //                         EmptyTask(k: l, l: k,empController: employeesController, taskController: taskController,duration:8-totalDuration,userController: userController,deviceController: deviceController,)
        //                           );
        //                     }
        //                   }
        //                   else{
        //                     contentList.add(
        //                       EmptyTask(k: l, l: k,empController: employeesController, taskController: taskController, duration: 8,userController: userController,deviceController: deviceController,)
        //                       );
        //                   }
        //                 }
        //                 else{
        //                   contentList.add(const SizedBox());
        //                 }
        //                   return Container(
        //                     height: 10.h, decoration:BoxDecoration(border: Border(left:BorderSide(width: 2,color: themeClass.outlineColor),top: const BorderSide(width: 2,color: Colors.black26))),
        //                     child: Stack(
        //                       children: [
        //                          Positioned(right: 0,child: Container(color: Colors.white,
        //                 width: (deviceController.device=="Desktop")?1.5.w:7.35.w,
        //                 height: 5.h,
        //                 ),
        //                 ),
        //                 Positioned(right: (deviceController.device=="Desktop")?1.5.w:7.35.w,child: Container(color:
        //                 themeClass.backgroundColor,
        //                 width: (deviceController.device=="Desktop")?1.5.w:7.35.w,
        //                 height: 5.h,
        //                 ),
        //                 ),
        //                 Positioned(right: (deviceController.device=="Desktop")?3.w:14.7.w,child: Container(color: Colors.white,
        //                 width:(deviceController.device=="Desktop")?1.5.w:7.35.w,
        //                 height: 5.h,
        //                 ),
        //                 ),
        //                 Positioned(right: (deviceController.device=="Desktop")?4.5.w:22.5.w,child: Container(color: 
        //                 themeClass.backgroundColor,
        //                 width: (deviceController.device=="Desktop")?1.5.w:7.35.w,
        //                 height: 5.h,
        //                 ),
        //                 ),
        //                 Positioned(right: (deviceController.device=="Desktop")?6.w:29.4.w,child: Container(color: Colors.white,
        //                 width: (deviceController.device=="Desktop")?1.5.w:7.35.w,
        //                 height: 5.h,
        //                 ),
        //                 ),
        //                 Positioned(right: (deviceController.device=="Desktop")?7.5.w:36.75.w,child: Container(color:
        //                 themeClass.backgroundColor,
        //                 width: (deviceController.device=="Desktop")?1.5.w:7.35.w,
        //                 height: 5.h,
        //                 ),
        //                 ),
        //                 Positioned(right: (deviceController.device=="Desktop")?9.w:44.1.w,child: Container(color: Colors.white,
        //                 width: (deviceController.device=="Desktop")?1.5.w:7.35.w,
        //                 height: 5.h,
        //                 ),
        //                 ),
        //                 Positioned(right: (deviceController.device=="Desktop")?10.5.w:51.45.w,child: Container(color:
        //                 themeClass.backgroundColor,
        //                 width: (deviceController.device=="Desktop")?1.5.w:7.35.w,
        //                 height: 5.h,
        //                 ),
        //                 ),
        //                         Row(
        //                           children: [
        //                           for (Widget content in contentList)
        //                           content
        //                         ],),
        //                       ],
        //                     ),
        //                   );
        // }  ):const Center(child: CircularProgressIndicator(),),       
        //               ),
        //             );
        //           }
        //         );
        //       }
        //     ),
        // );
        // :SizedBox(
        //   height: 80.h,
        //   child: const Center(child: CircularProgressIndicator(
        //     color: Color(0xff478CF3),
        //   )));
      }
    );
  }
}

class MyCalendarWidget extends StatelessWidget {
  List<int> daysHolder=List.generate(7, (index) => index);
  List<int> holder=List.generate(8, (index) => index);
 final TaskController taskController;
   MyCalendarWidget({
    super.key, required this.taskController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 60.h,
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white
        
      ) ,
      child: Consumer<TaskController>(
        builder: (context,taskController,child) {
          return Stack(
            children: [
              
              Column(
                children: [
                  CalendarRowWidget(color: Colors.grey[300]!,),
                  const CalendarRowWidget(color: Colors.white,),
                  CalendarRowWidget(color: Colors.grey[300]!,),
                  const CalendarRowWidget(color: Colors.white),
                  CalendarRowWidget(color: Colors.grey[300]!,),
                  const CalendarRowWidget(color: Colors.white),
                  CalendarRowWidget(color: Colors.grey[300]!,),
                  const CalendarRowWidget(color: Colors.white),
                  
                ],
              ),
              // Row(
              //   children: [
              //     // Positioned(
              //     //   // left: 5,
              //     //   child: VerticalDivider(
              //     //       thickness: 5,
              //     //       color: Colors.red,
              //     //   ),
              //     // ),
              //     SizedBox(width:9.15.w),
              //      Positioned(
              //       // left: 5,
              //       child: VerticalDivider(
              //           thickness: 1,
              //           color: Colors.grey[400],
              //       ),
              //     ),
              //     SizedBox(width:7.6.w),
              //      Positioned(
              //       // left: 5,
              //       child: VerticalDivider(
              //           thickness: 1,
              //           color: Colors.grey[400],
              //       ),
              //     ),
              //     SizedBox(width:7.5.w),
              //      Positioned(
              //       // left: 5,
              //       child: VerticalDivider(
              //           thickness: 1,
              //           color: Colors.grey[400],
              //       ),
              //     ),
              //     SizedBox(width:7.5.w),
              //      Positioned(
              //       // left: 5,
              //       child: VerticalDivider(
              //           thickness: 1,
              //           color: Colors.grey[400],
              //       ),
              //     ),
              //     SizedBox(width:7.6.w),
              //      Positioned(
              //       // left: 5,
              //       child: VerticalDivider(
              //           thickness: 1,
              //           color: Colors.grey[400],
              //       ),
              //     ),
              //      SizedBox(width:7.5.w),
              //      Positioned(
              //       // left: 5,
              //       child: VerticalDivider(
              //           thickness: 1,
              //           color: Colors.grey[400],
              //       ),
              //     ),
                  
              //   ],
              // ),
              for (int i in daysHolder)
              Positioned(
                left: 11.4.w*i,
                child: SizedBox(
                  // color: Colors.red,
                  width: 11.w,
                  height: 60.h.h,
                  child: ListView.builder(
                   
                    itemCount: taskController.myCurrentTasks [i].length,
                    itemBuilder: ((context, index) {
                      // print("duration: "+taskController.myCurrentTasks[2][0]!.duration.toString());
                      // print('index: '+index.toString());
                    return BarWidget(task: taskController.myCurrentTasks[i][index]!, k: i, l: index, m: taskController.myCurrentTasks[i][index]!.duration!);
                  } )),
                ),
              )
              // for ( var l in taskController.myCurrentTasks) 
              //   for(int t in l)
              //   Text("data")
              // for (int j in daysHolder)
              // for (int i in holder)
              // Positioned(
              //   left: 11.4.w*j,
              //   top: 7.5.h*i,
              //   child:
              //   //  Text("data")
              //   BarWidget(task: taskController.myCurrentTasks[0][0]!, k: 4, l: 0, m: 1)
              //   ),
              
            ],
          );
        }
      ),
    
    );
  }
}

class CalendarRowWidget extends StatelessWidget {
  final Color color;

   const CalendarRowWidget({
    super.key, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.5.h,
    decoration:BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(4),
        bottom:  Radius.circular(4)
        ),
        color: color
      ) ,
      child: const Row(
        children: [
         
        ],
      ),
    );
  }
}

class SideTimeWidget extends StatelessWidget {
  const SideTimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 6.w,
        height: 60.h,
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white
        ) ,
        child: Column(
          children: [
            SideTimeItemWidget(time: "1h",color: Colors.grey[300]!,),
            const SideTimeItemWidget(time: "2h",color: Colors.white,),
            SideTimeItemWidget(time: "3h",color: Colors.grey[300]!,),
            const SideTimeItemWidget(time: "4h",color: Colors.white,),
            SideTimeItemWidget(time: "5h",color: Colors.grey[300]!,),
            const SideTimeItemWidget(time: "6h",color: Colors.white,),
            SideTimeItemWidget(time: "7h",color: Colors.grey[300]!,),
            const SideTimeItemWidget(time: "8h",color: Colors.white,),
            
          ],
        ),
        );
  }
}

class SideTimeItemWidget extends StatelessWidget {
  final Color color;
  final String time;
   const SideTimeItemWidget({
    super.key, required this.color, required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.5.h,
    decoration:BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4),
          bottom:  Radius.circular(4)
          ),
          color: color
        ) ,
      child: Center(child: Text(time),)
    );
  }
}
