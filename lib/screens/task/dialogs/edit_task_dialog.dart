import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:project_calendar/controllers/calendar_controller.dart';
import 'package:project_calendar/controllers/project_controller.dart';
import 'package:project_calendar/controllers/task_controller.dart';
import 'package:project_calendar/models/employee.dart';
import 'package:project_calendar/models/project.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/employees_controller.dart';

class EditTaskDialog extends StatefulWidget {
  final int k;
  final int l;
final int m;
  const EditTaskDialog({super.key, required this.k, required this.l, required this.m});
  @override
  // ignore: no_logic_in_create_state
  State<EditTaskDialog> createState() => _EditTaskDialog(k, l,m);
}

class _EditTaskDialog extends State<EditTaskDialog> {
  final int k;
  final int l;
  final int m;
  late TextEditingController startingDateController;
  late TextEditingController projectTextController;
  late TextEditingController titleTextController;
  late TextEditingController descriptionTextController;
  late TextEditingController endingDateController;
  late TaskController taskController;
  late EmployeesController empController;
  late ProjectController proController;
  late CalendarController calendarController;
  Employee? selectedEmployeeValue;
  String? selectedDurationValue;
  Project? selectedProjectValue;
  String? selectedStatusValue;
  int? selectedPriorityValue;
  final List<int> priorityList=[1,2,3,4,5,6,7,8];
  final List<String> durationList = [
    "1 hours",
    "2 hours",
    "3 hours",
    "4 hours",
    "5 hours",
    "6 hours",
    "7 hours",
    "8 hours"
  ];
  final List<String> statusList = ["Pending", "In progress", "Done", "Problem"];
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  _EditTaskDialog(this.k, this.l, this.m);
  ThemeClass themeClass = ThemeClass();

  @override
  void initState() {
    taskController = Provider.of<TaskController>(context, listen: false);
    empController = Provider.of<EmployeesController>(context, listen: false);
    proController = Provider.of<ProjectController>(context, listen: false);
    calendarController =
        Provider.of<CalendarController>(context, listen: false);
    selectedEmployeeValue = Employee(
      department: taskController.currentTasks[k][l][m]!.employee!.department,
      name: taskController.currentTasks[k][l][m]!.employee!.name,
      user: taskController.currentTasks[k][l][m]!.employee!.user,
      id: taskController.currentTasks[k][l][m]!.employee!.id
    );
    
    selectedPriorityValue=taskController.currentTasks[k][l][m]!.priority;
    startingDateController = TextEditingController();
    startingDateController.text = taskController
        .gettingDateFromCalendar(calendarController.datesColumn[l]);
    selectedStatusValue = taskController.currentTasks[k][l][m]!.status;
    selectedProjectValue = taskController.currentTasks[k][l][m]!.project;
    selectedDurationValue =
        '${taskController.currentTasks[k][l][m]!.duration} hours';
    projectTextController = TextEditingController(
        text: taskController.currentTasks[k][l][m]!.project!.name);
    titleTextController =
        TextEditingController(text: taskController.currentTasks[k][l][m]!.title);
    descriptionTextController = TextEditingController(
        text: taskController.currentTasks[k][l][m]!.description);
    endingDateController = TextEditingController();
    pickerColor =
        Color(int.parse(taskController.currentTasks[k][l][m]!.color!, radix: 16));
    currentColor = pickerColor;

    super.initState();
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
     return  Container(
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        child: AlertDialog(
          backgroundColor: themeClass.backgroundColor,
          titlePadding: EdgeInsets.zero,
          title: Container(
            height: 6.h,
            decoration:  BoxDecoration(
                color: themeClass.primaryColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 1.5.w, ),
                  child: Text(
                    "Edit Task",
                    style: GoogleFonts.ubuntu(
                        textStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
                 Padding(
                  padding:  EdgeInsets.only(right: 1.5.w,),
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.close,
                  color: Colors.white,
                  )),
                ),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.only(bottom: 1.h),
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
                    "Cancel",
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
                    "Confirm",
                    style: GoogleFonts.ubuntu(
                        textStyle: const TextStyle(color: Colors.white)),
                  ),
                  onPressed: () async {
                    if ((startingDateController.text == '') ||
                        // (descriptionTextController.text == '') ||
                        (titleTextController.text == '')) {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Error!',
                          message: 'All fields need to be filled.',
                          contentType: ContentType.failure,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    } else {
                      await taskController.editTask(k, l,m, context,
                      priority: selectedPriorityValue!,
                          id: taskController.selectedTask!.id!,
                          duration: selectedDurationValue!,
                          title: titleTextController.text,
                          empId: selectedEmployeeValue!.id!,
                          projectId: selectedProjectValue!.id!,
                          status: selectedStatusValue!,
                          description: descriptionTextController.text,
                          start: DateTime.parse(startingDateController.text),
                          color: currentColor);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Congratulations!',
                          message: 'You have succesfully added a new task.',
                          contentType: ContentType.success,
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
                  },
                ),
              ],
            ),
          ],
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            width: 45.w,
            height: 50.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Text(
                              "Employee:",
                              style: GoogleFonts.ubuntu(
                                  textStyle:
                                      const TextStyle(color: Colors.white)),
                            )),
                            Container(
                            
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                        
                                color: Colors.grey),
                            height: 5.h,
                            width:  18.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Text(selectedEmployeeValue!.name.toString()),
                                ),
                              ],
                            ),
                          ),
                       
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Text(
                              "Project:",
                              style: GoogleFonts.ubuntu(
                                  textStyle:
                                      const TextStyle(color: Colors.white)),
                            )),
                            Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          height: 5.h,
                          width: 18.w,
                          child: DropdownSearch<Project>(
                            itemAsString: (item) => item.name!,
                            compareFn: ((item1, item2) {
                              return item1.id==item2.id;
                            }),
                            
                            
                            popupProps: const PopupProps.modalBottomSheet(
                              showSearchBox: true,
                                showSelectedItems: true,
                            ),
                            items: proController.projects,
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                
                                ),
                            ),
                            onChanged: (Project? value) {
                            setState(() {
                              selectedProjectValue = value;
                              pickerColor=currentColor=Color(int.parse(value!.color!, radix: 16));
                            });
                          },
                            selectedItem: selectedProjectValue,
                        ),
                        )
                     
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.only(bottom: 2.h),
                                child: Text(
                                  "Title:",
                                  style: GoogleFonts.ubuntu(
                                      textStyle:
                                          const TextStyle(color: Colors.white)),
                                )),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          height: 5.h,
                          width: 18.w,
                          child: TextField(
                            controller: titleTextController,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(top: 0.5.h, left: 0.7.w),
                              filled: true,
                              fillColor: Colors.white,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Text("Starting date:",
                                style: GoogleFonts.ubuntu(
                                    textStyle:
                                        const TextStyle(color: Colors.white)))),
                              
                   
                           Container(
                            height: 5.h,
                            width: 18.w,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: TextField(
                              enabled: false,
                              controller: startingDateController,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.grey,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Text(
                              "Priority:",
                              style: GoogleFonts.ubuntu(
                                  textStyle:
                                      const TextStyle(color: Colors.white)),
                            )),
                        DropdownButton2<int>(
                          underline: const SizedBox(),
                          isExpanded: true,
                          hint: Padding(
                            padding: EdgeInsets.only(top: 0.3.h, left: 0.7.w),
                            child: Text(
                              'Priority...',
                              style: GoogleFonts.ubuntu(
                                  textStyle:
                                      const TextStyle(color: Colors.white)),
                            ),
                          ),
                          items: priorityList
                              .map((int item) => DropdownMenuItem<int>(
                                    value: item,
                                    child: Text(item.toString()),
                                  ))
                              .toList(),
                          value: selectedPriorityValue,
                          onChanged: (int? value) {
                            setState(() {
                              selectedPriorityValue = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffD9D9D9)),
                            height: 5.h,
                            width: 18.w,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Text(
                              "Color:",
                              style: GoogleFonts.ubuntu(
                                  textStyle:
                                      const TextStyle(color: Colors.white)),
                            )),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: currentColor,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(5))),
                              height: 5.h,
                              width: 4.w,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.black, width: 1),
                                  backgroundColor: Colors.white,
                                  fixedSize: Size(9.w, 5.h),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              child: Text("Choose color",
                                  style: GoogleFonts.ubuntu(
                                      textStyle:
                                          const TextStyle(color: Colors.black)),
                                  textAlign: TextAlign.start),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          actionsPadding: EdgeInsets.zero,
                                          contentPadding: EdgeInsets.zero,
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);

                                                setState(() {
                                                  currentColor = pickerColor;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xffD9D9D9),
                                                  fixedSize: Size(45.w, 7.h),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0))),
                                              child: Text(
                                                "Confirm",
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: const TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            )
                                          ],
                                          content: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white),
                                            width: 45.w,
                                            height: 53.h,
                                            child: Column(
                                              children: [
                                                ColorPicker(
                                                  pickerAreaHeightPercent: 0.5,
                                                  pickerColor: pickerColor,
                                                  onColorChanged: changeColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Text(
                              "Duration:",
                              style: GoogleFonts.ubuntu(
                                  textStyle:
                                      const TextStyle(color: Colors.white)),
                            )),
                        Container(
                            
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                        
                                color: Colors.grey),
                            height: 5.h,
                            width: 18.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Text(selectedDurationValue.toString()),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                     SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Text(
                              "Status:",
                              style: GoogleFonts.ubuntu(
                                  textStyle:
                                      const TextStyle(color: Colors.white)),
                            )),
                        DropdownButton2<String>(
                          underline: const SizedBox(),
                          isExpanded: true,
                          hint: Padding(
                            padding: EdgeInsets.only(top: 0.3.h, left: 0.7.w),
                            child: Padding(
                              padding: EdgeInsets.only(left: 0.7.w),
                              child: Text('Status...',
                                  style: GoogleFonts.ubuntu(
                                      textStyle: const TextStyle(
                                          color: Colors.white))),
                            ),
                          ),
                          items: statusList
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 0.5.w),
                                      child: Text(item,
                                          style: GoogleFonts.ubuntu(
                                              textStyle: const TextStyle(
                                                  color: Colors.black))),
                                    ),
                                  ))
                              .toList(),
                          value: selectedStatusValue,
                          onChanged: (String? value) {
                            setState(() {
                              selectedStatusValue = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            height: 5.h,
                            width: 18.w,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: Text("Description:",
                              style: GoogleFonts.ubuntu(
                                  textStyle:
                                      const TextStyle(color: Colors.white))),
                        ),
                        SizedBox(
                          height: 12.h,
                          width: 18.w,
                          child: TextField(
                            style: const TextStyle(color: Colors.black),
                            controller: descriptionTextController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 10,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}