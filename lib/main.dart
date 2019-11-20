import 'package:flutter/material.dart';

import 'package:adonate/activity/LoginActivity.dart';
import 'package:adonate/activity/CampaignActivity.dart';
import 'package:adonate/shared/sharedPreferencesHelper.dart';
import 'package:adonate/shared/constants.dart';

StatefulWidget activity;

void main() async {
  bool isLogged = await SharedPreferencesHelper.haveKey('token');
  activity = LoginActivity();

  if (isLogged) {
    activity = CampaignActivity();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        hintColor: Colors.white,
        appBarTheme: AppBarTheme(color: primaryColor, elevation: 0),
      ),
      home: activity,
    );
  }
}
