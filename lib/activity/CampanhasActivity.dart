import 'package:adonate/shared/api.dart';
import 'package:adonate/shared/sharedPreferencesHelper.dart';
import 'package:adonate/shared/wigdets/default_drawer.dart';
import 'package:adonate/campanhas/MinhasCampanhasBodyWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:adonate/campanhas/CampanhasBodyWidget.dart';

import 'LoginActivity.dart';

class CampanhasActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CampanhasActivityState();
}

class CampanhasActivityState extends State<CampanhasActivity> {
  final _kTabPages = <Widget>[
    CampanhasBodyWidget(),
    MinhasCampanhasBodyWidget(),
  ];

  final _kTabs = <Tab>[
    Tab(
        icon: Icon(
            FontAwesome5.getIconData("hand-holding-heart",
                weight: IconWeight.Solid),
            color: Colors.white),
        text: "Campanhas"),
    Tab(
        icon: Icon(Icons.person_outline, color: Colors.white),
        text: "Minhas campanhas")
  ];

  logout() async {
    await Api.postRequest('logout');
    await SharedPreferencesHelper.remove('token');

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginActivity()));
  }

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
              onPressed: () => logout(),
            ),
          ],
          leading: Container(),
          title: Text(
            'Adonate',
            style: TextStyle(color: Colors.white),
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
