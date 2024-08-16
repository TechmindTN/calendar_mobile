class Department {
  int? id;
  String? created;
  String? name;

  Department({this.id, this.created, this.name});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['name'] = name;
    return data;
  }
}
