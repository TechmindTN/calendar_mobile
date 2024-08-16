import 'package:project_calendar/controllers/device_controller.dart';
import 'package:project_calendar/controllers/note_controller.dart';
import 'package:project_calendar/controllers/task_controller.dart';
import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/models/note.dart';
import 'package:project_calendar/screens/calendar/dialogs/confirm_delete_note_dialog.dart';
import 'package:project_calendar/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class NoteWidget extends StatelessWidget {
  final UserController userController;
    final NoteController noteController;
    final String color;

  const NoteWidget({
    super.key,
    required this.note, required this.userController, required this.noteController, required this.color,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return 
        Column(
          children: [
            Card(
              child: ListTile(
                // contentPadding: EdgeInsets.zero,
                    // tileColor: Colors.white,
                    isThreeLine: true,
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: SelectableText(note.user!.username!),
                    subtitle: SelectableText(note.note!),
                    trailing: Container(
                      
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SelectableText( DateFormat('yyyy-MM-dd  kk:mm').format(note.created!)),
                         
                         if(userController.currentUser.id==note.user!.id)
                         Row(
                           children: [
                             const VerticalDivider(),
                             Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                              Container(
                                // height: 9.h,
                                // width: 4.w,
                                // color: Colors.red,
                                child: FloatingActionButton.small(onPressed: (){
                                  showDialog(context: context, builder: (context){
                                    return ConfirmDeleteNoteDialog(title: "Delete Note",
                                            content:
                                                "Are you sure you want to delete this note!!!" ,note: note, noteController: noteController);
                                });
                                  // noteController.deleteNote(note.id);
                                },
                                backgroundColor: Colors.red,
                                child: const Icon(Icons.delete,color: Colors.white,),
                                ),
                              )
                            ],),
                          )
                           ],
                         ),
                          
                        ],
                      ),
                    )
                  ),
            ),
            Container(
              height: 1.h,
              color: Color(int.parse(
                      color,
                      radix: 16))
                  .withOpacity(0.8),
            )
          ],
        );
            
      
  }
}


class AddNoteWidget extends StatelessWidget {
  const AddNoteWidget({
    super.key,
    required this.deviceController,
    required this.noteTextController,
    required this.noteController,
    required this.taskController,
    required this.themeClass,
  });

  final DeviceController deviceController;
  final TextEditingController noteTextController;
  final NoteController noteController;
  final TaskController taskController;
  final ThemeClass themeClass;

  @override
  Widget build(BuildContext context) {
    return ListTile(
                      contentPadding: EdgeInsets.zero,
                    //   leading:IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,
                    // size: 30,
                    // color: themeClass.primaryColor,
                    // )),
                      tileColor: Colors.transparent,
                      // isThreeLine: true,
                      // subtitle: SizedBox(),
                      title: Container(
                        constraints: const BoxConstraints(maxWidth: 10),
                  padding: EdgeInsets.only(left: 0.w, top: 1.h),
                  height: 10.h,
                  width:10,
                  //  (deviceController.device == "Desktop") ? 25.w : 50.w,
                  child: TextField(
                    
                    // onTap: ,
                    // onTapOutside: ,
                    // onChanged: ,
                    maxLength: 200,
                    
                    buildCounter: (context, {required currentLength, required isFocused, maxLength}) => Text(
                  '$currentLength/$maxLength characters',
                  semanticsLabel: 'character count',
                                
                ),
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    style: GoogleFonts.ubuntu(
                        textStyle: const TextStyle(color: Colors.black)),
                    controller: noteTextController,
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.ubuntu(
                            textStyle: const TextStyle(color: Colors.black)),
                        hintText: "Add Note",
                        filled: true,
                        fillColor: Colors.white,
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
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(onPressed: (){
                            noteController.addNote(id: taskController.selectedTask!.id,context: context,txt: noteTextController.text);
                            noteTextController.text="";
                          },
                          
                          backgroundColor: themeClass.primaryColor,
                          
                          child: const Icon(Icons.send,
                          color: Colors.white,
                          ),
                          ),
                        ],
                      ),
                    );
  }
}
