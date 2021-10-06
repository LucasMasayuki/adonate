import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:adonate/shared/api.dart';
import 'package:adonate/shared/sharedPreferencesHelper.dart';
import 'package:adonate/activity/LoginActivity.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({Key? key}) : super(key: key);

  Future<void> onTap(context) async {
    await Api.postRequest('logout');
    await SharedPreferencesHelper.remove('token');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginActivity()),
      ModalRoute.withName("/Login"),
    );
  }

  Future<void> showProgress(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        onTap(context),
        message: Text('Saindo...'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final drawerHeader = FutureBuilder<dynamic>(
      future: Api.getRequest('auth'),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Center(child: CircularProgressIndicator());
        }

        if (!projectSnap.hasData || projectSnap.data.statusCode != 200) {
          return Center(child: CircularProgressIndicator());
        }

        Map<String, dynamic> body =
            jsonDecode(utf8.decode(projectSnap.data.bodyBytes));

        var data = body.entries.toList()[0].value.entries.toList();
        String userName = data[1].value;
        String userEmail = data[2].value;

        return UserAccountsDrawerHeader(
          accountName: Text(
            userName,
            style: TextStyle(color: Colors.white),
          ),
          accountEmail: Text(
            userEmail,
            style: TextStyle(color: Colors.white),
          ),
          currentAccountPicture: CircleAvatar(
            child: Icon(
              Icons.person,
              size: 64.0,
            ),
            backgroundColor: Colors.white,
          ),
        );
      },
    );

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text(
            'Logout',
            style: TextStyle(color: Colors.grey),
          ),
          onTap: () => showProgress,
        ),
      ],
    );

    return drawerItems;
  }
}
