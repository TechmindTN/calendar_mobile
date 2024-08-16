// ignore_for_file: no_logic_in_create_state

import 'package:project_calendar/controllers/permatask_controller.dart';
import 'package:project_calendar/models/employee.dart';
import 'package:project_calendar/models/permatask.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:project_calendar/widgets/perma_tasks/add_perma_task_dialog.dart';
import 'package:project_calendar/widgets/perma_tasks/confirm_delete_perma_task_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PermmaTaskListDialog extends StatefulWidget {
  final Employee employee;

  // final int index;

  const PermmaTaskListDialog({
    super.key,
    required this.employee,
    // required this.index,
  });
  @override
  State<PermmaTaskListDialog> createState() =>
      _PermmaTaskListDialogState(employee: employee);
}

class _PermmaTaskListDialogState extends State<PermmaTaskListDialog> {
  late Future future;
  final Employee employee;
  // final int index;
  ThemeClass themeClass = ThemeClass();
  // late ProjectController proController;
  late PermataskController permataskController;
  int totalDuration = 0;

  _PermmaTaskListDialogState({required this.employee});
  // _ProjectHistoryDialogState({});
  // late Future future;

  bool isArchive = false;
  int selectedTab = 0;
  @override
  void initState() {
    permataskController =
        Provider.of<PermataskController>(context, listen: false);
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    // proController = Provider.of<ProjectController>(context, listen: false);

    future = permataskController.getPermatasks(context, employee);
    // future=proController.getProjectHistory(id:proController.projects[index].id,context:context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: false,
        backgroundColor: themeClass.backgroundColor,
        title: Container(
          decoration: BoxDecoration(
              color: themeClass.primaryColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5))),
          height: 10.5.h,
          child: Padding(
            padding: EdgeInsets.only(
                // left: 1.5.w,
                top: 1.5.h),
            child: Consumer<PermataskController>(
                builder: (context, permataController, child) {
              return Column(
                children: [
                  const Text("Permanent Tasks",
                      style: TextStyle(color: Colors.white)),

                  // SizedBox(height: 2.h,),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ToggleSwitch(
                        inactiveFgColor: Colors.white,
                        initialLabelIndex: selectedTab,
                        totalSwitches: 3,
                        labels: const ['Doing', 'Done', 'All'],
                        onToggle: (index) {
                          selectedTab = index!;
                          permataskController.notify();
                        },
                      ),
                      // Switch(

                      //   value: isArchive, onChanged: (value){
                      //   isArchive=value;
                      //   permataskController.notify();
                      // }),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     // Container(
                  //     //   decoration: const BoxDecoration(border: Border(right: BorderSide(width: 1,color: Colors.white),top: BorderSide(width: 1,color: Colors.white))),
                  //     //   height: 4.h,
                  //     //   width: 20.w,
                  //     //   child: const Center(child: Text("To Do",style:TextStyle(color:Colors.white),)),
                  //     // ),
                  //     Container(
                  //       decoration: const BoxDecoration(border: Border(right: BorderSide(width: 1,color: Colors.white),top: BorderSide(width: 1,color: Colors.white))),
                  //       height: 4.h,
                  //       width: 20.w,
                  //       child: const Center(child: Text("Doing",style:TextStyle(color:Colors.white)),),
                  //     ),
                  //     Container(
                  //       decoration:
                  //       const BoxDecoration(border: Border(top: BorderSide(width: 1,color: Colors.white))),
                  //       height: 4.h,
                  //       width: 20.w,
                  //       child: const Center(child: Text("Done",style:TextStyle(color:Colors.white))),
                  //     ),

                  //   ],
                  // )
                  SizedBox(
                    height: 0.5.h,
                  )
                ],
              );
            }),
          ),
        ),
        actionsPadding: EdgeInsets.only(bottom: 1.h),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    "Close",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ],
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          height: 60.h,
          width: 20.w,
          child: Consumer<PermataskController>(
              builder: (context, permataskController, child) {
            return FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return SizedBox(
                      width: 20.w,
                      height: 50.h,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // for (Permatask todo in permataskController.permatasks)
                          Container(
                            // height: 50.h,
                            constraints: BoxConstraints(maxHeight: 50.h),
                            child: ListView.builder(
                                primary: true,
                                shrinkWrap: true,
                                // padding: EdgeInsets.zero,
                                itemCount:
                                    permataskController.permatasks.length,
                                itemBuilder: ((context, index) {
                                  if (selectedTab == 0) {
                                    return (permataskController
                                                .checks[index] ==
                                            false)
                                        ? PermaTaskCard(
                                            permatask: permataskController
                                                .permatasks[index],
                                            permataskController:
                                                permataskController,
                                            index: index)
                                        : const SizedBox();
                                  } else if (selectedTab == 1) {
                                    return (permataskController
                                                .checks[index] ==
                                            true)
                                        ? PermaTaskCard(
                                            permatask: permataskController
                                                .permatasks[index],
                                            permataskController:
                                                permataskController,
                                            index: index)
                                        : const SizedBox();
                                  } else {
                                    return PermaTaskCard(
                                        permatask: permataskController
                                            .permatasks[index],
                                        permataskController:
                                            permataskController,
                                        index: index);
                                  }
                                })),
                          ),

                          if (isArchive == false)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AddPermataskDialog(
                                            employee: employee);
                                      });
                                },
                                child: const Icon(Icons.add),
                              ),
                            )
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          }),
        ));
  }
}

class PermaTaskCard extends StatefulWidget {
  final PermataskController permataskController;
  final int index;
  const PermaTaskCard({
    super.key,
    required this.permatask,
    required this.permataskController,
    required this.index,
  });

  final Permatask permatask;

  @override
  State<PermaTaskCard> createState() => _PermaTaskCardState(
        permataskController,
        index: index,
      );
}

class _PermaTaskCardState extends State<PermaTaskCard> {
  // bool isChecked=false;
  final int index;
  final PermataskController permataskController;
  bool expanded = false;

  _PermaTaskCardState(this.permataskController, {required this.index});
  @override
  Widget build(BuildContext context) {
    // (permataskController.permatasks[index].status=="Pending")?isChecked=false:true;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<PermataskController>(
          builder: (context, permataskController, child) {
        return SizedBox(
          height: (expanded == true) ? 13.h : 4.h,
          child: InkWell(
            onTap: () {
              expanded = !expanded;
              permataskController.notify();
            },
            child: Card(
              color: (permataskController.checks[index] == false)
                  ? Color(int.parse(
                          permataskController.permatasks[index].color!,
                          radix: 16))
                      .withOpacity(0.4)
                  : const Color(0xffa6a5a2),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // leading: (permatask.status=="Pending")?null:IconButton(onPressed: (){
                        //   permataskController.downgradePermatask(permatask: permatask);
                        // }, icon: const Icon(Icons.arrow_circle_left_outlined)),
                        // trailing: (permatask.status=="Done")?null:IconButton(onPressed: (){
                        //   permataskController.upgradePermatask(permatask: permatask);
                        // }, icon: const Icon(Icons.arrow_circle_right_outlined)),
                        // onTap: () {

                        // },
                        // trailing: permatask.,
                        children: [
                          Text(permataskController.permatasks[index].title!),
                          Container(
                            child: Checkbox(
                                value: permataskController.checks[index],
                                onChanged: (value) {
                                  permataskController.changeState(index);
                                }),
                          ),
                        ]

                        // subtitle: Text(permataskController.permatasks[index].description!),
                        ),
                    if (expanded)
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(permataskController
                                  .permatasks[index].description!),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // FloatingActionButton.small(onPressed: (){},

                              //   backgroundColor:
                              //                         const Color.fromARGB(
                              //                             255, 194, 122, 7),
                              // child: Icon(Icons.edit,color: Colors.white,),
                              // ),
                              // SizedBox(width: 1.w,),
                              FloatingActionButton.small(
                                backgroundColor:
                                    const Color.fromARGB(255, 200, 24, 11),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          ConfirmDeletePermataskDialog(
                                              title: "Delete Permanent Task",
                                              content:
                                                  "Are you sure you want to delete this permanent task!!!",
                                              rowIndex: index));
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          )
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
