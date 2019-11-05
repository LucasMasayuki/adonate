import 'package:adonate/campanhas/CampanhaModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetalheCampanhaActivity extends StatelessWidget {
  DetalheCampanhaActivity({this.campanha});

  final CampanhaModel campanha;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("dd/MM/yyyy h:mm a");
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(campanha.nomeCampanha),
              background: Container(
                color: Colors.blue,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              color: Colors.grey[300],
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'ONG X',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text(
                      formatter.format(campanha.dataInicioCampanha),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      campanha.shortDesc,
                      maxLines: 3,
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ]))
        ],
      ),
    );
  }

  final children = [];
}
