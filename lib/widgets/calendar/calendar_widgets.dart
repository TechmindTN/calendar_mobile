import 'package:project_calendar/controllers/device_controller.dart';
import 'package:project_calendar/models/employee.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:project_calendar/widgets/perma_tasks/perma_tasks_list_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/calendar_controller.dart';

// ignore: must_be_immutable
class CalendarDayItem extends StatelessWidget {
  ThemeClass themeClass = ThemeClass();
  final int i;
  final CalendarController calendarController;
  final DeviceController deviceController;

  CalendarDayItem(
      {super.key,
      required this.i,
      required this.calendarController,
      required this.deviceController});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          border: Border.all(
            width: 2,
            color: themeClass.outlineColor,
          ),
          color: themeClass.primaryColor),
      width: (deviceController.device == "Desktop") ? 12.2.w : 60.w,
      height: 30.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SelectableText(
            calendarController.datesColumn[i],
            style: const TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 1.h,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "1h",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "2h",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "3h",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "4h",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "5h",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "6h",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "7h",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "8h",
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class EmpRowWidget extends StatelessWidget {
  ThemeClass themeClass = ThemeClass();
  final Employee employee;
  final String empName;
  final int index;

   EmpRowWidget({super.key, required this.empName, required this.index, required this.employee,
    });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 
      13.w
      ,
      height: 5.h,

      decoration: BoxDecoration(
        color: themeClass.primaryColor,
        borderRadius: (index==0)?const BorderRadius.only(topLeft: Radius.circular(5)):const BorderRadius.only(topLeft: Radius.circular(0)),
      ),
      child: Center(child: FittedBox(
        fit: BoxFit.fitWidth,
        child: SizedBox(
          width: 13.w,
          child: Padding(
            padding: const EdgeInsets.only(left:12.0),
            child: Row(
              mainAxisAlignment: (empName!="")?MainAxisAlignment.start:MainAxisAlignment.center,
              children: [
                if(empName!="")
                const SizedBox(),
                  
                SizedBox(
                  width: (empName!="")?8.5.w:9.w,
                  child: Text(empName,style: const TextStyle(color: Colors.white,
                  fontSize: 24
                  ),),
                ),
                if(empName!="")
                Padding(
                  padding: const EdgeInsets.only(right:12.0),
                  child: IconButton(onPressed: (){
                    
                    showDialog(context: context, builder: (context){
                      return PermmaTaskListDialog(employee: employee,);
                
                    });
                  }, icon: const Icon(Icons.list_alt,
                  size: 40,
                  color: Colors.white,
                  )),
                  
                ),
                  if(empName!="")SizedBox(width:0.5.w)
              ],
            ),
          ),
        ))));
  }
}
