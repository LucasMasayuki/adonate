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
        child:
            Icon(FontAwesome5.getIconData('search', weight: IconWeight.Solid)),
      ),
      body: ListView.builder(
        itemBuilder: (context, position) {
          final campanha = CampanhaModel(
            nomeCampanha: 'Campanha ${position + 1}',
            shortDesc: 'Descrição curta da campanha ${position + 1} teste',
            tag1: 'TAG ${position + 1}',
            tag2: 'TAG ${(position + 1) * 2}',
            corTag1: Colors.red,
            corTag2: Colors.green,
            dataInicioCampanha: DateTime.now().add(Duration(days: position)),
          );
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
