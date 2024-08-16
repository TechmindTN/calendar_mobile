import 'package:project_calendar/models/employee.dart';

class Permatask {
  int? id;
  String? status;
  String? title;
  // int? duration;
  // Project? project;
  String? color;
  // DateTime? date;
  Employee? employee;
  String? description;
  // int? priority;
  Permatask(
      {this.status,
      // this.priority,
      this.title,
      // this.duration,
      // this.project,
      this.color,
      // this.date,
      this.employee,
      this.description,
      this.id});

  Permatask.fromJson(Map<String, dynamic> json) {
    id=json['id'];
    status = json['status'];
    // priority = json['priority'];
    title = json['title'];    
    // duration = json['duration'];
    // project = Project.fromJson(json['project']) ;
    color = json['color'];
    // date = DateTime.parse(json['date']);
    employee = Employee.fromJson(json['employee']) ;
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id']=id;
    data['status'] = status;
    data['title'] = title;
    // data['duration'] = duration;
    // data['project_id'] = project!.id;
    data['color'] = color;
    // data['date'] = date!.year.toString()+'-'+date!.month.toString()+"-"+date!.day.toString();
    data['employee_id'] = employee!.id;
    data['description'] = description;
    // data['priority'] = priority;
    return data;
  }
}
