import 'package:adonate/shared/wigdets/default_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:adonate/campanhas/CampanhasBodyWidget.dart';

class CampanhasActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CampanhasActivityState();
}

class CampanhasActivityState extends State<CampanhasActivity> {
  final _kTabPages = <Widget>[
    CampanhasBodyWidget(),
    Scaffold(),
  ];

  final _kTabs = <Tab>[
    Tab(
      icon: Icon(
        FontAwesome5.getIconData("hand-holding-heart", weight: IconWeight.Solid),
        color: Colors.white
      ),
      text: "Campanhas"
    ),
    Tab(
      icon: Icon(
        Icons.person_outline,
        color: Colors.white
      ),
      text: "Minhas campanhas"
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _kTabPages.length,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white
              ),
              onPressed: () => {},
            ),
          ],
          leading: Container(),
          title: Text(
            'Adonate',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.orange,
            tabs: _kTabs,
          ),
        ),
        drawer: Drawer(
          child: DefaultDrawer(),
        ),
        body: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TabBarView(children: _kTabPages));
          },
        ),
      ),
    );
  }
}
