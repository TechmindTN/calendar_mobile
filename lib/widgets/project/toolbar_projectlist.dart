import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/project_controller.dart';

class ProjectListToolbar extends StatefulWidget {
  final ProjectController proController;

  const ProjectListToolbar({super.key, required this.proController});
  @override
  State<ProjectListToolbar> createState() =>
      // ignore: no_logic_in_create_state
      _ProjectListToolbar(proController);
}

class _ProjectListToolbar extends State<ProjectListToolbar> {
  ThemeClass themeClass = ThemeClass();
  TextEditingController dateController = TextEditingController();
  final ProjectController proController;
  // final List<Widget> sortByOptions = [
  //   Row(
  //     children: [
  //       Text('Starting date  ',
  //           style: GoogleFonts.ubuntu(
  //               textStyle: TextStyle(color: Colors.white, fontSize: 1.8.h))),
  //       Icon(
  //         Icons.arrow_downward,
  //         color: Colors.white,
  //         size: 2.5.h,
  //       ),
  //     ],
  //   ),
  //   Row(
  //     children: [
  //       Text('Starting date  ',
  //           style: GoogleFonts.ubuntu(
  //               textStyle: TextStyle(color: Colors.white, fontSize: 1.8.h))),
  //       Icon(
  //         Icons.arrow_upward,
  //         color: Colors.white,
  //         size: 2.5.h,
  //       ),
  //     ],
  //   ),
  //   Row(
  //     children: [
  //       Text('Deadline  ',
  //           style: GoogleFonts.ubuntu(
  //               textStyle: TextStyle(color: Colors.white, fontSize: 1.8.h))),
  //       Icon(
  //         Icons.arrow_downward,
  //         color: Colors.white,
  //         size: 2.5.h,
  //       ),
  //     ],
  //   ),
  //   Row(
  //     children: [
  //       Text('Deadline  ',
  //           style: GoogleFonts.ubuntu(
  //               textStyle: TextStyle(color: Colors.white, fontSize: 1.8.h))),
  //       Icon(
  //         Icons.arrow_upward,
  //         color: Colors.white,
  //         size: 2.5.h,
  //       ),
  //     ],
  //   ),
  //   Row(
  //     children: [
  //       Text('Duration  ',
  //           style: GoogleFonts.ubuntu(
  //               textStyle: TextStyle(color: Colors.white, fontSize: 1.8.h))),
  //       Icon(
  //         Icons.arrow_downward,
  //         color: Colors.white,
  //         size: 2.5.h,
  //       ),
  //     ],
  //   ),
  //   Row(
  //     children: [
  //       Text('Duration  ',
  //           style: GoogleFonts.ubuntu(
  //               textStyle: TextStyle(color: Colors.white, fontSize: 1.8.h))),
  //       Icon(
  //         Icons.arrow_upward,
  //         color: Colors.white,
  //         size: 2.5.h,
  //       ),
  //     ],
  //   ),
  //   Row(
  //     children: [
  //       Text('Tasks  ',
  //           style: GoogleFonts.ubuntu(
  //               textStyle: TextStyle(color: Colors.white, fontSize: 1.8.h))),
  //       Icon(
  //         Icons.arrow_downward,
  //         color: Colors.white,
  //         size: 2.5.h,
  //       ),
  //     ],
  //   ),
  //   Row(
  //     children: [
  //       Text('Tasks  ',
  //           style: GoogleFonts.ubuntu(
  //               textStyle: TextStyle(color: Colors.white, fontSize: 1.8.h))),
  //       Icon(
  //         Icons.arrow_upward,
  //         color: Colors.white,
  //         size: 2.5.h,
  //       ),
  //     ],
  //   ),
  // ];
  String? stringValue;
  Widget? value;
  TextEditingController keywordController = TextEditingController();
  _ProjectListToolbar(this.proController);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(top: 2.h),
              height: 7.h,
              width: 57.5.w,
              child: TextField(
                 style: GoogleFonts.ubuntu(
                                textStyle: const TextStyle(color: Colors.white)),
                controller: keywordController,
                decoration: InputDecoration(
                   border: InputBorder.none,
                    filled: true,
                    fillColor: themeClass.primaryColor,
                     isCollapsed: false,
                      hintStyle: GoogleFonts.ubuntu(
                                textStyle: const TextStyle(color: Colors.white)),
                     hintText: "Search...",
                    // label: Text(
                    //   'Search...',
                    //   style: GoogleFonts.ubuntu(
                    //       textStyle: const TextStyle(color: Colors.white)),
                    // ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 1.w, top: 2.h),
              height: 7.h,
              width: 15.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: themeClass.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  onPressed: () {
                    proController.searchProject(
                        keyword: keywordController.text);
                    // final snackBar = SnackBar(
                    //   /// need to set following properties for best effect of awesome_snackbar_content
                    //   elevation: 0,
                    //   behavior: SnackBarBehavior.floating,
                    //   backgroundColor: Colors.transparent,
                    //   content: AwesomeSnackbarContent(
                    //     title: 'Success!',
                    //     message: 'List has been successfully searched!',

                    //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    //     contentType: ContentType.success,
                    //   ),
                    // );
                    // ScaffoldMessenger.of(context)
                    //   ..hideCurrentSnackBar()
                    //   ..showSnackBar(snackBar);
                  },
                  child: const Icon(Icons.search)),
            ),
            Container(
              padding: EdgeInsets.only(left: 1.w, top: 2.h),
              height: 7.h,
              // width: (deviceController.device=="Desktop")?6.w:20.w,
              width: 20.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: themeClass.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  onPressed: () {
                    proController.clearSearchProject(
                        keywordController: keywordController);
                    // taskController.searchTasks(keywordController.text);
                    // final snackBar = SnackBar(
                    //   /// need to set following properties for best effect of awesome_snackbar_content
                    //   elevation: 0,
                    //   behavior: SnackBarBehavior.floating,
                    //   backgroundColor: Colors.transparent,
                    //   content: AwesomeSnackbarContent(
                    //     title: 'Success!',
                    //     message: 'List has been successfully searched!',

                    //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    //     contentType: ContentType.success,
                    //   ),
                    // );
                    // ScaffoldMessenger.of(context)
                    //   ..hideCurrentSnackBar()
                    //   ..showSnackBar(snackBar);
                  },
                  child: const Text("Clear")),
            ),
          ],
        ),
        // Row(
        //   children: [
        //     Container(
        //       padding: EdgeInsets.only(left: 1.w, top: 2.h),
        //       height: 7.h,
        //       width: 10.5.w,
        //       child: ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //               backgroundColor: themeClass.primaryColor,
        //               shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(5.0))),
        //           onPressed: () {},
        //           child: const Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text("Sorting"),
        //               Icon(Icons.sort)
        //             ],
        //           ),
        //           // child: DropdownButton2<Widget>(
        //           //   underline: const SizedBox(),
        //           //   iconStyleData: const IconStyleData(iconSize: 0),
        //           //   isExpanded: true,
        //           //   hint: Row(
        //           //     children: [
        //           //       FittedBox(
        //           //         fit: BoxFit.fitWidth,
        //           //         child: Text(
        //           //           'Sorting',
        //           //           style: GoogleFonts.ubuntu(
        //           //               textStyle:
        //           //                   const TextStyle(color: Colors.white)),
        //           //         ),
        //           //       ),
        //           //       const Icon(Icons.sort)
        //           //     ],
        //           //   ),
        //           //   items: sortByOptions
        //           //       .map((Widget item) => DropdownMenuItem<Widget>(
        //           //             value: item,
        //           //             child: item,
        //           //           ))
        //           //       .toList(),
        //           //   value: value,
        //           //   onChanged: (Widget? selectedValue) {
        //           //     setState(() {
        //           //       value = selectedValue;
        //           //     });
        //           //     final snackBar = SnackBar(
        //           //       elevation: 0,
        //           //       behavior: SnackBarBehavior.floating,
        //           //       backgroundColor: Colors.transparent,
        //           //       content: AwesomeSnackbarContent(
        //           //         title: 'Success!',
        //           //         message: 'List has been successfully sorted!',
        //           //         contentType: ContentType.success,
        //           //       ),
        //           //     );
        //           //     ScaffoldMessenger.of(context)
        //           //       ..hideCurrentSnackBar()
        //           //       ..showSnackBar(snackBar);
        //           //   },
        //           //   dropdownStyleData: DropdownStyleData(
        //           //     maxHeight: 45.h,
        //           //     width: 9.5.w,
        //           //     decoration: BoxDecoration(
        //           //       borderRadius: BorderRadius.circular(5),
        //           //       color: const Color(0Xff478CF3),
        //           //     ),
        //           //     offset: Offset(-1.1.w, 0),
        //           //     scrollbarTheme: ScrollbarThemeData(
        //           //       radius: const Radius.circular(40),
        //           //       thickness: MaterialStateProperty.all(6),
        //           //       thumbVisibility: MaterialStateProperty.all(true),
        //           //     ),
        //           //   ),
        //           // )
        //           ),
        //     ),
        //     Container(
        //       padding: EdgeInsets.only(left: 1.w, top: 2.h),
        //       height: 7.h,
        //       width: 8.w,
        //       child: ElevatedButton(
        //         style: ElevatedButton.styleFrom(
        //             backgroundColor: themeClass.primaryColor,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(5.0))),
        //         child: Row(
        //           children: [
        //             Text(
        //               'Filter',
        //               style: GoogleFonts.ubuntu(
        //                   textStyle:
        //                       TextStyle(color: Colors.white, fontSize: 2.32.h)),
        //             ),
        //             const Icon(Icons.filter_alt_rounded)
        //           ],
        //         ),
        //         onPressed: () {
        //           // showDialog(
        //           //     context: context,
        //           //     builder: (context) => AlertDialog(
        //           //           actionsPadding:
        //           //               EdgeInsets.only(bottom: 2.h, top: 2.h),
        //           //           actions: [
        //           //             Row(
        //           //               mainAxisAlignment:
        //           //                   MainAxisAlignment.spaceEvenly,
        //           //               children: [
        //           //                 ElevatedButton(
        //           //                   style: ElevatedButton.styleFrom(
        //           //                       side: BorderSide.none,
        //           //                       backgroundColor:
        //           //                           const Color(0Xff478CF3),
        //           //                       shape: RoundedRectangleBorder(
        //           //                           borderRadius:
        //           //                               BorderRadius.circular(5.0))),
        //           //                   child: Text(
        //           //                     'Confirm',
        //           //                     style: GoogleFonts.ubuntu(
        //           //                         textStyle: const TextStyle(
        //           //                             color: Colors.white)),
        //           //                   ),
        //           //                   onPressed: () {
        //           //                     final snackBar = SnackBar(
        //           //                       elevation: 0,
        //           //                       behavior: SnackBarBehavior.floating,
        //           //                       backgroundColor: Colors.transparent,
        //           //                       content: AwesomeSnackbarContent(
        //           //                         title: 'Success!',
        //           //                         message:
        //           //                             'Filters have been successfully applied!',
        //           //                         contentType: ContentType.success,
        //           //                       ),
        //           //                     );
        //           //                     Navigator.pop(context);
        //           //                     ScaffoldMessenger.of(context)
        //           //                       ..hideCurrentSnackBar()
        //           //                       ..showSnackBar(snackBar);
        //           //                   },
        //           //                 ),
        //           //                 ElevatedButton(
        //           //                   style: ElevatedButton.styleFrom(
        //           //                       side: BorderSide.none,
        //           //                       backgroundColor:
        //           //                           const Color(0Xff478CF3),
        //           //                       shape: RoundedRectangleBorder(
        //           //                           borderRadius:
        //           //                               BorderRadius.circular(5.0))),
        //           //                   child: Text(
        //           //                     'Cancel',
        //           //                     style: GoogleFonts.ubuntu(
        //           //                         textStyle: const TextStyle(
        //           //                             color: Colors.white)),
        //           //                   ),
        //           //                   onPressed: () {
        //           //                     Navigator.pop(context);
        //           //                   },
        //           //                 ),
        //           //               ],
        //           //             )
        //           //           ],
        //           //           titlePadding: EdgeInsets.zero,
        //           //           backgroundColor: const Color(0xff92CAF3),
        //           //           title: Container(
        //           //             height: 8.h,
        //           //             decoration: const BoxDecoration(
        //           //                 color: Color(0xff478CF3),
        //           //                 borderRadius: BorderRadius.only(
        //           //                     topLeft: Radius.circular(5),
        //           //                     topRight: Radius.circular(5))),
        //           //             child: Padding(
        //           //               padding:
        //           //                   EdgeInsets.only(left: 1.5.w, top: 2.5.h),
        //           //               child: Text(
        //           //                 "Filter",
        //           //                 style: GoogleFonts.ubuntu(
        //           //                     textStyle:
        //           //                         const TextStyle(color: Colors.white)),
        //           //               ),
        //           //             ),
        //           //           ),
        //           //           content: Container(
        //           //             height: 40.h,
        //           //             width: 35.w,
        //           //             child: Row(
        //           //               mainAxisAlignment:
        //           //                   MainAxisAlignment.spaceEvenly,
        //           //               children: [
        //           //                 Column(
        //           //                   mainAxisAlignment:
        //           //                       MainAxisAlignment.spaceEvenly,
        //           //                   crossAxisAlignment:
        //           //                       CrossAxisAlignment.start,
        //           //                   children: [
        //           //                     Column(
        //           //                       crossAxisAlignment:
        //           //                           CrossAxisAlignment.start,
        //           //                       children: [
        //           //                         Padding(
        //           //                           padding:
        //           //                               EdgeInsets.only(bottom: 2.h),
        //           //                           child: Text(
        //           //                             'Starting Date',
        //           //                             style: GoogleFonts.ubuntu(
        //           //                                 textStyle: const TextStyle(
        //           //                                     color: Colors.white)),
        //           //                           ),
        //           //                         ),
        //           //                         InkWell(
        //           //                           onTap: () async {
        //           //                             // DateTime? date =
        //           //                             //     await showDatePicker(
        //           //                             //         context: context,
        //           //                             //         initialDate:
        //           //                             //             DateTime.now(),
        //           //                             //         firstDate: DateTime(2017),
        //           //                             //         lastDate: DateTime(2100));
        //           //                             // setState(() {
        //           //                             //   dateController.text =
        //           //                             //       '${date!.day}.${date.month}.${date.year}';
        //           //                             // });
        //           //                           },
        //           //                           child: Container(
        //           //                             height: 5.h,
        //           //                             width: 18.w,
        //           //                             decoration: BoxDecoration(
        //           //                                 border: Border.all(),
        //           //                                 borderRadius:
        //           //                                     const BorderRadius.all(
        //           //                                         Radius.circular(5)),
        //           //                               ),
        //           //                             child: TextField(
        //           //                               enabled: false,
        //           //                               controller: dateController,
        //           //                               decoration: InputDecoration(
        //           //                                 filled: true,
        //           //                                 fillColor: Colors.white,
        //           //                                 border:
        //           //                                     const OutlineInputBorder(
        //           //                                   borderSide: BorderSide.none
        //           //                                 ),
        //           //                                 label: Row(
        //           //                                   mainAxisAlignment:
        //           //                                       MainAxisAlignment
        //           //                                           .spaceBetween,
        //           //                                   children: [
        //           //                                     Text(
        //           //                                       'Starting date',
        //           //                                       style: GoogleFonts.ubuntu(
        //           //                                           textStyle:
        //           //                                               const TextStyle(
        //           //                                                   color: Colors
        //           //                                                       .black)),
        //           //                                     ),
        //           //                                     const Icon(
        //           //                                       Icons.calendar_month,
        //           //                                     )
        //           //                                   ],
        //           //                                 ),
        //           //                               ),
        //           //                             ),
        //           //                           ),
        //           //                         ),
        //           //                       ],
        //           //                     ),
        //           //                     Column(
        //           //                       crossAxisAlignment:
        //           //                           CrossAxisAlignment.start,
        //           //                       children: [
        //           //                         Padding(
        //           //                           padding:
        //           //                               EdgeInsets.only(bottom: 2.h),
        //           //                           child: Text(
        //           //                             'Deadline',
        //           //                             style: GoogleFonts.ubuntu(
        //           //                                 textStyle: const TextStyle(
        //           //                                     color: Colors.white)),
        //           //                           ),
        //           //                         ),
        //           //                         InkWell(
        //           //                           onTap: () async {
        //           //                             // DateTime? date =
        //           //                             //     await showDatePicker(
        //           //                             //         context: context,
        //           //                             //         initialDate:
        //           //                             //             DateTime.now(),
        //           //                             //         firstDate: DateTime(2017),
        //           //                             //         lastDate: DateTime(2100));
        //           //                             // setState(() {
        //           //                             //   dateController.text =
        //           //                             //       '${date!.day}.${date.month}.${date.year}';
        //           //                             // });
        //           //                           },
        //           //                           child: Container(
        //           //                             height: 5.h,
        //           //                             width: 18.w,
        //           //                             decoration: BoxDecoration(
        //           //                                 border: Border.all(),
        //           //                                 borderRadius:
        //           //                                     const BorderRadius.all(
        //           //                                         Radius.circular(5)),
        //           //                               ),
        //           //                             child: TextField(
        //           //                               enabled: false,
        //           //                               controller: dateController,
        //           //                               decoration: InputDecoration(
        //           //                                 filled: true,
        //           //                                 fillColor: Colors.white,
        //           //                                 border:
        //           //                                     const OutlineInputBorder(
        //           //                                   borderSide: BorderSide.none
        //           //                                 ),
        //           //                                 label: Row(
        //           //                                   mainAxisAlignment:
        //           //                                       MainAxisAlignment
        //           //                                           .spaceBetween,
        //           //                                   children: [
        //           //                                     Text(
        //           //                                       'Deadline',
        //           //                                       style: GoogleFonts.ubuntu(
        //           //                                           textStyle:
        //           //                                               const TextStyle(
        //           //                                                   color: Colors
        //           //                                                       .black)),
        //           //                                     ),
        //           //                                     const Icon(
        //           //                                       Icons.calendar_month,
        //           //                                     )
        //           //                                   ],
        //           //                                 ),
        //           //                               ),
        //           //                             ),
        //           //                           ),
        //           //                         )
        //           //                       ],
        //           //                     ),
        //           //                     Column(
        //           //                       crossAxisAlignment:
        //           //                           CrossAxisAlignment.start,
        //           //                       children: [
        //           //                         Padding(
        //           //                           padding:
        //           //                               EdgeInsets.only(bottom: 2.h),
        //           //                           child: Text(
        //           //                             'Creator',
        //           //                             style: GoogleFonts.ubuntu(
        //           //                                 textStyle: const TextStyle(
        //           //                                     color: Colors.white)),
        //           //                           ),
        //           //                         ),
        //           //                         Container(
        //           //                           decoration: const BoxDecoration(
        //           //                               color: Colors.white,
        //           //                               borderRadius: BorderRadius.all(
        //           //                                   Radius.circular(5))),
        //           //                           width: 18.w,
        //           //                           height: 5.h,
        //           //                           child: DropdownButton2<String>(
        //           //                             underline: SizedBox(),
        //           //                             isExpanded: true,
        //           //                             hint: Padding(
        //           //                               padding: EdgeInsets.only(
        //           //                                     top: 0.1.h, left: 0.8.w),
        //           //                               child: Text(
        //           //                                 'Creator',
        //           //                                 style: GoogleFonts.ubuntu(
        //           //                                     textStyle: const TextStyle(
        //           //                                         color: Colors.black,
        //           //                                         backgroundColor:
        //           //                                             Colors.white)),
        //           //                               ),
        //           //                             ),
        //           //                             items: creatorList
        //           //                                 .map((String item) =>
        //           //                                     DropdownMenuItem<String>(
        //           //                                       value: item,
        //           //                                       child: Text(item),
        //           //                                     ))
        //           //                                 .toList(),
        //           //                             value: stringValue,
        //           //                             onChanged: (String?
        //           //                                 selectedStringValue) {
        //           //                               setState(() {
        //           //                                 stringValue =
        //           //                                     selectedStringValue;
        //           //                               });
        //           //                             },
        //           //                             dropdownStyleData:
        //           //                                 DropdownStyleData(
        //           //                               decoration: BoxDecoration(
        //           //                                 borderRadius:
        //           //                                     BorderRadius.circular(0),
        //           //                                 color: Colors.white,
        //           //                               ),
        //           //                             ),
        //           //                             buttonStyleData:
        //           //                                   ButtonStyleData(
        //           //                                 decoration: BoxDecoration(
        //           //                                     border: Border.all(
        //           //                                         color: Colors.black),
        //           //                                     borderRadius:
        //           //                                         BorderRadius.circular(
        //           //                                             5),
        //           //                                     color: Colors.white),
        //           //                                 height: 5.h,
        //           //                                 width: 18.w,
        //           //                               ),
        //           //                           ),
        //           //                         ),
        //           //                       ],
        //           //                     ),
        //           //                   ],
        //           //                 ),
        //           //               ],
        //           //             ),
        //           //           ),
        //           //         ));
        //         },
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
