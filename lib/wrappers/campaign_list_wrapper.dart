import 'package:adonate/model/RemoteCampaignModel.dart';

class CampaignListWrapper {
  List<RemoteCampaignModel>? campaigns;

  CampaignListWrapper();

  CampaignListWrapper.fromJson(List<dynamic>? json) {
    if (json == null) return;

    campaigns =
        json.map(((result) => RemoteCampaignModel.fromJson(result))).toList();
  }
}
