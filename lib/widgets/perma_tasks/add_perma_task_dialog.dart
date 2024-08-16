import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:project_calendar/controllers/permatask_controller.dart';
import 'package:project_calendar/models/employee.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:project_calendar/widgets/global/color_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/employees_controller.dart';

class AddPermataskDialog extends StatefulWidget {
  final Employee employee;

  const AddPermataskDialog(
      {super.key, required this.employee,
    });
  @override
  // ignore: no_logic_in_create_state
  State<AddPermataskDialog> createState() => _AddPermataskDialog(employee: employee);
}

class _AddPermataskDialog extends State<AddPermataskDialog> {
  ThemeClass themeClass = ThemeClass();
  
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController(text: "");
  late PermataskController permataskController;
  late EmployeesController empController;
  Employee? selectedEmployeeValue;
  String? selectedStatusValue;
  final List<String> statusList = ["Pending", "In progress", "Done"];
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  final Employee employee;

  _AddPermataskDialog({required this.employee});
  

  @override
  void initState() {
    permataskController = Provider.of<PermataskController>(context, listen: false);
    empController = Provider.of<EmployeesController>(context, listen: false);

    selectedEmployeeValue =employee;
    //  empController.employees[k];

    selectedStatusValue = "Pending";
    super.initState();
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        child: AlertDialog(
          backgroundColor: themeClass.backgroundColor,
          titlePadding: EdgeInsets.zero,
          title: Container(
            height: 8.h,
            decoration: BoxDecoration(
                color: themeClass.primaryColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 1.5.w, top: 2.5.h),
                  child: Text(
                    "Add Permanent Task",
                    style: GoogleFonts.ubuntu(
                        textStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
                 Padding(
                  padding:  EdgeInsets.only(right: 1.5.w, top: 1.h),
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
                  onPressed: () {
                    if (
                        // (descriptionTextController.text == '') ||
                        (titleTextController.text == '') 
            
                        ) {
                       
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
                 
                     String hexValue =
        pickerColor.value.toRadixString(16).padLeft(8, '0').toUpperCase();
                          permataskController.addpermatask( employee: employee, title: titleTextController.text, description: descriptionTextController.text, color: hexValue, status: selectedStatusValue!);
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
            width: 17.w,
            height: 38.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Text(
                              "Title:*",
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
                SizedBox(height: 1.h,),
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
                        InkWell(
                          onTap: () {
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
                          child: Container(
                            decoration: BoxDecoration(
                                color: currentColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5))),
                            height: 5.h,
                            width: 4.w,
                          ),
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
                                builder: (context) =>
                                    const ColorPickerDialog());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 1.h,),
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
               
              // ],
            ),
          ),
        ),
      );
    
  }
}
