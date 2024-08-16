import 'package:project_calendar/network/apis.dart';
import 'package:dio/dio.dart';

class EmployeeNetwork{
  APIS apis=APIS();

  getDepartments() async {

  Response res =await apis.dio.get(apis.baseUrl+apis.getDepartments);
    return res;
  }

  getEmployees() async {

  Response res =await apis.dio.get(apis.baseUrl+apis.getEmployees);
    return res;
  }

  addEmployee(data) async {
    Response res=await apis.dio.post(apis.baseUrl+apis.addEmployee,
    data: data
    );
    return res;
  }

  deleteEmployee({required id})async  {
    Response res =await apis.dio.delete("${apis.baseUrl+apis.deleteEmployee+id}/");
    return res; 
  }

  editEmployee({Map<String,dynamic>? data,String? id}) async {
    Response res =await apis.dio.put("${apis.baseUrl}${apis.editEmployee}${id!}/",
    data: data
    );
    return res;
  }


}
