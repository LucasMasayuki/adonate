import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:adonate/activity/CampaignDetailActivity.dart';
import 'package:adonate/shared/api.dart';
import 'package:adonate/adapter/CampaignAdapter.dart';
import 'package:adonate/model/CampaignModel.dart';

class CampaignList extends StatefulWidget {
  const CampaignList({this.searchParam});
  final searchParam;

  @override
  State<StatefulWidget> createState() => CampaignListState();
}

class CampaignListState extends State<CampaignList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: widget.searchParam == null
          ? Api.getRequest('campaigns')
          : Api.getRequest('filter_campaign', params: widget.searchParam),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none && projectSnap.hasData == null) {
            return Center(child: CircularProgressIndicator());
          }

          if (!projectSnap.hasData || projectSnap.data.statusCode != 200) {
            return Center(child: CircularProgressIndicator());
          }

          Map<String, dynamic> body = jsonDecode(projectSnap.data.body);
          var resultList;

          if (widget.searchParam == null) {
            resultList = body.entries.toList()[3].value;
          } else {
            resultList = body.entries.toList()[0].value;
          }

          return ListView.builder(
            itemCount: resultList.length,
            itemBuilder: (context, index) {
              var data = resultList[index].entries.toList();
              var adonatorName = data[0].value.entries.toList()[1].value;
              var adonatorEmail = data[0].value.entries.toList()[2].value;
              var itemTypeTag = data[1].value[0].entries.toList()[0].value.entries.toList();
              var purposeTag = data[1].value[1].entries.toList()[0].value.entries.toList();
              var lat = double.parse(data[3].value.entries.toList()[5].value);
              var lng = double.parse(data[3].value.entries.toList()[6].value);

              var photoUrl = '';
              if (data[2].value.length != 0) {
                photoUrl = data[2].value[0].entries.toList()[0].value.entries.toList()[0].value;
              }

              CampaignModel campaign = CampaignModel(
                name: data[5].value,
                description: data[6].value,
                start: DateTime.parse(data[7].value),
                end: DateTime.parse(data[8].value),
                itemTypeTagName: itemTypeTag[1].value,
                purposeTagName: purposeTag[1].value,
                itemTypeTagColor: itemTypeTag[2].value,
                purposeTagColor: purposeTag[2].value,
                lat: lat,
                lng: lng,
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
                      )
                    )
                  );
                },
                child: CampaignAdapter(
                  campaign: campaign,
                ),
              );
            },
          );
        }
      ),
    );
  }
}