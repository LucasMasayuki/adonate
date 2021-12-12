import 'dart:convert';

import 'package:adonate/activity/CreateOrEditCampaignActivity.dart';
import 'package:adonate/model/CampaignModel.dart';
import 'package:adonate/adapter/MyCampaignAdapter.dart';
import 'package:adonate/model/RemoteCampaignModel.dart';
import 'package:adonate/shared/dio.dart';
import 'package:adonate/wrappers/campaign_list_wrapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyCampaignList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyCampaignListState();
}

class MyCampaignListState extends State<MyCampaignList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: DioAdapter().get('api/get_campaigns_adonator'),
          builder: (context, AsyncSnapshot<Response<dynamic>?> projectSnap) {
            if (projectSnap.connectionState == ConnectionState.none &&
                projectSnap.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            if (!projectSnap.hasData || projectSnap.data!.statusCode != 200) {
              return Center(child: CircularProgressIndicator());
            }

            var campaigns = projectSnap.data?.data
                .map(((result) => RemoteCampaignModel.fromJson(result)))
                .toList();

            if (campaigns.length == 0) {
              return Container(
                  child: Center(
                child: Text("Não possui campanhas"),
              ));
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

                var zipcode = campaigns[index].address?.zipcode;
                var street = campaigns[index].address?.street;
                var number = campaigns[index].address?.number;
                var state = campaigns[index].address?.state;
                var city = campaigns[index].address?.city;

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
                  zipcode: zipcode,
                  street: street,
                  number: number,
                  state: state,
                  city: city,
                  lat: double.parse(lat ?? ''),
                  lng: double.parse(lng ?? ''),
                  adonatorName: adonatorName,
                  adonatorEmail: adonatorEmail,
                  photoUrl: photoUrl,
                  id: campaigns[index].id,
                );

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateOrEditCampaignActivity(
                          campaign: campaign,
                        ),
                      ),
                    );
                  },
                  child: MyCampaignAdapter(
                    campaign: campaign,
                  ),
                );
              },
            );
          }),
    );
  }
}
