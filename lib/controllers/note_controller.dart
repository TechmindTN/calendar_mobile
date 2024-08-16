import 'package:project_calendar/controllers/user_controller.dart';
import 'package:project_calendar/models/note.dart';
import 'package:project_calendar/network/note_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteController extends ChangeNotifier {
  List<Note> notes = [];
  NoteNetwork noteNetwork = NoteNetwork();

  getTaskNotes(int id) async {
    notes.clear();
    Response res = await noteNetwork.getTaskNotes(id);

    if (res.statusCode == 200) {
      
      for (int i = 0; i < res.data.length; i++) {
        Note note = Note.fromJson(res.data[i]);
        notes.add(note);
        notifyListeners();
      }
    }
    notifyListeners();
  }

  addNote({required id,required String txt,required context}) async {
    Note note=Note(
      note: txt,
      task: id,
      user: Provider.of<UserController>(context,listen: false).currentUser,
    );
    Map<String,dynamic> data=note.toJson();
    Response res=await noteNetwork.addNote(data);
    note=Note.fromJson(res.data);
    notes.add(note);
    notifyListeners();
  }


  migrateNotes({required int oldId, required int newId}) async {
    Map<String,dynamic> data={
      'old':oldId,
      'new':newId
    };
    Response res = await noteNetwork.migrateNotes( data: data);
    return res;
  }

  deleteNote(id) async {
    Response res=await noteNetwork.deleteNote(id);
    if(res.statusCode==204){
      notes.removeWhere((element) => element.id==id);
      notifyListeners();
    }
    notifyListeners();
  }

}
