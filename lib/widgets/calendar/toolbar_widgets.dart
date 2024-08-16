import 'package:project_calendar/controllers/device_controller.dart';
import 'package:project_calendar/controllers/employees_controller.dart';
import 'package:project_calendar/controllers/task_controller.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/calendar_controller.dart';

class Toolbar extends StatefulWidget {
  final CalendarController calendarController;

  const Toolbar({super.key, required this.calendarController});
  @override
  // ignore: no_logic_in_create_state
  State<Toolbar> createState() => _ToolbarState(calendarController);
}

class _ToolbarState extends State<Toolbar> {
  late DeviceController deviceController;
  @override
  void initState() {
    empController = Provider.of<EmployeesController>(context, listen: false);
    taskController = Provider.of<TaskController>(context, listen: false);
    deviceController = Provider.of<DeviceController>(context, listen: false);
    super.initState();
  }

  late TaskController taskController;
  ThemeClass themeClass = ThemeClass();
  late EmployeesController empController;
  TextEditingController keywordController = TextEditingController();
  TextEditingController startingdateController = TextEditingController();
  TextEditingController endingdateController = TextEditingController();
  final CalendarController calendarController;
  
  String? stringValue;
  Widget? value;
DateFormat format = DateFormat("MMMM");
  _ToolbarState(this.calendarController);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 94.w,
      color: themeClass.backgroundColor,
      child: Column(
        children: [
          SizedBox(height:3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
            Container(
              height: 5.h,
              width: 25.w,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: themeClass.secondaryColor
                  ),
                  const BoxShadow(
                    color:Colors.white,
                    spreadRadius: -1,
                    offset: Offset(1, 2)
                  )
                ],

                borderRadius: BorderRadius.circular(4)

              ),
              child: Center(child: Text(calendarController.testingDays[0].split(" ")[2].split(",")[0].toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
              )),
            )
          ],),
              SizedBox(height: 3.h,),
          Container(
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await calendarController.getPreviousWeek(
                                      context, keywordController);
                                  calendarController.notify();
                  },
                  child: Container(
                    // width: 5.w,
                    height: 5.h,
                    child: const Icon(  Icons.arrow_back_ios,color: Colors.white,
                    size: 35,
                    ))),
                Container(
                  width: 80.w,
                  height: 7.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Row(
                    
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80.w,
                            child: Row(
                              
                              
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              SizedBox(
                                width: 10.w,
                                child: const Center(child: Text("Mon",style: TextStyle(
                                  fontSize: 13
                                ),))),
                             SizedBox(
                                width: 10.w,
                                child: const Center(child: Text("Tue"))),
                                SizedBox(
                                width: 10.w,
                                child: const Center(child: Text("Wed"))),
                                SizedBox(
                                width: 10.w,
                                child: const Center(child: Text("Thu"))),
                                SizedBox(
                                width: 10.w,
                                child: const Center(child: Text("Fri"))),
                                SizedBox(
                                width: 10.w,
                                child: const Center(child: Text("Sat"))),
                                SizedBox(
                                width: 10.w,
                                child: const Center(child: Text("Sun"))),
          
                              
                              
                            ],),
                          ),
                          const Text("------------------------------------------------------------------------"),
                          // Divider(
                          //   color: Colors.black,
                          //   thickness: 5,
                          // ),
                          SizedBox(
                            width: 80.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              SizedBox(
                                width: 10.w,
                                child: Center(child: Text(calendarController.datesColumn[0].split(" ")[1]))),
                              SizedBox(
                                width: 10.w,
                                child: Center(child: Text(calendarController.datesColumn[1].split(" ")[1]))),
                                SizedBox(
                                width: 10.w,
                                child: Center(child: Text(calendarController.datesColumn[2].split(" ")[1]))),
                                SizedBox(
                                width: 10.w,
                                child: Center(child: Text(calendarController.datesColumn[3].split(" ")[1]))),
                                SizedBox(
                                width: 10.w,
                                child: Center(child: Text(calendarController.datesColumn[4].split(" ")[1]))),
                                SizedBox(
                                width: 10.w,
                                child: Center(child: Text(calendarController.datesColumn[5].split(" ")[1]))),
                                SizedBox(
                                width: 10.w,
                                child: Center(child: Text(calendarController.datesColumn[6].split(" ")[1]))),
          
                            ],),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    calendarController.getNextWeek(context, keywordController);
                  },
                  child: Container(child: const Icon(Icons.arrow_forward_ios,color: Colors.white,size: 35,))),
              ],
            ),
          ),
          
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Row(
          //       children: [
          //         Container(
          //           padding: EdgeInsets.only(left: 0.w, top: 2.h),
          //           height: 7.h,
          //           width: (deviceController.device == "Desktop") ? 25.w : 50.w,
          //           child: TextField(
          //             style: GoogleFonts.ubuntu(
          //                 textStyle: const TextStyle(color: Colors.white)),
          //             controller: keywordController,
          //             decoration: InputDecoration(
          //               border: InputBorder.none,
          //               hintStyle: GoogleFonts.ubuntu(
          //                       textStyle: const TextStyle(color: Colors.white)),
          //               hintText: "Search...",
          //                 filled: true,
          //                 isCollapsed: false,
          //                 fillColor: themeClass.primaryColor,

          //                 enabledBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(5),
          //                     borderSide: BorderSide.none)),
          //           ),
          //         ),
          //         Container(
          //           padding: EdgeInsets.only(left: 1.w, top: 2.h),
          //           height: 7.h,
          //           width: (deviceController.device == "Desktop") ? 5.w : 15.w,
          //           child: ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                   backgroundColor: themeClass.primaryColor,
          //                   shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(5.0))),
          //               onPressed: () {
          //                 taskController.searchTasks(keywordController.text,keywordController);

          //               },
          //               child: const Icon(Icons.search)),
          //         ),
          //         Container(
          //           padding: EdgeInsets.only(left: 1.w, top: 2.h),
          //           height: 7.h,
          //           width: (deviceController.device == "Desktop") ? 6.w : 20.w,
          //           child: ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                   backgroundColor: themeClass.primaryColor,
          //                   shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(5.0))),
          //               onPressed: () {
          //                 taskController.clearSearch(keywordController);

          //               },
          //               child: const Text("Clear")),
          //         ),
          //       ],
          //     ),
          //     if ((deviceController.device == "Desktop"))
          //       Consumer<CalendarController>(
          //           builder: (context, calendarController, child) {
          //         return SizedBox(
          //           height: 10.h,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Center(
          //                   child: Stack(
          //                 children: [
                            
          //                   Text(
          //       "Week ${calendarController.datesColumn[0]} - ${calendarController.datesColumn[6]}",
          //       style: TextStyle(
          //         fontSize: 15,
          //         letterSpacing: 5,
          //         fontWeight: FontWeight.bold,
          //         foreground: Paint()
          //           ..style = PaintingStyle.stroke
          //           ..strokeWidth = 3
          //           ..color = Colors.black,
          //       ),
          //     ),
          //      Text(
          //       "Week ${calendarController.datesColumn[0]} - ${calendarController.datesColumn[6]}",
          //       style: const TextStyle(
          //         fontSize: 15,
          //         letterSpacing: 5,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white,
          //       ),
          //     ),
          //                 ],
          //               )

          //               ),
          //             ],
          //           ),
          //         );
          //       }),
          //     if (deviceController.device == "Desktop")
          //       Row(
          //         children: [
          //           Container(
          //               padding: EdgeInsets.only(left: 1.w, top: 2.h),
          //               child: Row(
          //                 children: [
          //                   InkWell(
          //                     onTap: () async {
          //                       await calendarController.getPreviousWeek(
          //                           context, keywordController);
          //                       calendarController.notify();
          //                     },
          //                     child: Icon(
          //                       Icons.arrow_back_ios,
          //                       size: 5.h,
          //                       color: themeClass.primaryColor,
          //                     ),
          //                   ),
          //                   InkWell(
          //                     child: Icon(
          //                       Icons.arrow_forward_ios,
          //                       size: 5.h,
          //                       color: themeClass.primaryColor,
          //                     ),
          //                     onTap: () async {
          //                       await calendarController.getNextWeek(
          //                           context, keywordController);
          //                       calendarController.notify();
          //                     },
          //                   ),
          //                 ],
          //               )),
          //         ],
          //       ),
          //   ],
          // ),
          // if ((deviceController.device == "Mobile"))
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       InkWell(
          //         onTap: () {
          //           calendarController.getPreviousWeek(
          //               context, keywordController);
          //         },
          //         child: Icon(
          //           Icons.arrow_back_ios,
          //           size: 5.h,
          //           color: themeClass.primaryColor,
          //         ),
          //       ),
          //       Consumer<CalendarController>(
          //           builder: (context, calendarController, child) {
          //         return SizedBox(
          //           width: 70.w,
          //           height: 10.h,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Center(
          //                   child: Stack(
          //                 children: [
          //                   Text(
          //       "${calendarController.datesColumn[0]}  ${calendarController.datesColumn[6]}",
          //       style: TextStyle(
          //         fontSize: 15,
          //         letterSpacing: 5,
          //         fontWeight: FontWeight.bold,
          //         foreground: Paint()
          //           ..style = PaintingStyle.stroke
          //           ..strokeWidth = 3
          //           ..color = Colors.black,
          //       ),
          //     ),
          //      Text(
          //       "${calendarController.datesColumn[0]}  ${calendarController.datesColumn[6]}",
          //       style: const TextStyle(
          //         fontSize: 15,
          //         letterSpacing: 5,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white,
          //       ),
          //     ),
          //                 ],
          //               )

          //               ),
          //             ],
          //           ),
          //         );
          //       }),
          //       InkWell(
          //         child: Icon(
          //           Icons.arrow_forward_ios,
          //           size: 5.h,
          //           color: themeClass.primaryColor,
          //         ),
          //         onTap: () {
          //           calendarController.getNextWeek(context, keywordController);
          //         },
          //       ),
          //     ],
          //   ),
        ],
      ),
    );
  }
}
