import 'package:project_calendar/models/duration_type.dart';

class Project {
  int? id;
  String? color;
  String? description;
  int? duration;
  DateTime? deadline;
  List<String>? employees;
  DateTime? startingDate;
  String? name;
  DurationType? durationType;
  List<String>? tasks;
  bool? isDeleted;
  Project(
      {this.duration,
      this.color,
      this.description,
      this.isDeleted,
      this.durationType,
      this.deadline,
      this.employees,
      this.startingDate,
      this.name,
      this.tasks});

  Project.fromJson(Map<String, dynamic> json) {
    id=json['id'];
    description=json['description'];
    color=json['color'];
    isDeleted=json['is_deleted'];
    duration = json['duration'];
    durationType = DurationType.fromJson(json['duration_type']);
    deadline = DateTime.parse(json['deadline']) ;
    startingDate = DateTime.parse(json['starting_date']) ;
    name = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id']=id;
    data['description']=description;
    data['color'] = color;
    data['is_deleted']=isDeleted;
    data['duration'] = duration;
    data['duration_type_id'] = durationType!.id;
    data['deadline'] = deadline!.year.toString()+'-'+deadline!.month.toString()+"-"+deadline!.day.toString();
    data['starting_date'] = startingDate!.year.toString()+'-'+startingDate!.month.toString()+"-"+startingDate!.day.toString();
    data['title'] = name;
    return data;
  }
}
