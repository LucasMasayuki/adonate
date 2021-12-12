import 'package:adonate/model/RemoteCampaignModel.dart';
import 'package:adonate/model/SearchParamModel.dart';
import 'package:adonate/shared/dio.dart';
import 'package:adonate/wrappers/campaign_list_wrapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:adonate/activity/CampaignDetailActivity.dart';
import 'package:adonate/adapter/CampaignAdapter.dart';
import 'package:adonate/model/CampaignModel.dart';

class CampaignList extends StatefulWidget {
  const CampaignList({this.searchParam});
  final SearchParamModel? searchParam;

  @override
  State<StatefulWidget> createState() => CampaignListState();
}

class CampaignListState extends State<CampaignList> {
  @override
  Widget build(BuildContext context) {
    var campaignName = widget.searchParam?.campaignName;
    var itemType = widget.searchParam?.itemType;
    var purpouse = widget.searchParam?.purpouse;

    return Scaffold(
      body: FutureBuilder(
          future: widget.searchParam == null
              ? DioAdapter().get<dynamic>('api/campaigns/')
              : DioAdapter().get<dynamic>(
                  'api/filter_campaign?campaignName=$campaignName&purpouse=$purpouse&itemType=$itemType',
                ),
          builder: (context, AsyncSnapshot<Response<dynamic>?> projectSnap) {
            if (projectSnap.connectionState == ConnectionState.none &&
                projectSnap.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            if (!projectSnap.hasData || projectSnap.data!.statusCode != 200) {
              return Center(child: CircularProgressIndicator());
            }

            List<RemoteCampaignModel> campaigns = CampaignListWrapper.fromJson(
              projectSnap.data?.data!['results'],
            ).campaigns;

            if (campaigns.length == 0) {
              return Container(
                child: Center(
                  child: Text("Não foi encontrado nenhuma campanha"),
                ),
              );
            }

            return ListView.builder(
              itemCount: campaigns.length,
              itemBuilder: (context, index) {
                var adonatorName = campaigns[index].adonator?.name;
                var adonatorEmail = campaigns[index].adonator?.email;
                var purposeTag = campaigns[index].tagCampaign![0];
                var itemTypeTag = campaigns[index].tagCampaign![1];
                var lat = campaigns[index].address?.lat;
                var lng = campaigns[index].address?.lng;

                var photoUrl = '';
                if (campaigns[index].campaignPhoto != null &&
                    campaigns[index].campaignPhoto?.length != 0) {
                  photoUrl = campaigns[index].campaignPhoto![0];
                }

                CampaignModel campaign = CampaignModel(
                  name: campaigns[index].name,
                  description: campaigns[index].description,
                  start: campaigns[index].start,
                  end: campaigns[index].end,
                  itemTypeTagName: itemTypeTag.name,
                  purposeTagName: purposeTag.name,
                  itemTypeTagColor: itemTypeTag.color,
                  purposeTagColor: purposeTag.color,
                  lat: double.parse(lat ?? ''),
                  lng: double.parse(lng ?? ''),
                  adonatorName: adonatorName,
                  adonatorEmail: adonatorEmail,
                  photoUrl: photoUrl,
                );

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CampaignDetailActivity(
                          campaign: campaign,
                        ),
                      ),
                    );
                  },
                  child: CampaignAdapter(
                    campaign: campaign,
                  ),
                );
              },
            );
          }),
    );
  }
}
