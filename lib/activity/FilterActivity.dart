import 'dart:convert';
import 'package:adonate/activity/CampaignActivity.dart';
import 'package:adonate/model/SearchParamModel.dart';
import 'package:adonate/model/TagModel.dart';
import 'package:adonate/shared/dio.dart';
import 'package:adonate/shared/wigdets/raised_gradient_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:adonate/shared/constants.dart';
import 'package:adonate/shared/wigdets/tag_dropdowns.dart';

class FilterActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FilterActivityState();
}

class FilterActivityState extends State<FilterActivity> {
  final TextEditingController campaignNameController =
      new TextEditingController();
  var defaultItemTypeTagValue;
  var defaultPurpouseTagValue;

  search() {
    SearchParamModel data = new SearchParamModel(
      campaignName: campaignNameController.text,
      purpouse: defaultPurpouseTagValue == null
          ? defaultPurpouseTagValue.toString()
          : defaultPurpouseTagValue,
      itemType: defaultItemTypeTagValue == null
          ? defaultItemTypeTagValue.toString()
          : defaultItemTypeTagValue,
    );

    if (campaignNameController.text == "" &&
        defaultPurpouseTagValue == null &&
        defaultItemTypeTagValue == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CampaignActivity(
            passedIndex: null,
          ),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CampaignActivity(
          searchParam: data,
          passedIndex: null,
        ),
      ),
    );

    return;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Filtrar campanhas",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Builder(
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
            child: Container(
              height: 280,
              child: SingleChildScrollView(
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: width,
                          height: 46.0,
                          child: TextFormField(
                            scrollPadding: EdgeInsets.all(0.0),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Procurar por campanha',
                                labelStyle: TextStyle(color: Colors.black38)),
                            controller: campaignNameController,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        ListTile(
                          title: Text(
                            "Filtrar por tags",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        FutureBuilder(
                          future: DioAdapter().get('api/tags/'),
                          builder: (
                            context,
                            AsyncSnapshot<Response<dynamic>?> projectSnap,
                          ) {
                            if (projectSnap.connectionState ==
                                    ConnectionState.none &&
                                projectSnap.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (!projectSnap.hasData ||
                                projectSnap.data!.statusCode != 200) {
                              return Center(child: CircularProgressIndicator());
                            }

                            var body = projectSnap.data?.data['results'];

                            List<TagModel> tags = (body as List)
                                .map((e) => TagModel.fromJson(e))
                                .toList();

                            return TagDropdowns(
                              reference: this,
                              tags: tags,
                            );
                          },
                        ),
                        Padding(padding: EdgeInsets.all(12.0)),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: RaisedGradientButton(
                            child: Text(
                              "Procurar",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            gradient: LinearGradient(colors: <Color>[
                              primaryGradientColorButton,
                              secondaryGradientColorButton
                            ]),
                            onPressed: () => search(),
                            padding: EdgeInsets.only(
                              left: 12.0,
                              right: 12.0,
                              top: 12.0,
                              bottom: 12.0,
                            ),
                            width: width,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
