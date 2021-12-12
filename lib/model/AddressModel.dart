import 'TagModel.dart';

class AddressModel {
  String? city;
  String? lat;
  String? lng;
  int? number;
  String? state;
  String? street;
  int? zipcode;

  AddressModel({
    this.city,
    this.lng,
    this.lat,
    this.number,
    this.state,
    this.street,
    this.zipcode,
  });

  AddressModel.fromJson(
    Map<String, dynamic> json,
  ) {
    city = json['city'];
    lng = json['lng'];
    lat = json['lat'];
    number = json['number'];
    state = json['state'];
    street = json['street'];
    zipcode = json['zipcode'];
  }
}
