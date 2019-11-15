import 'package:adonate/shared/wigdets/chip_design.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:adonate/shared/colorsHelper.dart';

import 'CampanhaModel.dart';

class CampanhasAdapter extends StatelessWidget {
  const CampanhasAdapter({this.campanha});
  final CampanhaModel campanha;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("dd/MM/yyyy");
    double tagWidth = MediaQuery.of(context).size.width * 0.38;
    double descriptionWidth = MediaQuery.of(context).size.width * 0.58;
    String period = 'Desde ${formatter.format(campanha.start)}';

    if (campanha.end != null) {
      period =
          'De ${formatter.format(campanha.start)} \nAté ${formatter.format(campanha.end)}';
    }

    return Card(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 120,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Container(
                  color: Colors.blue,
                ))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 20),
                width: descriptionWidth,
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      campanha.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text(period),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text(
                      campanha.description,
                      maxLines: 3,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ChipDesign(
                        label: campanha.purposeTagName,
                        color:
                            ColorsHelper.hexToColor(campanha.purposeTagColor),
                      ),
                      ChipDesign(
                        label: campanha.itemTypeTagName,
                        color:
                            ColorsHelper.hexToColor(campanha.itemTypeTagColor),
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
