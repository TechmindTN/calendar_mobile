import 'package:project_calendar/network/apis.dart';
import 'package:dio/dio.dart';

class NoteNetwork {
  APIS apis = APIS();

  getTaskNotes(id) async {
    Response res = await apis.dio
        .get(apis.baseUrl + apis.taskNotes, queryParameters: {"task": id});
    return res;
  }

  addNote(data) async {
    print('added');
    // DocumentReference res =await db.collection("Task").add(data);
    Response res = await apis.dio.post(apis.baseUrl + apis.addNote, data: data);
    return res;
  }

  deleteNote(int id) async {
    print('deleted');
    Response res =
        await apis.dio.delete("${apis.baseUrl}${apis.deleteNote}$id/");
    return res;
    // await db.collection("Task").doc(id).delete();
  }

  editNote({required String id, required Map<String, dynamic> data}) async {
    //print(apis.baseUrl+apis.editTask+id+"/");
    //print(data);
    // var res =await db.collection("Task").doc(id).update(data);
    Response res =
        await apis.dio.put("${apis.baseUrl}${apis.editNote}$id/", data: data);

    return res;
  }
  migrateNotes({ required Map<String, dynamic> data}) async {
    //print(apis.baseUrl+apis.editTask+id+"/");
    //print(data);
    // var res =await db.collection("Task").doc(id).update(data);
    Response res =
        await apis.dio.put("${apis.baseUrl}${apis.migrateNotes}", data: data);

    return res;
  }
}
