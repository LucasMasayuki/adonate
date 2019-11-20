
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:adonate/shared/wigdets/default_drawer.dart';

import 'package:adonate/campaign_widget/MyCampaignList.dart';
import 'package:adonate/campaign_widget/CampaignList.dart';

class CampaignActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CampaignActivityState();
}

class CampaignActivityState extends State<CampaignActivity> {
  final tabPages = <Widget>[
    CampaignList(),
    MyCampaignList(),
  ];

  final tabs = <Tab>[
    Tab(
      icon: Icon(
        FontAwesome5.getIconData("hand-holding-heart", weight: IconWeight.Solid),
        color: Colors.white
      ),
      text: "Campanhas"
    ),
    Tab(
      icon: Icon(Icons.person_outline, color: Colors.white),
      text: "Minhas campanhas"
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabPages.length,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white
              ),
              onPressed: () => { },
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.orange,
            tabs: tabs,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            'Adonate',
            style: TextStyle(color: Colors.white),
          ),
        ),
        drawer: Drawer(
          child: DefaultDrawer(),
        ),
        body: Builder(
          builder: (context) {
            return TabBarView(children: tabPages);
          },
        ),
      ),
    );
  }
}
