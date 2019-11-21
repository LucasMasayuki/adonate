
import 'dart:convert';
import 'package:adonate/shared/wigdets/raised_gradient_button.dart';
import 'package:flutter/material.dart';

import 'package:adonate/shared/api.dart';
import 'package:adonate/shared/constants.dart';
import 'package:adonate/shared/wigdets/tag_dropdowns.dart';

class FilterActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FilterActivityState();
}

class FilterActivityState extends State<FilterActivity> {
  final TextEditingController filter = new TextEditingController();
  var searchText = "";

  void deletePressed() {
    filter.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Filtrar campanhas", style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Builder(
        builder: (context) {
          return Card(
            elevation: 4,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Procurar por campanha',
                      labelStyle: TextStyle(color: Colors.black38)
                    ),
                    controller: filter,
                    style: TextStyle(fontSize: 16),
                  ),
                  FutureBuilder(
                    future: Api.getRequest('tags'),
                    builder: (context, projectSnap) {
                      if (projectSnap.connectionState == ConnectionState.none && projectSnap.hasData == null) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!projectSnap.hasData || projectSnap.data.statusCode != 200) {
                        return Center(child: CircularProgressIndicator());
                      }

                      Map<String, dynamic> body = jsonDecode(projectSnap.data.body);
                      var tags = body.entries.toList()[3].value;
                      return TagDropdowns(tags: tags);
                    }
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: RaisedGradientButton(
                      child: Text(
                        "Procurar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      gradient: LinearGradient(
                        colors: <Color>[
                          primaryGradientColorButton,
                          secondaryGradientColorButton
                        ]
                      ),
                      onPressed: () => {},
                      padding: defaultPaddingRaisedButtonForm,
                    ),
                  )
                ]
              )
            ),
          );
        },
      ),
    );
  }
}
