import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:adonate/model/CampaignModel.dart';

import 'package:adonate/shared/colorsHelper.dart';
import 'package:adonate/shared/wigdets/chip_design.dart';

class CampaignAdapter extends StatelessWidget {
  const CampaignAdapter({this.campaign});
  final CampaignModel campaign;

  Widget havePhoto(width) {
    if (campaign.photoUrl != "") {
      return Container(
        height: 120,
        width: width,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Card(
            color: Colors.grey,
            child: CachedNetworkImage(
              imageUrl: campaign.photoUrl,
              placeholder: (context, url) => Center(child: Container(color: Colors.grey,)),
              errorWidget: (context, url, error) => Container(height: 0),
            ),
          ),
        ),
      );
    }

    return Container(height: 0);
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("dd/MM/yyyy");
    double tagWidth = MediaQuery.of(context).size.width * 0.38;
    double descriptionWidth = MediaQuery.of(context).size.width * 0.58;
    String period = 'Desde ${formatter.format(campaign.start)}';
    var width = MediaQuery.of(context).size.width;

    if (campaign.end != null) {
      period = 'De ${formatter.format(campaign.start)} \nAté ${formatter.format(campaign.end)}';
    }

    return Card(
      elevation: 3,
      child: Column(
        children: <Widget>[
          havePhoto(width),
          Padding(padding: EdgeInsets.only(top: 5)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 20),
                width: descriptionWidth,
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      campaign.name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text(
                      period,
                      style: TextStyle(color: Colors.grey),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text(
                      campaign.description,
                      maxLines: 3,
                      style: TextStyle(color: Colors.grey),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Container(
                width: tagWidth,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ChipDesign(
                        color: ColorsHelper.hexToColor(campaign.purposeTagColor),
                        label: campaign.purposeTagName,
                      ),
                      ChipDesign(
                        color: ColorsHelper.hexToColor(campaign.itemTypeTagColor),
                        label: campaign.itemTypeTagName,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
