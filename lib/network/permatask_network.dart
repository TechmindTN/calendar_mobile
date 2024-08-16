import 'package:project_calendar/network/apis.dart';
import 'package:dio/dio.dart';

class PermataskNetwork {
  APIS apis=APIS();

  getPermatasks(employee) async {

    Response res=await apis.dio.get(apis.baseUrl+apis.getPermatasks,
    queryParameters: {'employee':employee}
    );
    return res;  
  }

  addPermatask(data) async {
    Response res=await apis.dio.post(apis.baseUrl+apis.addPermatask,
    data: data
    );
    return res;
  }

  deletePermatask(String id) async {
    Response res=await apis.dio.delete("${apis.baseUrl}${apis.deletePermatask}$id/");
    return res;
  }

  editPermatask({required int id,required Map<String,dynamic> data}) async {

    Response res = await apis.dio.put("${apis.baseUrl}${apis.editPermatask}$id/",
    data: data);
    
    return res;
  }

  tasksByProject(id) async {
    Response res=await apis.dio.get(apis.baseUrl+apis.getPermatasks,
    queryParameters: {'project':id}

    );

    return res;
  }
}
