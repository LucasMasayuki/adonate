class CampaignModel {
  int? id;
  late String name;
  late DateTime start;
  DateTime? end;
  late String description;
  String? itemTypeTagName;
  String? purposeTagName;
  String? itemTypeTagColor;
  String? purposeTagColor;
  double? lat;
  double? lng;
  int? zipcode;
  String? street;
  String? city;
  int? number;
  String? state;
  String? adonatorName;
  String? adonatorEmail;
  String? photoUrl;
  int? campaignId;

  CampaignModel({
    this.id,
    required this.name,
    required this.start,
    this.end,
    required this.description,
    this.itemTypeTagName,
    this.purposeTagName,
    this.itemTypeTagColor,
    this.purposeTagColor,
    this.lat,
    this.lng,
    this.zipcode,
    this.street,
    this.city,
    this.number,
    this.state,
    this.adonatorName,
    this.adonatorEmail,
    this.photoUrl,
    this.campaignId,
  });

  CampaignModel.fromJson(
    Map<String, dynamic> json,
  ) {
    id = json['id'];
    name = json['name'];
    start = json['start'];
    end = json['end'];
    description = json['description'];
    itemTypeTagName = json['itemTypeTagName'];
    purposeTagName = json['purposeTagName'];
    purposeTagColor = json['purposeTagColor'];
    itemTypeTagColor = json['itemTypeTagColor'];
    lat = json['lat'];
    lng = json['lat'];
    zipcode = json['zipcode'];
    street = json['street'];
    city = json['city'];
    number = json['number'];
    state = json['state'];
    adonatorName = json['adonatorName'];
    adonatorEmail = json['adonatorEmail'];
    photoUrl = json['photoUrl'];
    campaignId = json['campaignId'];
  }
}
