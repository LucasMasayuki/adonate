import 'package:flutter/material.dart';
import 'package:adonate/activity/LoginActivity.dart';
import 'package:adonate/activity/CampanhasActivity.dart';
import 'package:adonate/shared/sharedPreferencesHelper.dart';

StatefulWidget activity;

void main() async {
  bool isLogged = await SharedPreferencesHelper.haveKey('token');
  activity = LoginActivity();

  if (isLogged) {
    activity = CampanhasActivity();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        hintColor: Colors.white,
        appBarTheme: AppBarTheme(color: Colors.blue, elevation: 0),
      ),
      home: activity,
    );
  }
}
