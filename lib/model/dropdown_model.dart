class DropdownModel {
  int? id;
  String? name;
  String? extratext;

  DropdownModel({this.id, this.name, this.extratext});

  DropdownModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    extratext = json['extratext'];
  }
}
