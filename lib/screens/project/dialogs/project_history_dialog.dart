import 'package:project_calendar/controllers/project_controller.dart';
import 'package:project_calendar/controllers/task_controller.dart';
import 'package:project_calendar/models/task.dart';
import 'package:project_calendar/screens/calendar/dialogs/task_details_dialog.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProjectHistoryDialog extends StatefulWidget {
  final int index;

  const ProjectHistoryDialog({
    super.key,
    required this.index,
  });
  @override
  // ignore: no_logic_in_create_state
  State<ProjectHistoryDialog> createState() =>
      _ProjectHistoryDialogState(index: index);
}

class _ProjectHistoryDialogState extends State<ProjectHistoryDialog> {
  final int index;
  ThemeClass themeClass = ThemeClass();
  late ProjectController proController;
  late TaskController taskController;
  int totalDuration=0;
  _ProjectHistoryDialogState({required this.index});
  late Future future;



  
@override
  void didChangeDependencies() {
    proController = Provider.of<ProjectController>(context, listen: false);
        taskController = Provider.of<TaskController>(context, listen: false);

    future=proController.getProjectHistory(id:proController.projects[index].id,context:context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                    scrollable: true,
                    backgroundColor: themeClass.backgroundColor,
                      title: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration:  BoxDecoration(
            color:  themeClass.primaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
                            height: 6.h,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 0.9.w, 
                              top: 2.h
                              ),
                              child:  Text("${proController.projects[index].name!} history",
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                          Container(
                            color: themeClass.primaryColor,
                                    
                            child: ListTile(
                                    textColor: Colors.white,
                                    tileColor: themeClass.primaryColor,
                                    
                                    leading: SizedBox(
                                      width: 6.w,
                                      child: const Text("Employee",style: TextStyle(fontSize: 18),)),
                                    title: const Text("Details",style: TextStyle(fontSize: 18),),
                                    trailing: const Text("Date & Duration",style: TextStyle(fontSize: 18),),
                                  ),
                          ),
                        ],
                      ),
                      actionsPadding: EdgeInsets.only(bottom:1.h),
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
                      width: 30.w,
                       child: FutureBuilder(future: future,
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
                          if(snapshot.connectionState==ConnectionState.done){
                            List<dynamic> projectTasks=snapshot.data;
                            return SizedBox(
                              height: 60.h,
                              width: 20.w,
                             

                             child: Container(
                              constraints: BoxConstraints(maxHeight: 50.h),
                               child: ListView.builder(
                                  itemCount: projectTasks.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context,i){
                                  
                                  
                                  Task task=Task.fromJson(projectTasks[i]); 
                                  totalDuration+=task.duration!;
                                  proController.notify();
                                  return ListTile(
                                    onTap: () {
                                      taskController.selectedTask=task;
                                      showDialog(context: context, builder: ((context) {
                                        return TaskDetailDialog(task: task, );
                                      }));
                                    },
                                    isThreeLine: true,
                                  
                                    leading: SizedBox(
                                      width: 6.w,
                                      child: Text(task.employee!.name!)),
                                  title: Text(task.title!),
                                  subtitle: Text(task.description!),
                                  
                                  trailing: Column(
                                    children: [
                                     
                                      Text('${task.date!.year}-${(task.date!.month.toString().length==1)?'0${task.date!.month}':task.date!.month.toString()}-${(task.date!.day.toString().length==1)?'0${task.date!.day}':task.date!.day.toString()}'),
                                      SizedBox(height: 1.h,),
                                       Text("${task.duration} hours"),
                                    ],
                                  ),
                                  tileColor: (i.isEven)?Colors.white:Colors.grey.shade300,
                                  
                                );}),
                             ),
                            );
                            
                          
                          }
                          else{ return const Center(child: CircularProgressIndicator());}
                         },
                        ),
                     )
                   
                    );
  }
}
