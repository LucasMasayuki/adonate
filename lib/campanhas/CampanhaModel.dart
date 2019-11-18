class CampanhaModel {
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
  final String adonatorName;
  final String adonatorEmail;

  const CampanhaModel({
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
    this.adonatorName,
    this.adonatorEmail
  });
}
