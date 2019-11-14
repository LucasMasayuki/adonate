import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:adonate/shared/api.dart';
import 'package:adonate/shared/sharedPreferencesHelper.dart';
import 'package:adonate/activity/LoginActivity.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerHeader = FutureBuilder<dynamic>(
    future:  Api.getRequest('auth'),
    builder: (context, projectSnap) {
      if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.hasData == null) {
        return Container();
      }

      if (!projectSnap.hasData || projectSnap.data.statusCode != 200) {
        return Container();
      }

      Map<String, dynamic> user = jsonDecode(projectSnap.data.body);

      return UserAccountsDrawerHeader(
        accountName: Text('user.displayName'),
        accountEmail: Text('user.email'),
        currentAccountPicture: CircleAvatar(
          child: Icon(
            Icons.person,
            size: 64.0,
          ),
          backgroundColor: Colors.white,
        ),
      );
    });

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text('Logout'),
          onTap: () async {
              await Api.postRequest('logout');
              await SharedPreferencesHelper.remove('token');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginActivity()
                )
              );
          }
        ),
      ],
    );

    return drawerItems;
  }
}