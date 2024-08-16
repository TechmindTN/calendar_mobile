import 'package:project_calendar/models/user.dart';

class Note {
  int? id;
  User? user;
  String? note;
  DateTime? created;
  int? task;

  Note({this.id, this.user, this.note, this.created, this.task});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    note =  json['note'];
    created = DateTime.parse(json['created']);
    task = json['task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user_id'] = user!.id;
    }
    data['note'] = note;
    // data['created'] = this.created!.year.toString()+'-'+this.created!.month.toString()+"-"+this.created!.day.toString();;
    data['task'] = task;
    return data;
  }
}


