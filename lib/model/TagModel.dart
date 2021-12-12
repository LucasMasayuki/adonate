class TagModel {
  int? id;
  String? color;
  String? name;
  String? tag_type;

  TagModel({
    this.id,
    required this.name,
    required this.color,
    this.tag_type,
  });

  TagModel.fromJson(
    Map<String, dynamic> json,
  ) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    tag_type = json['tag_type'];
  }
}
