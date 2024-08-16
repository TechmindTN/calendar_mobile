import 'package:project_calendar/network/apis.dart';
import 'package:dio/dio.dart';

class ProtaskNetwork {
  APIS apis=APIS();

  getProtasks(project) async {

    Response res=await apis.dio.get(apis.baseUrl+apis.getProtasks,
    queryParameters: {'project':project}
    );
    return res;  
  }

  addProtask(data) async {
    Response res=await apis.dio.post(apis.baseUrl+apis.addProtask,
    data: data
    );
    return res;
  }

  deleteProtask(String id) async {
    Response res=await apis.dio.delete("${apis.baseUrl}${apis.deleteProtask}$id/");
    return res;
  }

  editProtask({required int id,required Map<String,dynamic> data}) async {

    Response res = await apis.dio.put("${apis.baseUrl}${apis.editProtask}$id/",
    data: data);
    
    return res;
  }

  tasksByProject(id) async {
    Response res=await apis.dio.get(apis.baseUrl+apis.getProtasks,
    queryParameters: {'project':id}

    );

    return res;
  }
}
