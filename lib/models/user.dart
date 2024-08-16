// ignore_for_file: void_checks


import 'package:project_calendar/models/employee.dart';

class User {
  int? id;
  String? password;
  void lastLogin;
  bool? isSuperuser;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  bool? isStaff;
  bool? isActive;
  String? dateJoined;
  List<void>? groups;
  List<void>? userPermissions;
  Employee? employee;

  User(
      {this.id,
      this.password,
      this.lastLogin,
      this.isSuperuser,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.isStaff,
      this.isActive,
      this.dateJoined,
      this.employee
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    // employee = Employee.fromJson(json['employee']);
    lastLogin = json['last_login'];
    isSuperuser = json['is_superuser'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    isStaff = json['is_staff'];
    isActive = json['is_active'];
    dateJoined = json['date_joined'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    // data['emplpyee'] = employee!.toJson();
    data['is_superuser'] = isSuperuser;
    data['username'] = username;

    data['is_active'] = isActive;
    
    return data;
  }
}


