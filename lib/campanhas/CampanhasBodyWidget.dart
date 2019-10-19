import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'CampanhasAdapter.dart';

class CampanhasBodyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CampanhasBodyWidgetState();
}

class _CampanhasBodyWidgetState extends State<CampanhasBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'Campanhas',
        onPressed: () {},
        child:
            Icon(FontAwesome5.getIconData('search', weight: IconWeight.Solid)),
      ),
      body: ListView.builder(
        itemBuilder: (context, position) {
          return CampanhasAdapter(
            nomeCampanha: 'Campanha ${position + 1}',
            shortDesc: 'Descrição curta da campanha ${position + 1} teste',
            tag1: 'TAG ${position + 1}',
            tag2: 'TAG ${(position + 1) * 2}',
            corTag1: Colors.red,
            corTag2: Colors.green,
            dataInicioCampanha: DateTime.now().add(Duration(days: position)),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
