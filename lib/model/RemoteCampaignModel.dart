import 'package:adonate/model/AddressModel.dart';

import 'AdontatorModel.dart';
import 'TagModel.dart';

class RemoteCampaignModel {
  int? id;
  late String name;
  late DateTime start;
  DateTime? end;
  late String description;
  List<String>? campaignPhoto;
  List<TagModel>? tagCampaign;
  AdonatorModel? adonator;
  AddressModel? address;

  RemoteCampaignModel({
    this.id,
    required this.name,
    required this.start,
    this.end,
    required this.description,
    this.tagCampaign,
    this.adonator,
    this.address,
  });

  RemoteCampaignModel.fromJson(
    Map<String, dynamic> json,
  ) {
    id = json['id'];
    name = json['name'];
    start = DateTime.parse(json['start']);
    end = DateTime.parse(json['end']);
    description = json['description'];
    campaignPhoto = json['campaignPhoto'];
    adonator = AdonatorModel.fromJson(json['adonator']);
    address = AddressModel.fromJson(json['address']);
    tagCampaign = (json['tag_campaign'] as List)
        .map((e) => TagModel.fromJson(e['tag']))
        .toList();
  }
}
