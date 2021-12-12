import 'package:adonate/shared/dio.dart';
import 'package:flutter/material.dart';

import 'package:adonate/shared/sharedPreferencesHelper.dart';
import 'package:adonate/activity/LoginActivity.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({Key? key}) : super(key: key);

  Future<void> onTap(context) async {
    await DioAdapter().post('logout/', data: {});
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
      future: DioAdapter().get('api/auth'),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        if (!projectSnap.hasData || projectSnap.data.statusCode != 200) {
          return Center(child: CircularProgressIndicator());
        }

        Map<String, dynamic> body = projectSnap.data.data;

        String userName = body['adonator']['name'];
        String userEmail = body['adonator']['email'];

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
          onTap: () => showProgress(context),
        ),
      ],
    );

    return drawerItems;
  }
}
