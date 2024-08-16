import 'package:project_calendar/models/department.dart';
import 'package:project_calendar/models/user.dart';

class Employee {
  int? id;
  Department? department;
  String? name;
  User? user;
  Employee({this.department, this.name,this.user,this.id});

  Employee.fromJson(Map<String, dynamic> json) {
    id=json['id'];
    department = Department.fromJson(json['department']);
    name = json['name'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id']=id;
    data['department_id'] = department!.id;
    data['name'] = name;
    data['user_id'] = user!.id;
    return data;
  }
}
