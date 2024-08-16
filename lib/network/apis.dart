import 'package:dio/dio.dart';

class APIS{
  // final BaseOptions options=BaseOptions(
  //   baseUrl: "http://192.168.1.132:8000/",

  // );
  final Dio dio=Dio(
    // options
  );
  // baseUrl: "http://192.168.1.132:8000/",
  // final String baseUrl="http://197.14.10.36:20002/";
  final String baseUrl="http://91.134.89.238:8000/";
    final String addUser="user/list/";
  final String login="user/login/";
  final String mobileLogin="user/mobile_login/";
  final String getUsers="user/list/";
  final String getUser="user/detail/";
  final String editUser="user/detail/";
  
  final String deleteUser="user/detail/";
  final String addEmployee="employee/list/";
  final String getEmployees="employee/list/";
  final String getEmployee="employee/detail/";
  final String editEmployee="employee/detail/";
  final String deleteEmployee="employee/detail/";
  final String addProject="project/list/";
  final String getProjects="project/list/";
  final String getProject="project/detail/";
  final String editProject="project/detail/";
  final String deleteProject="project/detail/";
  final String addTask="task/list/";
  final String getTasksMobile="task/list_mobile/";

  final String getTasks="task/list/";
  final String getTask="task/detail/";
  final String editTask="task/detail/";
  final String deleteTask="task/detail/";
  final String addDepartment="department/list/";
  final String getDepartments="department/list/";
  final String getDepartment="department/detail/";
  final String editDepartment="department/detail/";
  final String deleteDepartment="department/detail/";
  final String addDurationType="duration_type/list/";
  final String getDurationTypes="duration_type/list/";
  final String getDurationType="duration_type/detail/";
  final String editDurationType="duration_type/detail/";
  final String deleteDurationType="duration_type/detail/";
  final String taskNotes="note/list/";
  final String addNote="note/list/";
  final String editNote="note/detail/";
  final String deleteNote="note/detail/";
  final String migrateNotes="note/migrate/";
  final String getPermatasks="perma/list/";
  final String addPermatask="perma/list/";
  final String editPermatask="perma/detail/";
  final String deletePermatask="perma/detail/";
    final String getProtasks="pro/list/";
  final String addProtask="pro/list/";
  final String editProtask="pro/detail/";
  final String deleteProtask="pro/detail/";

  // final String deleteDurationType="duration_type/detail/";
}