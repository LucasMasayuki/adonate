import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CampanhasActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CampanhasActivityState();
}

class CampanhasActivityState extends State<CampanhasActivity> {
  final _kTabPages = <Widget>[
    Scaffold(),
    Scaffold(),
  ];
  final _kTabs = <Tab>[
    Tab(
        icon: Icon(FontAwesome5.getIconData("hand-holding-heart",
            weight: IconWeight.Solid)),
        text: "Campanhas"),
    Tab(
        icon: Icon(
          Icons.person_outline,
        ),
        text: "Minhas campanhas")
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _kTabPages.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Adonate'),
          bottom: TabBar(
            tabs: _kTabs,
          ),
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
