// ignore_for_file: no_logic_in_create_state

import 'package:project_calendar/controllers/device_controller.dart';
import 'package:project_calendar/controllers/note_controller.dart';
import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/models/task.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/task_controller.dart';

class TaskDetailDialog extends StatefulWidget {
  final int? k;
  final int? l;
  final int? m;
  final Task? task;
  const TaskDetailDialog(
      {super.key,  this.k,  this.l,  this.m,  this.task});

  @override
  State<TaskDetailDialog> createState() => _TaskDetailDialogState(k, l, m,task);
}

class _TaskDetailDialogState extends State<TaskDetailDialog> {
  final int? k;
  final int? l;
  final int? m;
  final Task? task;
  late TaskController taskController;
    late NoteController noteController;

  late UserController userController;
  late DeviceController deviceController;
  ThemeClass themeClass = ThemeClass();
  late Color textColor;
  _TaskDetailDialogState(this.k, this.l, this.m, this.task);
  TextEditingController noteTextController=TextEditingController();
  @override
  void initState() {
    noteController = Provider.of<NoteController>(context, listen: false);
    taskController = Provider.of<TaskController>(context, listen: false);
    noteController.getTaskNotes(taskController.selectedTask!.id!);
    userController = Provider.of<UserController>(context, listen: false);
    deviceController = Provider.of<DeviceController>(context, listen: false);
textColor=taskController.getTextColor(Color(int.parse(taskController.selectedTask!.color!, radix: 16))
                      .withOpacity(0.8),);
    super.initState();
  }
  @override
  void dispose() {
    noteController.notes.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.transparent,
      // body:
       return AlertDialog(
        
        // scrollable: true,
        // sc
        backgroundColor: Color(int.parse(
          taskController.selectedTask!.color!,
                // taskController.currentTasks[k!][l!][m!]!.color!,
                radix: 16))
            .withOpacity(0.8),
        titlePadding: EdgeInsets.zero,
        title: Container(
          padding: EdgeInsets.only(left: 1.5.w, right: 1.5.w),
          width: (deviceController.device == "Desktop") ? 40.w : 100.w,
          height: 6.h,
          decoration: BoxDecoration(
              color: Color(int.parse(
                taskController.selectedTask!.color!,
                      // taskController.currentTasks[k!][l!][m!]!.color!,
                      radix: 16))
                  .withOpacity(1),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(taskController.selectedTask!.title!,
                  style:  const TextStyle(color: Colors.white)),
              // ((userController.currentUser.isSuperuser==true)&&(deviceController.device=='Desktop')&&(task==null))?
              // Row(children: [
              //   FloatingActionButton.small(
              //     backgroundColor: const Color.fromARGB(255, 194, 122, 7),
              //     onPressed: (){
              //       Navigator.pop(context);
              //              showDialog(context: context, builder: (context)=>EditTaskDialog(k: k!, l: l!,m:m!));
              //     }, child: const Icon(Icons.edit, color: Colors.white,)),
              //     SizedBox(width: 1.w,),
              //   FloatingActionButton.small(
              //     backgroundColor: const Color.fromARGB(255, 200, 24, 11),
              //     onPressed: (){
              //        showDialog(context: context, builder: ((context) {
              //                 return const ConfirmDeleteTaskDialog(title: "Delete Task", content: "Are you sure you want to delete this task!!!");
              //               }));
              //     }, child: const Icon(Icons.delete, color: Colors.white)),

              // ],)
             
              //         :const SizedBox(),
            ],
          ),
        ),
        // actionsPadding: EdgeInsets.only(ri),
      
//         actions: [

//                     //   leading:IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,
//                     // size: 30,
//                     // color: themeClass.primaryColor,
//                     // )),
//                       // isThreeLine: true,
//                       // subtitle: SizedBox(),
//                       Row(
//                         children: [
//                           SizedBox(width: 1.w,),
//                           Container(
//                             // color: Colors.white,
//                             // constraints: BoxConstraints(maxWidth: 10,maxHeight: 10),
//                   padding: EdgeInsets.only(left: 0.w, top: 1.h),
//                   height: 100,
//                   width:(deviceController.device == "Desktop") ? 36.w : 50.w,
//                   //  (deviceController.device == "Desktop") ? 25.w : 50.w,
//                   child: TextField(
//                     maxLength: 200,
//                   //   buildCounter: (context, {required currentLength, required isFocused, maxLength}) => Text(
//                   // '$currentLength/$maxLength characters',
//                   // semanticsLabel: 'character count',
//                   //   ),
// expands: true,
//                     minLines: null,
//                     maxLines: null,
//                      style: GoogleFonts.ubuntu(
//                             textStyle: const TextStyle(color: Colors.black)),
//                     controller: noteTextController,
//                      decoration: InputDecoration(
//                            hintStyle: GoogleFonts.ubuntu(
//                                 textStyle: const TextStyle(color: Colors.black)),
//                             hintText: "Add Note",
//                              filled: true,
//                             fillColor: Colors.white,
//                                enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(5),
//                                 borderSide: BorderSide.none)
                            
//                      )
//                   ),
//                 //   child: TextField(
                    
//                 //     // onTap: ,
//                 //     // onTapOutside: ,
//                 //     // onChanged: ,
//                 //     maxLength: 200,
                    
//                 // //     buildCounter: (context, {required currentLength, required isFocused, maxLength}) => Text(
//                 // //   '$currentLength/$maxLength characters',
//                 // //   semanticsLabel: 'character count',
                                    
//                 // // ),
//                 //     // expands: true,
//                 //     // minLines: null,
//                 //     // maxLines: null,
//                 //     style: GoogleFonts.ubuntu(
//                 //         textStyle: const TextStyle(color: Colors.black)),
//                 //     controller: noteTextController,
//                 //     decoration: InputDecoration(
//                 //         hintStyle: GoogleFonts.ubuntu(
//                 //             textStyle: const TextStyle(color: Colors.black)),
//                 //         hintText: "Add Note",
//                 //         filled: true,
//                 //         fillColor: Colors.white,
//                 //         // label: Text(
//                 //         //   'Search...',
//                 //         //   style: GoogleFonts.ubuntu(
//                 //         //       textStyle: const TextStyle(color: Colors.white)),
//                 //         // ),
//                 //         enabledBorder: OutlineInputBorder(
//                 //             borderRadius: BorderRadius.circular(5),
//                 //             borderSide: BorderSide.none)),
//                 //   ),
//                 ),
//                 SizedBox(width: 1.w,),
//                 FloatingActionButton(onPressed: (){
//                          noteController.addNote(id: taskController.selectedTask!.id,context: context,txt: noteTextController.text);
//                          noteTextController.text="";
//                        },
                       
//                        backgroundColor: themeClass.primaryColor,
                       
//                        child: const Icon(Icons.send,
//                        color: Colors.white,
//                        ),
//                        ),
//                         ],
//                       ),
                       
                    
//           // AddNoteWidget(deviceController: deviceController, noteTextController: noteTextController, noteController: noteController, taskController: taskController, themeClass: themeClass),
                                      
                          
                        
                      
          
//         //   Center(child: ElevatedButton(
//         //   style: ElevatedButton.styleFrom(
//         //     backgroundColor: const Color(0Xff478CF3)
//         //   ),
//         //   child: const Text("Close"),onPressed: (){
//         //   Navigator.pop(context);
//         // },),)
//         ],
        content: SizedBox(
          height: 40.h,
          // height: 10000,
          // height: (deviceController.device=="Desktop")?44.h:80.h,
          width: 80.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Text(taskController.selectedTask!.title!,
            // style: TextStyle(color: textColor),
            // ),
          // Divider(),
              TaskRow(textColor: Colors.white, taskController: taskController,txt:"Date:",value:"${taskController.selectedTask!.date!.year}-${taskController.selectedTask!.date!.month}-${taskController.selectedTask!.date!.day}"),
              SizedBox(height: 1.h,),
              TaskRow(textColor: Colors.white, taskController: taskController, txt: "Duration:", value: "${taskController.selectedTask!.duration} Hours"),
              SizedBox(height: 1.h,),
                TaskRow(textColor: Colors.white, taskController: taskController, txt: "Priority:", value: taskController.selectedTask!.priority.toString()),
              SizedBox(height: 1.h,),
              const Divider(
                thickness: 1,
                color: Colors.white,
              ),
              SizedBox(height: 1.h,),

               TaskDesc(textColor: Colors.white, taskController: taskController, txt: "Project:", value: taskController.selectedTask!.project!.name.toString()),
               
                SizedBox(height: 1.h,),
                const Divider(
                thickness: 1,
                color: Colors.white,
              ),
              SizedBox(height: 1.h,),
                 TaskDesc(textColor: Colors.white, taskController: taskController, txt: "Description:", value: taskController.selectedTask!.description.toString()),
          ]),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   // mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Container(
          //       decoration: const BoxDecoration(
          //         color: Colors.white,
          //         boxShadow: <BoxShadow>[
          //           BoxShadow(
          //               color: Colors.black26,
          //               blurRadius: 15.0,
          //               offset: Offset(0.0, 0.75))
          //         ],
          //       ),
          //       padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
          //       width: (deviceController.device=="Desktop")?40.w:80.w,
          //       height: (deviceController.device=="Desktop")?25.h:50.h,
          //       child: GridView.count(crossAxisCount: (deviceController.device=="Desktop")?2:1,
          //       shrinkWrap: true,

          //       mainAxisSpacing: 0,
          //       crossAxisSpacing: 0,
          //       childAspectRatio: (deviceController.device=="Desktop")?8:5,
          //       children: [
          //           Row(
          //               children: [
          //                 SizedBox(
          //            width: (deviceController.device=="Desktop")?10.w:23.w,
          //            child: const Text(
          //              "Title: ",
          //              style: TextStyle(fontWeight: FontWeight.bold),
          //            ),
          //                 ),
          //                 Container(
          //                   constraints: BoxConstraints(
          //                     maxWidth: (deviceController.device=="Desktop")?8.w:30.w,
          //                   ),
          //            width: (deviceController.device=="Desktop")?8.w:30.w,
          //            child: Text(taskController.selectedTask!.title??'',maxLines: 2,))
          //               ]),
          //           Row(
          //             children: [
          //               SizedBox(
          //                 width: (deviceController.device == "Desktop")
          //                     ? 10.w
          //                     : 23.w,
          //                 child: const Text(
          //                   "Project:",
          //                   style: TextStyle(fontWeight: FontWeight.bold),
          //                 ),),
          //                  Container(
          //                     constraints: BoxConstraints(
          //                       maxWidth: (deviceController.device=="Desktop")?8.w:30.w,
          //                     ),
          //              width: (deviceController.device=="Desktop")?8.w:30.w,
          //            child: Text(taskController.selectedTask!.project!.name!))
          //               ]),
          //             Row(
          //               children: [
          //                 SizedBox(
          //                   width: (deviceController.device=="Desktop")?10.w:23.w,
          //                   child: const Text(
          //                     "Starting date:",
          //                     style: TextStyle(fontWeight: FontWeight.bold),
          //                   ),
          //                 ),
          //                   Container(
          //                     constraints: BoxConstraints(
          //                       maxWidth: (deviceController.device=="Desktop")?8.w:30.w,
          //                     ),
          //              width: (deviceController.device=="Desktop")?8.w:30.w,
          //                   child:  Text('${taskController.selectedTask!.date!.year}-${(taskController.selectedTask!.date!.month.toString().length==1)?'0${taskController.selectedTask!.date!.month}':taskController.selectedTask!.date!.month.toString()}-${(taskController.selectedTask!.date!.day.toString().length==1)?'0${taskController.selectedTask!.date!.day}':taskController.selectedTask!.date!.day.toString()}'))
          //               ],
          //             ),
          //             Row(
          //               children: [
          //                 SizedBox(
          //                   width: (deviceController.device=="Desktop")?10.w:23.w,
          //                   child: const Text(
          //                     "Ending date:",
          //                     style: TextStyle(fontWeight: FontWeight.bold),
          //                   ),
          //                 ),
          //                  Container(
          //                     constraints: BoxConstraints(
          //                       maxWidth: (deviceController.device=="Desktop")?8.w:30.w,
          //                     ),
          //              width: (deviceController.device=="Desktop")?8.w:30.w,
          //               child:  Text('${taskController.selectedTask!.date!.year}-${(taskController.selectedTask!.date!.month.toString().length==1)?'0${taskController.selectedTask!.date!.month}':taskController.selectedTask!.date!.month.toString()}-${(taskController.selectedTask!.date!.day.toString().length==1)?'0${taskController.selectedTask!.date!.day}':taskController.selectedTask!.date!.day.toString()}'))                       ],
          //             ),
                       
          //             Row(
          //               children: [
          //                 SizedBox(
          //                   width: (deviceController.device=="Desktop")?10.w:23.w,
          //                   child: const Text(
          //                     "Duration:",
          //                     style: TextStyle(fontWeight: FontWeight.bold),
          //                   ),
          //                 ),
          //                   Container(
          //                     constraints: BoxConstraints(
          //                       maxWidth: (deviceController.device=="Desktop")?8.w:30.w,
          //                     ),
          //              width: (deviceController.device=="Desktop")?8.w:30.w,
          //                   child: Text("${taskController.selectedTask!.duration} hours"))
          //               ],
          //             ),
          //               Row(
          //               children: [
          //             SizedBox(
          //               width: (deviceController.device == "Desktop")
          //                   ? 10.w
          //                   : 23.w,
          //               child: const Text(
          //                 "Employee: ",
          //                 style: TextStyle(fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //             Container(
          //                     constraints: BoxConstraints(
          //                       maxWidth: (deviceController.device=="Desktop")?8.w:30.w,
          //                     ),
          //              width: (deviceController.device=="Desktop")?8.w:30.w,
          //               child: Text(taskController.selectedTask!.employee!.name!))            
          //               ]),
          //             Row(
          //               // mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 SizedBox(
          //                   width:(deviceController.device=="Desktop")?10.w:23.w,
          //                   child: const Text(
          //                     "Priority:",
          //                     style: TextStyle(fontWeight: FontWeight.bold),
          //                   ),
          //                 ),
          //                  Container(
          //                     constraints: BoxConstraints(
          //                       maxWidth: (deviceController.device=="Desktop")?8.w:30.w,
          //                     ),
          //              width: (deviceController.device=="Desktop")?8.w:30.w,
          //              child:  Text(taskController.selectedTask!.priority.toString()),
          //                 ),
                          
          //               ],
          //             )
          //       ],
          //       ),
               
          //     ),
          //     SizedBox(height: 2.h,),
          //     Container(
          //       decoration: const BoxDecoration(
          //         color: Colors.white,
          //         boxShadow: <BoxShadow>[
          //           BoxShadow(
          //               color: Colors.black26,
          //               blurRadius: 15.0,
          //               offset: Offset(0.0, 0.75))
          //         ],
          //       ),
          //       padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
          //       width: (deviceController.device=="Desktop")?40.w:80.w,
          //       height: (deviceController.device=="Desktop")?16.h:25.h,
          //      child: Column(children: [
          //       const Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Text("Description",
          //           style: TextStyle(fontWeight: FontWeight.bold),
          //           ),
                    
          //         ],
          //       ),
          //         SizedBox(height:1.5.h),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             children: [
          //               Text(taskController.selectedTask!.description!)
          //           ],)
          //      ]),
          //     ),
          //     SizedBox(height: 2.h,),
          //     // Consumer<NoteController>(
          //     //   builder: (context,noteController,child) {
          //     //     return SizedBox(
          //     //       height: 28.h,
          //     //       child: ListView.builder(
          //     //         itemCount: noteController.notes.length,
          //     //         itemBuilder: ((context, index) => NoteWidget(note: noteController.notes[index], userController: userController, noteController: noteController,color: taskController.selectedTask!.project!.color!,))),
          //     //     );
                 
          //     // //     return ListView.builder(
                  
          //     // //       shrinkWrap: true,
          //     // //       itemCount: noteController.notes.length,
          //     // //       itemBuilder: ((context, index) {  
          //     // //         return ListTile(
          //     // //           tileColor: Colors.white,
          //     // //           isThreeLine: true,
          //     // //           leading: CircleAvatar(child: Icon(Icons.person)),
          //     // //           title: Text(noteController.notes[index].user!.username!),
          //     // //           subtitle: Text(noteController.notes[index].note!),
          //     // //           trailing: Text(noteController.notes[index].created!),
          //     // //         );
            
          //     // // })
          //     // // );
          //     //   }
          //     // ),
          //     // Container(
          //     //   decoration: const BoxDecoration(
          //     //     color: Colors.white,
          //     //     boxShadow: <BoxShadow>[
          //     //       BoxShadow(
          //     //           color: Colors.black26,
          //     //           blurRadius: 15.0,
          //     //           offset: Offset(0.0, 0.75))
          //     //     ],
          //     //   ),
          //     //   padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
          //     //   width: (deviceController.device == "Desktop") ? 40.w : 80.w,
          //     //   // height: (deviceController.device == "Desktop") ? 16.h : 25.h,
          //     //   child: Column(children: [
          //     //      Row(
          //     //       mainAxisAlignment: MainAxisAlignment.start,
          //     //       children: [
          //     //         Text(
          //     //           note.user!.username.toString(),
          //     //           style: TextStyle(fontWeight: FontWeight.bold),
          //     //         ),
          //     //       ],
          //     //     ),
          //     //     SizedBox(height: 1.5.h),
          //     //     Row(
          //     //       mainAxisAlignment: MainAxisAlignment.center,
          //     //       children: [
          //     //         Text(note.note!)
          //     //       ],
          //     //     )
          //     //   ]),
          //     // ),
          //     SizedBox(height: 3.h,)  
          //   ],
          // ),
        ),
      // ),
    );
  }


}

class TaskRow extends StatelessWidget {
  const TaskRow({
    super.key,
    required this.textColor,
    required this.taskController, required this.txt, required this.value,
  });
  final String txt;
  final String value;
  final Color textColor;
  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 22.w,
          child: Text(txt, style: TextStyle(color: textColor),)),
        SizedBox(width: 18.w,),
        Text(value,
            style: TextStyle(color: textColor),),
      ],
    );
  }
}


class TaskDesc extends StatelessWidget {
  const TaskDesc({
    super.key,
    required this.textColor,
    required this.taskController, required this.txt, required this.value,
  });
  final String txt;
  final String value;
  final Color textColor;
  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 22.w,
          child: Text(txt, style: TextStyle(color: textColor),)),
        SizedBox(height: 2.w,),
        Text(value,
            style: TextStyle(color: textColor),)
        // Container(
        //   width: 60.w,
        //   child: Text(value,
        //       style: TextStyle(color: textColor),),
        // ),
      ],
    );
  }
}



