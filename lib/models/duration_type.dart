class DurationType {
  int? id;
  String? created;
  String? unit;
  int? count;

  DurationType({this.id, this.created, this.unit, this.count});

  DurationType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    unit = json['unit'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['unit'] = unit;
    data['count'] = count;
    return data;
  }
}
