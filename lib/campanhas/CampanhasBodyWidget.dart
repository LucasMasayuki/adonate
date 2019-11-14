import 'dart:convert';

import 'package:adonate/activity/DetalhesCampanhaActivity.dart';
import 'package:adonate/campanhas/CampanhaModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:adonate/shared/api.dart';

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
        child: Icon(
          FontAwesome5.getIconData('search', weight: IconWeight.Solid)
        ),
      ),
      body: FutureBuilder(
        future: Api.getRequest('campaigns'),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData == null) {
            return Container();
          }

          if (!projectSnap.hasData || projectSnap.data.statusCode != 200) {
            return Container();
          }

          Map<String, dynamic> body = jsonDecode(projectSnap.data.body);
          var resultList = body.entries.toList()[3].value;

          return ListView.builder(
            itemCount: resultList.length,
            itemBuilder: (context, index) {
              var data = resultList[index].entries.toList();
              var itemTypeTag = data[1].value[0].entries.toList()[0].value.entries.toList();
              var purposeTag = data[1].value[1].entries.toList()[0].value.entries.toList();

              CampanhaModel campanha = CampanhaModel(
                name: data[2].value,
                description: data[3].value,
                start: DateTime.parse(data[4].value),
                end: DateTime.parse(data[5].value),
                itemTypeTagName: itemTypeTag[0].value,
                purposeTagName: purposeTag[0].value,
                itemTypeTagColor: itemTypeTag[1].value,
                purposeTagColor: purposeTag[1].value,
              );

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalheCampanhaActivity(
                        campanha: campanha,
                      )
                    )
                  );
                },
                child: CampanhasAdapter(
                  campanha: campanha,
                ),
              );
            },
          );
        }
      ),
    );
  }
}