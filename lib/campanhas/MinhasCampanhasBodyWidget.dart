import 'package:adonate/activity/DetalheMinhaCampanhaActivity.dart';
import 'package:adonate/campanhas/CampanhaModel.dart';
import 'package:adonate/campanhas/MinhasCampanhasAdapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'CampanhasAdapter.dart';

class MinhasCampanhasBodyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MinhasCampanhasBodyWidgetState();
}

class _MinhasCampanhasBodyWidgetState extends State<MinhasCampanhasBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'MinhasCampanhas',
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemBuilder: (context, position) {
          final campanha = CampanhaModel(
              name: 'Campanha ${position + 1}',
              description: 'Descrição curta da campanha ${position + 1} teste',
              purposeTagName: 'TAG ${position + 1}',
              itemTypeTagName: 'TAG ${(position + 1) * 2}',
              itemTypeTagColor: '#FF0000',
              purposeTagColor: '#00FF00',
              start: DateTime.now().add(Duration(days: position)),
              end: DateTime.now().add(Duration(days: 30)));
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalheMinhaCampanhaActivity(
                            campanha: campanha,
                          )));
            },
            child: MinhasCampanhasAdapter(
              campanha: campanha,
            ),
          );
        },
        itemCount: 3,
      ),
    );
  }
}
