import 'package:flutter/material.dart';

import 'package:adonate/activity/LoginActivity.dart';
import 'package:adonate/activity/CampaignActivity.dart';
import 'package:adonate/shared/sharedPreferencesHelper.dart';
import 'package:adonate/shared/constants.dart';

late StatefulWidget activity;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLogged = await SharedPreferencesHelper.haveKey('token');
  activity = LoginActivity();

  if (isLogged) {
    activity = CampaignActivity(
      passedIndex: null,
    );
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
        scaffoldBackgroundColor: Colors.grey[100],
        cardColor: Colors.white,
        appBarTheme: AppBarTheme(color: primaryColor, elevation: 0),
      ),
      home: activity,
    );
  }
}
