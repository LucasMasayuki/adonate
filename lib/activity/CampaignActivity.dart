
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:adonate/shared/wigdets/default_drawer.dart';

import 'package:adonate/campaign_widget/MyCampaignList.dart';
import 'package:adonate/campaign_widget/CampaignList.dart';
import 'package:adonate/activity/FilterActivity.dart';
import 'package:adonate/activity/CreateOrEditCampaignActivity.dart';

class CampaignActivity extends StatefulWidget {
  CampaignActivity({this.passedIndex, this.searchParam});

  int passedIndex;
  var searchParam;

  @override
  State<StatefulWidget> createState() => CampaignActivityState();
}

class CampaignActivityState extends State<CampaignActivity> {
  Future<bool> _onWillPopScope() async {
    return false;
  }

  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabPages = <Widget>[
      CampaignList(searchParam: widget.searchParam),
      MyCampaignList(),
    ];

    final icons = <IconData>[
      Icons.search,
      Icons.add,
      Icons.close
    ];

    final pressAction = <Object>[
      FilterActivity(),
      CreateOrEditCampaignActivity(),
    ];

    var index = _currentTabIndex;
    if (widget.passedIndex != null) {
      index = widget.passedIndex;
      widget.passedIndex = null;
    }

    final _kBottmonNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        activeIcon: Icon(
          FontAwesome5.getIconData("hand-holding-heart", weight: IconWeight.Solid),
          color: Colors.orange[200]
        ),
        icon: Icon(
          FontAwesome5.getIconData("hand-holding-heart", weight: IconWeight.Solid),
          color: Colors.grey
        ), 
        title: Text('Campanhas',
          style: TextStyle(
            color: index == 0 ? Colors.orange[200] : Colors.grey,
            fontWeight: FontWeight.bold
          )
        )
      ),
      BottomNavigationBarItem(
        activeIcon: Icon(Icons.person, color: Colors.orange[200]),
        icon: Icon(Icons.person, color: Colors.grey),
        title: Text('Minhas campanhas',
          style: TextStyle(
            color: index == 1 ? Colors.orange[200] : Colors.grey,
            fontWeight: FontWeight.bold
          )
        )
      ),
    ];

    final bottomNavBar = BottomNavigationBar(
      elevation: 16.0,
      backgroundColor: Colors.white,
      items: _kBottmonNavBarItems,
      currentIndex: index,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );

    var idx = index;
    if (widget.searchParam != null) {
      idx = 2;
    }

    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orangeAccent,
          onPressed: () {
            if (_currentTabIndex == 1) {
              idx = 1;
            }

            if (idx == 2) {
              setState(() {
                widget.searchParam = null;
              });
              return;
            }
  
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => pressAction[idx])
            );
          },
          heroTag: "Hero",
          child: Icon(icons[idx]),
          elevation: 4,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
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
        body: tabPages[index],
        bottomNavigationBar: bottomNavBar,
      )
    );
  }
}
