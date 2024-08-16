import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:project_calendar/controllers/project_controller.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:project_calendar/widgets/global/color_picker_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EditProjectDialog extends StatefulWidget {
  final int index;
  const EditProjectDialog({
    super.key,
    required this.index,
  });
  @override
  // ignore: no_logic_in_create_state
  State<EditProjectDialog> createState() => _EditProjectDialogState(index);
}

class _EditProjectDialogState extends State<EditProjectDialog> {
  final int index;
  late DateTime? startingDate;
  late DateTime? deadline;
  late TextEditingController startingDateController;
  late TextEditingController endingDateController;
  ThemeClass themeClass = ThemeClass();
  late TextEditingController nameTextController;
  late TextEditingController durationTextController;
  late TextEditingController deadlineTextController;
  late int? selectedDurationValue;
  _EditProjectDialogState(this.index);
  late ProjectController proController;
  TextEditingController descriptionTextController = TextEditingController();
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void didChangeDependencies() {
    proController = Provider.of<ProjectController>(context, listen: false);
    startingDate = proController.projects[index].startingDate;
    deadline = proController.projects[index].deadline;
    startingDateController = TextEditingController(
        text:
            '${proController.projects[index].startingDate!.day}.${proController.projects[index].startingDate!.month}.${proController.projects[index].startingDate!.year}');
    nameTextController =
        TextEditingController(text: proController.projects[index].name);
    descriptionTextController.text = proController.projects[index].description!;
    durationTextController = TextEditingController(
        text: proController.projects[index].duration.toString());
    deadlineTextController = TextEditingController(
        text:
            '${proController.projects[index].deadline!.day}.${proController.projects[index].deadline!.month}.${proController.projects[index].deadline!.year}');
    selectedDurationValue = proController.projects[index].durationType!.id;
    pickerColor =
        Color(int.parse(proController.projects[index].color!, radix: 16));
    currentColor = pickerColor;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    proController = Provider.of<ProjectController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
          backgroundColor: themeClass.backgroundColor,
          title: Container(
            decoration: BoxDecoration(
                color: themeClass.primaryColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            height: 6.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 1.5.w,),
                  child: const Text("Edit Project",
                      style: TextStyle(color: Colors.white)),
                ),
                 Padding(
                  padding:  EdgeInsets.only(right: 1.5.w, ),
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: BorderSide.none,
                        backgroundColor: themeClass.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () {
                      if ((nameTextController.text == '') ||
                          (startingDateController.text == '') ||
                          (deadlineTextController.text == '') ||
                          (durationTextController.text == '') ||
                          (descriptionTextController.text == '')) {
                        final snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Error!',
                            message: 'Every field must be filled.',
                            contentType: ContentType.failure,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      } else {
                        if (int.tryParse(durationTextController.text) == null) {
                          final snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Error!',
                              message: 'Duration must be a number.',
                              contentType: ContentType.failure,
                            ),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        } else {
                          proController.editProject(
                            index: index,
                            deadline: deadline!,
                            duration: durationTextController.text,
                            startingDate: startingDate!,
                            durationType: selectedDurationValue!,
                            description: descriptionTextController.text,
                            color: currentColor,
                            name: nameTextController.text,
                          );
                          final snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Congratulations!',
                              message:
                                  'You have succesfully edited the Project.',
                              contentType: ContentType.success,
                            ),
                          );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        }
                      }
                    },
                    child: const Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ],
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
              width: 45.w,
              height: 38.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      SizedBox(
                        width: 15.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Name:",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                                width: 10.w,
                                height: 5.h,
                                child: TextField(
                                  controller: nameTextController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 0.5.h, left: 0.7.w),
                                    filled: true,
                                    fillColor: const Color(0xffffffff),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(width: 5.w),
                      SizedBox(
                        width: 18.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Duration:",
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    width: 10.w,
                                    height: 5.h,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: durationTextController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 0.5.h, left: 0.7.w),
                                        filled: true,
                                        fillColor: const Color(0xffffffff),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.black),
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  width: 6.w,
                                  child: DropdownButton2<int>(
                                    underline: const SizedBox(),
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: EdgeInsets.only(
                                          top: 0.3.h, left: 0.7.w),
                                      child: Text(
                                        'Select the duration...',
                                        style: GoogleFonts.ubuntu(
                                            textStyle: const TextStyle(
                                                color: Colors.white)),
                                      ),
                                    ),
                                    items: proController.durationTypes
                                        .map(
                                          (e) => DropdownMenuItem<int>(
                                            value: e.id,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 0.5.w),
                                              child: Text(e.unit!,
                                                  style: GoogleFonts.ubuntu(
                                                      textStyle:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .black))),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    //                         items: [ DropdownMenuItem<String>(
                                    //                                   value: 'Hours',
                                    //                                   child: Padding(
                                    //                                     padding: EdgeInsets.only(left: 0.5.w),
                                    //                                     child: Text('Hours',
                                    //                                         style: GoogleFonts.ubuntu(
                                    // textStyle: const TextStyle(
                                    //     color: Colors.black))),
                                    //                                   ),
                                    //                                 ),
                                    //                                 DropdownMenuItem<String>(
                                    //                                   value: 'Days',
                                    //                                   child: Padding(
                                    //                                     padding: EdgeInsets.only(left: 0.5.w),
                                    //                                     child: Text('Days',
                                    //                                         style: GoogleFonts.ubuntu(
                                    // textStyle: const TextStyle(
                                    //     color: Colors.black))),
                                    //                                   ),
                                    //                                 ),
                                    //                                 DropdownMenuItem<String>(
                                    //                                   value: 'Weeks',
                                    //                                   child: Padding(
                                    //                                     padding: EdgeInsets.only(left: 0.5.w),
                                    //                                     child: Text('Weeks',
                                    //                                         style: GoogleFonts.ubuntu(
                                    // textStyle: const TextStyle(
                                    //     color: Colors.black))),
                                    //                                   ),
                                    //                                 ),
                                    //                                 DropdownMenuItem<String>(
                                    //                                   value: 'Months',
                                    //                                   child: Padding(
                                    //                                     padding: EdgeInsets.only(left: 0.5.w),
                                    //                                     child: Text('Months',
                                    //                                         style: GoogleFonts.ubuntu(
                                    // textStyle: const TextStyle(
                                    //     color: Colors.black))),
                                    //                                   ),
                                    //                                 ),
                                    //                                 DropdownMenuItem<String>(
                                    //                                   value: 'Years',
                                    //                                   child: Padding(
                                    //                                     padding: EdgeInsets.only(left: 0.5.w),
                                    //                                     child: Text('Years',
                                    //                                         style: GoogleFonts.ubuntu(
                                    // textStyle: const TextStyle(
                                    //     color: Colors.black))),
                                    //                                   ),
                                    //                                 ),
                                    //                                 ],
                                    value: selectedDurationValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedDurationValue = value;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white),
                                      height: 5.h,
                                      width: 18.w,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      SizedBox(
                        width: 15.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Starting date:",
                              style: TextStyle(color: Colors.white),
                            ),
                            InkWell(
                              onTap: () async {
                                startingDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2017),
                                    lastDate: DateTime(2100));
                                setState(() {
                                  startingDateController.text =
                                      '${startingDate!.day}.${startingDate!.month}.${startingDate!.year}';
                                });
                              },
                              child: SizedBox(
                                  width: 10.w,
                                  height: 5.h,
                                  child: TextField(
                                    enabled: false,
                                    controller: startingDateController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 0.5.h, left: 0.7.w),
                                      filled: true,
                                      fillColor: const Color(0xffffffff),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      SizedBox(
                        width: 18.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Deadline:",
                              style: TextStyle(color: Colors.white),
                            ),
                            InkWell(
                              onTap: () async {
                                deadline = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2017),
                                    lastDate: DateTime(2100));
                                setState(() {
                                  deadlineTextController.text =
                                      '${deadline!.day}.${deadline!.month}.${deadline!.year}';
                                });
                              },
                              child: SizedBox(
                                  width: 10.w,
                                  height: 5.h,
                                  child: TextField(
                                    enabled: false,
                                    controller: deadlineTextController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 0.5.h, left: 0.7.w),
                                      filled: true,
                                      fillColor: const Color(0xffffffff),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      SizedBox(
                        width: 15.w,
                        child: Column(
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
                                                      currentColor =
                                                          pickerColor;
                                                    });
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffD9D9D9),
                                                      fixedSize:
                                                          Size(45.w, 7.h),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0))),
                                                  child: Text(
                                                    "Confirm",
                                                    style: GoogleFonts.ubuntu(
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white)),
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
                                                      pickerAreaHeightPercent:
                                                          0.5,
                                                      pickerColor: pickerColor,
                                                      onColorChanged:
                                                          changeColor,
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
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  child: Text("Choose color",
                                      style: GoogleFonts.ubuntu(
                                          textStyle: const TextStyle(
                                              color: Colors.black)),
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
                      ),
                      SizedBox(width: 5.w),
                      SizedBox(
                        width: 18.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: Text("Description:",
                                  style: GoogleFonts.ubuntu(
                                      textStyle: const TextStyle(
                                          color: Colors.white))),
                            ),
                            SizedBox(
                              height: 12.h,
                              width: 20.w,
                              child: TextField(
                                style: const TextStyle(color: Colors.black),
                                controller: descriptionTextController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 10,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ))),
    );
  }
}
