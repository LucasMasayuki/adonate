import 'package:adonate/model/RemoteCampaignModel.dart';
import 'package:adonate/model/TagModel.dart';

class TagWrapper {
  late List<TagModel> tags;

  TagWrapper();

  TagWrapper.fromJson(List<dynamic>? json) {
    if (json == null) return;

    tags = json.map(((result) => TagModel.fromJson(result))).toList();
  }
}
