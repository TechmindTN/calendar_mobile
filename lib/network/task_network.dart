import 'package:project_calendar/network/apis.dart';
import 'package:dio/dio.dart';

class TaskNetwork {
  APIS apis=APIS();
  getTasks() async {

    Response res=await apis.dio.get(apis.baseUrl+apis.getTasks);
    return res;  
  }

   getTasksMobile(data) async {

    Response res=await apis.dio.post(apis.baseUrl+apis.getTasksMobile,
    data: data
    );
    return res;  
  }

  addTask(data) async {
    Response res=await apis.dio.post(apis.baseUrl+apis.addTask,
    data: data
    );
    return res;
  }

  deleteTask(String id) async {
    Response res=await apis.dio.delete("${apis.baseUrl}${apis.deleteTask}$id/");
    return res;
  }

  editTask({required String id,required Map<String,dynamic> data}) async {

    Response res = await apis.dio.put("${apis.baseUrl}${apis.editTask}$id/",
    data: data);
    
    return res;
  }

  tasksByProject(id) async {
    Response res=await apis.dio.get(apis.baseUrl+apis.getTasks,
    queryParameters: {'project':id}

    );

    return res;
  }
}
