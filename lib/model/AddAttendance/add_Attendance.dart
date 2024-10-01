class AllNamesModel {
  final int id;
  final String name;

  AllNamesModel({required this.id, required this.name});

  factory AllNamesModel.fromJson(Map<String, dynamic> json) {
    return AllNamesModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
