class CampaignModel {
  final int id;
  final String name;
  final DateTime start;
  final DateTime end;
  final String description;
  final String itemTypeTagName;
  final String purposeTagName;
  final String itemTypeTagColor;
  final String purposeTagColor;
  final double lat;
  final double lng;
  final int zipcode;
  final String street;
  final String city;
  final int number;
  final String state;
  final String adonatorName;
  final String adonatorEmail;

  const CampaignModel({
    this.id,
    this.name,
    this.start,
    this.end,
    this.description,
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
    this.adonatorEmail
  });
}
