import 'package:project_calendar/controllers/project_controller.dart';
import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/screens/project/dialogs/project_details_dialog.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:project_calendar/widgets/project/toolbar_projectlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  ThemeClass themeClass = ThemeClass();
  // ignore: non_constant_identifier_names
  List<String> ColumnTitles = [
    'N°',
    'Name',
    'Starting date',
    'Deadline',
    'Duration',
    'Actions',
  ];
  // ignore: non_constant_identifier_names
  List<String> RowTitles = ['', '', '', '', '', '', '', ''];

  late ProjectController proController;
  late UserController userController;

  @override
  void initState() {
    proController = Provider.of<ProjectController>(context, listen: false);
    userController = Provider.of<UserController>(context, listen: false);

    proController.getProjects();
    proController.getDurationTypes();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeClass.backgroundColor,
      body: Column(
        children: [
          Container(
              color: themeClass.backgroundColor,
              padding: EdgeInsets.only(left: 2.5.w, right: 3.w),
              child: ProjectListToolbar(proController: proController)),
              SizedBox(height: 3.h,),
          Container(
            color: themeClass.backgroundColor,
            padding: EdgeInsets.only(right: 3.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Container(
                //   padding: EdgeInsets.only(top: 3.h),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         width: 60.w,
                //       ),
                //       SizedBox(
                //         width: 29.w,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             ElevatedButton(
                //               style: ElevatedButton.styleFrom(
                //                   backgroundColor: themeClass.primaryColor,
                //                   fixedSize: Size(6.w, 5.h),
                //                   shape: RoundedRectangleBorder(
                //                       borderRadius:
                //                           BorderRadius.circular(5.0))),
                //               child: Text(
                //                 'Add',
                //                 style: GoogleFonts.ubuntu(
                //                     textStyle:
                //                         const TextStyle(color: Colors.white)),
                //               ),
                //               onPressed: () {
                //                 showDialog(
                //                     context: context,
                //                     builder: (context) =>
                //                         const AddProjectDialog());
                //               },
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Consumer<ProjectController>(
                    builder: (context, proController, child) {
                  return (proController.isLoading == false) ?
                  SizedBox(
                    width: 80.w,
                    height: 73.4.h,

                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: proController.projects.length,
                      itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                showDialog(context: context, builder: (context){
                                  return ProjectDetailsDialog(index: index);
                                });
                              },
                              child: Container(
                                height: 7.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0,2),
                                      blurRadius: 10
                                    )
                                  ]
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                    width: 10.w,
                                       decoration: BoxDecoration(
                                  color: themeClass.primaryColor,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                    child: Center(
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(index.toString(),
                                            maxLines: 1,
                                      
                                         style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 36
                                                                  ),),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          
                                          child: Text(proController.projects[index].name!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                          ),
                                          )),
                                         Padding(
                                           padding: const EdgeInsets.symmetric(vertical:2.0),
                                           child: Container(
                                            width: 76.w,
                                            height: 2,
                                            color: Colors.black,
                                           ),
                                         ),
                                           SizedBox(
                                            width: 76.w,
                                             child: Row(
                                              
                                                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                               children: [
                                                                                 const Text("Deadline",
                                                                                   style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                                                                   ),),
                                                                                 
                                                                                
                                                                                 Text('${proController.projects[index].deadline!.year}-${proController.projects[index].deadline!.month}-${proController.projects[index].deadline!.day}',  style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                                                                   ),)
                                                                               ],
                                                                             ),
                                           ),
                                      ],
                                    ),
                                  ),
                                  ],
                                  // tileColor: Colors.red,
                                   
                                   
                                  
                                ),
                              ),
                            ),
                          );
                    }),
                  )
                    //   ? SizedBox(
                    //       width: 100.w,
                    //       height: 70.h,
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(top: 16.0),
                    //         child: StickyHeadersTable(
                    //           columnsTitleBuilder: (int columnIndex) {
                    //             return InkWell(
                    //               onTap: (() {
                    //                 proController.sortByName();
                    //                 proController.notify();
                    //               }),
                    //               child: Container(
                    //                   decoration: BoxDecoration(
                    //                     color: themeClass.primaryColor,
                    //                   ),
                    //                   width: 15.2.w,
                    //                   height: 9.h,
                    //                   child: Center(
                    //                       child: SelectableText(
                    //                     ColumnTitles[columnIndex],
                    //                     style: const TextStyle(
                    //                         fontWeight: FontWeight.bold,
                    //                         color: Colors.white),
                    //                     textAlign: TextAlign.center,
                    //                   ))),
                    //             );
                    //           },
                    //           contentCellBuilder:

                    //               (int columnIndex, int rowIndex) {
                              
                    //             if (proController
                    //                     .projects[rowIndex].isDeleted ==
                    //                 false) {}
                    //             Widget cell = const SizedBox();
                    //             if (columnIndex == 0) {
                    //               cell = SelectableText(
                    //                 rowIndex.toString(),
                    //                 textAlign: TextAlign.center,
                    //               );
                    //             }
                    //             if (columnIndex == 1) {
                    //               cell = SelectableText(
                    //                 proController.projects[rowIndex].name
                    //                     .toString(),
                    //                 textAlign: TextAlign.center,
                    //               );
                    //             } else if (columnIndex == 2) {
                    //               cell = SelectableText(
                    //                  proController.projects[rowIndex].startingDate!.year.toString() +'-'+((proController.projects[rowIndex].startingDate!.month.toString().length==1)?'0'+proController.projects[rowIndex].startingDate!.month.toString():proController.projects[rowIndex].startingDate!.month.toString())
                    //    +'-'+((proController.projects[rowIndex].startingDate!.day.toString().length==1)?'0'+proController.projects[rowIndex].startingDate!.day.toString():proController.projects[rowIndex].startingDate!.day.toString()),
                    //                 // '${proController.projects[rowIndex].startingDate!.year}-${proController.projects[rowIndex].startingDate!.month}-${proController.projects[rowIndex].startingDate!.day}',
                    //                 textAlign: TextAlign.center,
                    //               );
                    //             } else if (columnIndex == 3) {
                    //               cell = SelectableText(
                    //                 proController.projects[rowIndex].deadline!.year.toString() +'-'+((proController.projects[rowIndex].deadline!.month.toString().length==1)?'0'+proController.projects[rowIndex].deadline!.month.toString():proController.projects[rowIndex].deadline!.month.toString())
                    //    +'-'+((proController.projects[rowIndex].deadline!.day.toString().length==1)?'0'+proController.projects[rowIndex].deadline!.day.toString():proController.projects[rowIndex].deadline!.day.toString()),
                    //                 textAlign: TextAlign.center,
                    //               );
                    //             } else if (columnIndex == 4) {
                    //               cell = SelectableText(
                    //                 '${proController.projects[rowIndex].duration} ${proController.projects[rowIndex].durationType!.unit}',
                    //                 textAlign: TextAlign.center,
                    //               );
                    //             } else if (columnIndex == 5) {
                    //               cell = Container(
                    //                 color: (rowIndex % 2 == 0)
                    //                     ? Colors.white
                    //                     : Colors.grey.shade300,
                    //                 width: 15.2.w,
                    //                 height: 9.h,
                    //                 child: Row(
                    //                   mainAxisAlignment: (userController
                    //                               .currentUser.isSuperuser ==
                    //                           true)
                    //                       ? MainAxisAlignment.spaceEvenly
                    //                       : MainAxisAlignment.center,
                    //                   children: [
                    //                     ElevatedButton(
                    //                       onPressed: () {
                    //                         // proController.getProjectHistory(proController.projects[rowIndex].id);
                    //                            showDialog(context: context, builder: (context){
                    // return ProTaskListDialog(project: proController.projects[rowIndex],);});
                    //                         // showDialog(
                    //                         //     context: context,
                    //                         //     builder: (context) {
                    //                         //       return ProjectDetailsDialog(
                    //                         //           index: rowIndex);
                    //                         //     });
                    //                       },
                    //                       style: ElevatedButton.styleFrom(
                    //                           backgroundColor:
                    //                               const Color.fromARGB(
                    //                                   255, 5, 101, 180),
                    //                           fixedSize: Size(3.w, 4.h),
                    //                           shape: RoundedRectangleBorder(
                    //                               borderRadius:
                    //                                   BorderRadius.circular(
                    //                                       5.0))),
                    //                       child: const Icon(
                    //                         Icons.remove_red_eye,
                    //                         color: Colors.white,
                    //                       ),
                    //                     ),
                    //                     (userController
                    //                                 .currentUser.isSuperuser ==
                    //                             true)
                    //                         ? ElevatedButton(
                    //                             onPressed: () {
                    //                               // showDialog(context: context, builder: (context)=>EditProjectDialog(index: rowIndex,));
                    //                               // proController.getProjectHistory(id:proController.projects[rowIndex].id,context: context);
                    //                               showDialog(
                    //                                   context: context,
                    //                                   builder: (context) =>
                    //                                       ProjectHistoryDialog(
                    //                                         index: rowIndex,
                    //                                       ));
                    //                             },
                    //                             style: ElevatedButton.styleFrom(
                    //                                 backgroundColor:
                    //                                     const Color.fromARGB(
                    //                                         255, 5, 101, 180),
                    //                                 fixedSize: Size(3.w, 4.h),
                    //                                 shape:
                    //                                     RoundedRectangleBorder(
                    //                                         borderRadius:
                    //                                             BorderRadius
                    //                                                 .circular(
                    //                                                     5.0))),
                    //                             child: const Icon(
                    //                               Icons.history,
                    //                               color: Colors.white,
                    //                             ),
                    //                           )
                    //                         : const SizedBox(),
                    //                     (userController
                    //                                 .currentUser.isSuperuser ==
                    //                             true)
                    //                         ? ElevatedButton(
                    //                             onPressed: () {
                    //                               showDialog(
                    //                                   context: context,
                    //                                   builder: (context) =>
                    //                                       EditProjectDialog(
                    //                                         index: rowIndex,
                    //                                       ));
                    //                             },
                    //                             style: ElevatedButton.styleFrom(
                    //                                 backgroundColor:
                    //                                     const Color.fromARGB(
                    //                                         255, 194, 122, 7),
                    //                                 fixedSize: Size(3.w, 4.h),
                    //                                 shape:
                    //                                     RoundedRectangleBorder(
                    //                                         borderRadius:
                    //                                             BorderRadius
                    //                                                 .circular(
                    //                                                     5.0))),
                    //                             child: const Icon(
                    //                               Icons.edit,
                    //                               color: Colors.white,
                    //                             ),
                    //                           )
                    //                         : const SizedBox(),
                    //                     (userController
                    //                                 .currentUser.isSuperuser ==
                    //                             true)
                    //                         ? ElevatedButton(
                    //                             onPressed: () {
                    //                               showDialog(
                    //                                   context: context,
                    //                                   builder: (context) {
                    //                                     return ConfirmDeleteProjectDialog(
                    //                                         title:
                    //                                             "Delete Project",
                    //                                         content:
                    //                                             "Are you sure you want to delete this project!!! \nPlease note that if there is any tasks on this project they will be deleted",
                    //                                         rowIndex: rowIndex);
                    //                                   });
                    //                             },
                    //                             style: ElevatedButton.styleFrom(
                    //                                 backgroundColor:
                    //                                     const Color.fromARGB(
                    //                                         255, 200, 24, 11),
                    //                                 fixedSize: Size(3.w, 4.h),
                    //                                 shape:
                    //                                     RoundedRectangleBorder(
                    //                                         borderRadius:
                    //                                             BorderRadius
                    //                                                 .circular(
                    //                                                     5.0))),
                    //                             child: const Icon(
                    //                               Icons.delete,
                    //                               color: Colors.white,
                    //                             ),
                    //                           )
                    //                         : const SizedBox(),
                    //                   ],
                    //                 ),
                    //               );
                    //             }
                    //             return Container(
                    //                 color: (rowIndex % 2 == 0)
                    //                     ? Colors.white
                    //                     : Colors.grey.shade300,
                    //                 width: 15.2.w,
                    //                 height: 9.h,
                    //                 child: Center(child: cell));
                    //           },
                    //           columnsLength: ColumnTitles.length,
                    //           rowsLength: proController.projects.length,
                    //           rowsTitleBuilder: (int rowIndex) {
                    //             return SizedBox(
                    //               width: 0.w,
                    //               height: 9.h,
                    //             );
                    //           },
                    //           cellDimensions: CellDimensions.fixed(
                    //               contentCellWidth: 15.3.w,
                    //               contentCellHeight: 9.h,
                    //               stickyLegendWidth: 2.5.w,
                    //               stickyLegendHeight: 9.h),
                    //         ),
                    //       ),
                    //     )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
