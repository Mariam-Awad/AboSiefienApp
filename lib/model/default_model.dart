class DefaultModel {
  int? id;
  String? name;

  DefaultModel({this.id, this.name});

  DefaultModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
}
