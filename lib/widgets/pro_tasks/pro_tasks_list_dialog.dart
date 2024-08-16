
// ignore_for_file: no_logic_in_create_state

import 'package:project_calendar/controllers/protask_controller.dart';
import 'package:project_calendar/models/project.dart';
import 'package:project_calendar/models/protask.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:project_calendar/widgets/pro_tasks/add_pro_task_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProTaskListDialog extends StatefulWidget {
  final Project project;

  // final int index;

  const ProTaskListDialog({
    super.key, required this.project,
    // required this.index,
  });
  @override
  State<ProTaskListDialog> createState() =>
      _ProTaskListDialogState(project: project);
}

class _ProTaskListDialogState extends State<ProTaskListDialog> {
  late Future future;
  final Project project;
  // final int index;
  ThemeClass themeClass = ThemeClass();
  // late ProjectController proController;
  late ProtaskController protaskController;
  int totalDuration=0;

  _ProTaskListDialogState({required this.project});
  // _ProjectHistoryDialogState({});
  // late Future future;


  @override
  void initState() {
    protaskController = Provider.of<ProtaskController>(context, listen: false);
    super.initState();
  }
  
@override
  Future<void> didChangeDependencies() async {
    // proController = Provider.of<ProjectController>(context, listen: false);
        
        future= protaskController.getProtasks(context, project);
    // future=proController.getProjectHistory(id:proController.projects[index].id,context:context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
                    scrollable: true,
                    backgroundColor: themeClass.backgroundColor,
                    
                      title: Container(
                        decoration:  BoxDecoration(
            color:  themeClass.primaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
                        height: 9.h,
                        child: Padding(
                          padding: EdgeInsets.only(
                            // left: 1.5.w, 
                            top: 1.5.h),
                          child:  Column(
                            children: [
                              const Text("Project Tasks",
                                  style: TextStyle(color: Colors.white)),
                                  
                                  SizedBox(height: 1.h,),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(border: Border(right: BorderSide(width: 1,color: Colors.white),top: BorderSide(width: 1,color: Colors.white))),
                                        height: 4.h,
                                        width: 20.w,
                                        child: const Center(child: Text("To Do",style:TextStyle(color:Colors.white),)),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(border: Border(right: BorderSide(width: 1,color: Colors.white),top: BorderSide(width: 1,color: Colors.white))),
                                        height: 4.h,
                                        width: 20.w,
                                        child: const Center(child: Text("Doing",style:TextStyle(color:Colors.white)),),
                                      ),
                                      Container(
                                        decoration: 
                                        const BoxDecoration(border: Border(top: BorderSide(width: 1,color: Colors.white))),
                                        height: 4.h,
                                        width: 20.w,
                                        child: const Center(child: Text("Done",style:TextStyle(color:Colors.white))),
                                      ),
                                      
                                      
                                    ],
                                  )
                            ],
                          ),
                        ),
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
                      width: 60.w,
                      child: Consumer<ProtaskController>(
                        builder: (context,protaskController,child) {
                          return FutureBuilder(
                            future: future,
                            builder: (context, snapshot) { 
                              
                              if(snapshot.connectionState==ConnectionState.done){
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   SizedBox(
                                    width: 20.w,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                         Container(
                                          constraints: BoxConstraints(maxHeight: 50.h),
                                           child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: protaskController.todotasks.length,
                                            itemBuilder: ((context, index) {
                                         
                                            return ProTaskCard(protask: protaskController.todotasks[index],protaskController: protaskController,index: index);
                                                                                 })),
                                         ),
                                        // for (Protask doing in protaskController.doingtasks)
                                        //   ProTaskCard(protask: doing,protaskController: protaskController,),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FloatingActionButton(onPressed: (){
                                              showDialog(context: context, builder: (context){
                                                                                
                                                return AddProtaskDialog(project: project,status: "Pending",);
                                            });
                                                                                
                                            },child: const Icon(Icons.add),),
                                          )
                                      ],
                                    ),
                                  ),
                                  
                                  SizedBox(
                                    width: 20.w,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                         Container(
                                          constraints: BoxConstraints(maxHeight: 50.h),
                                           child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: protaskController.doingtasks.length,
                                            itemBuilder: ((context, index) {
                                         
                                            return ProTaskCard(protask: protaskController.doingtasks[index],protaskController: protaskController,index: index);
                                                                                 })),
                                         ),
                                        // for (Protask doing in protaskController.doingtasks)
                                        //   ProTaskCard(protask: doing,protaskController: protaskController,),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FloatingActionButton(onPressed: (){
                                              showDialog(context: context, builder: (context){
                                                                                
                                                return AddProtaskDialog(project: project,status: "In progress",);
                                            });
                                                                                
                                            },child: const Icon(Icons.add),),
                                          )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                         Container(
                                          constraints: BoxConstraints(maxHeight: 50.h),
                                           child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: protaskController.donetasks.length,
                                            itemBuilder: ((context, index) {
                                         
                                            return ProTaskCard(protask: protaskController.donetasks[index],protaskController: protaskController,index: index,);
                                                                                 })),
                                         ),
                                        // for (Protask doing in protaskController.doingtasks)
                                        //   ProTaskCard(protask: doing,protaskController: protaskController,),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FloatingActionButton(onPressed: (){
                                              showDialog(context: context, builder: (context){
                                                                                
                                                return AddProtaskDialog(project: project,status: "Done",);
                                            });
                                                                                
                                            },child: const Icon(Icons.add),),
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                            else {
                                return const Center(child: CircularProgressIndicator(),);
                              }
                            });
                        }
                      ),
                     
                      
                     )
                   
                    )
                ;
  }
}

class ProTaskCard extends StatefulWidget {
  
  final ProtaskController protaskController;
  // final int index;
   const ProTaskCard({
    super.key,
    required this.protask, required this.protaskController, required this.index,
    //  required this.index,
  });

  final Protask protask;
  final int index;
  @override
  State<ProTaskCard> createState() => _ProTaskCardState(protaskController ,protask,index
  // index: index,
  );
}

class _ProTaskCardState extends State<ProTaskCard> {
  // bool isChecked=false;
  // final int index;
  final Protask protask;
  final ProtaskController protaskController;
  final int index;
  _ProTaskCardState(this.protaskController, this.protask, this.index, 
  // {required this.index}
  );
  @override
  Widget build(BuildContext context) {
    // (protaskController.protasks[index].status=="Pending")?isChecked=false:true;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<ProtaskController>(
        builder: (context,protaskController,child) {
          return SizedBox(
            // color: Color(int.parse(
            //          protask.color!,
            //           radix: 16))
            //       .withOpacity(0.4),
            height: 5.h,
            child: Card(
              color: Color(int.parse(
                     protask.color!,
                      radix: 16))
                  .withOpacity(0.4),
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 if((protask.status=="Done")||(protask.status=="In progress"))Padding(
                   padding: const EdgeInsets.only(bottom:8.0),
                   child: IconButton(onPressed: (){
                    protaskController.downgradeProtask(protask: protask);
                                 }, icon: const Icon(Icons.arrow_circle_left_outlined)),
                 ),
                
                 if(protask.status=="Pending")
                const SizedBox(),
                // trailing: protask.,
                // trailing: Container(
                //   child: Checkbox(value: protaskController.checks[index], onChanged: (value){
                //     protaskController.changeState(index);
                //   }),
                // ),
                 
                // (protaskController.checks[index]==false)?
                
          //                 :
          // Color(0xffa6a5a2)              
            
                
                 Text(protask.title!),
                 if((protask.status=="Pending")||(protask.status=="In progress"))Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                   child: IconButton(onPressed: (){
                    protaskController.upgradeProtask(protask: protask,);
                                 }, icon: const Icon(Icons.arrow_circle_right_outlined)),
                 ),
                 if(protask.status=="Done")
                const SizedBox()
                                        
                
              
        ]
              ),
            ),
          );
        }
      ),
    );
  }
}
