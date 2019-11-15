import 'package:adonate/shared/colorsHelper.dart';
import 'package:adonate/shared/wigdets/chip_design.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'CampanhaModel.dart';

class MinhasCampanhasAdapter extends StatelessWidget {
  const MinhasCampanhasAdapter({this.campanha});
  final CampanhaModel campanha;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("dd/MM/yyyy h:mm a");
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      campanha.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(formatter.format(campanha.start)),
                    Text(
                      campanha.description,
                      maxLines: 3,
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    ChipDesign(
                      label: campanha.purposeTagName,
                      color: ColorsHelper.hexToColor(campanha.purposeTagColor),
                    ),
                    ChipDesign(
                      label: campanha.itemTypeTagName,
                      color: ColorsHelper.hexToColor(campanha.itemTypeTagColor),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
