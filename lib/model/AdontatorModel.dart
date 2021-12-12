class AdonatorModel {
  int? id;
  String? name;
  String? email;

  AdonatorModel({
    this.id,
    this.name,
    this.email,
  });

  AdonatorModel.fromJson(
    Map<String, dynamic> json,
  ) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }
}
