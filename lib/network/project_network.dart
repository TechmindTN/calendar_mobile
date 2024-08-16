import 'package:project_calendar/network/apis.dart';
import 'package:dio/dio.dart';

class ProjectNetwork{
  APIS apis=APIS();
  getProjects() async {

    Response res =await apis.dio.get(apis.baseUrl+apis.getProjects);
    return res;
  }

  getDurationTypes() async {

    Response res =await apis.dio.get(apis.baseUrl+apis.getDurationTypes);
    return res;
  }

  addProject(data) async {
    Response res =await apis.dio.post(apis.baseUrl+apis.addProject,
    data: data
    );
    return res;
  }

  editProject({required String id,required Map<String,dynamic> data}) async {
    Response res =await apis.dio.put("${apis.baseUrl}${apis.editProject}$id/",
    data: data
    );
    return res;
  }

  deleteProject({required String id}) async {
    Response res = await apis.dio.delete(
      "${apis.baseUrl}${apis.editProject}$id/",
    );
    return res;
  }

  

}
