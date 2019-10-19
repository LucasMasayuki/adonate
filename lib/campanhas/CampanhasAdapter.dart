import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CampanhasAdapter extends StatelessWidget {
  const CampanhasAdapter(
      {this.nomeCampanha,
      this.dataInicioCampanha,
      this.tag1,
      this.tag2,
      this.corTag1,
      this.corTag2,
      this.shortDesc});
  final String nomeCampanha;
  final DateTime dataInicioCampanha;
  final String shortDesc;
  final String tag1;
  final String tag2;
  final Color corTag1;
  final Color corTag2;

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
                      nomeCampanha,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(formatter.format(dataInicioCampanha)),
                    Text(
                      shortDesc,
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
                      color: corTag1,
                      child: Text(
                        tag1,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      color: corTag2,
                      child: Text(
                        tag2,
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
