import 'dart:convert';

import 'package:adonate/activity/CreateOrEditCampaignActivity.dart';
import 'package:adonate/model/CampaignModel.dart';
import 'package:adonate/adapter/MyCampaignAdapter.dart';
import 'package:adonate/shared/api.dart';
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
        future: Api.getRequest('get_campaigns_of_adonator'),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none && projectSnap.hasData == null) {
            return Center(child: CircularProgressIndicator());
          }

          if (!projectSnap.hasData || projectSnap.data.statusCode != 200) {
            return Center(child: CircularProgressIndicator());
          }

          var resultList = jsonDecode(projectSnap.data.body);

          return ListView.builder(
            itemCount: resultList.length,
            itemBuilder: (context, index) {
              var data = resultList[index].entries.toList();
              var adonatorName = data[0].value.entries.toList()[1].value;
              var adonatorEmail = data[0].value.entries.toList()[2].value;
              var itemTypeTag = data[1].value[0].entries.toList()[0].value.entries.toList();
              var purposeTag = data[1].value[1].entries.toList()[0].value.entries.toList();
              var address = data[3].value.entries.toList();
              var zipcode = address[0].value;
              var street = address[1].value;
              var number = address[2].value;
              var state = address[3].value;
              var city = address[4].value;
              var lat = double.parse(address[5].value);
              var lng = double.parse(address[6].value);

              var photoUrl = '';
              if (data[2].value.length != 0) {
                photoUrl = data[2].value[0].entries.toList()[0].value.entries.toList()[0].value;
              }

              CampaignModel campaign = CampaignModel(
                id: data[0].value.entries.toList()[0].value,
                campaignId: data[4].value,
                name: data[5].value,
                description: data[6].value,
                start: DateTime.parse(data[7].value),
                end: DateTime.parse(data[8].value),
                itemTypeTagName: itemTypeTag[1].value,
                purposeTagName: purposeTag[1].value,
                itemTypeTagColor: itemTypeTag[2].value,
                purposeTagColor: purposeTag[2].value,
                zipcode: zipcode,
                street: street,
                number: number,
                state: state,
                city: city,
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
                      builder: (context) => CreateOrEditCampaignActivity(
                        campaign: campaign,
                      )
                    )
                  );
                },
                child: MyCampaignAdapter(
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
