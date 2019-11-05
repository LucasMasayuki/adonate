import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'CampanhaModel.dart';

class CampanhasAdapter extends StatelessWidget {
  const CampanhasAdapter({this.campanha});
  final CampanhaModel campanha;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("dd/MM/yyyy h:mm a");
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
                child: Column(
                  children: <Widget>[
                    Text(
                      campanha.nomeCampanha,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(formatter.format(campanha.dataInicioCampanha)),
                    Text(
                      campanha.shortDesc,
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
                    MaterialButton(
                      onPressed: () {},
                      color: campanha.corTag1,
                      child: Text(
                        campanha.tag1,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      color: campanha.corTag2,
                      child: Text(
                        campanha.tag2,
                        style: TextStyle(color: Colors.white),
                      ),
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
