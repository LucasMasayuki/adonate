import 'package:adonate/activity/LoginActivity.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        hintColor: Colors.white,
        appBarTheme: AppBarTheme(color: Colors.blue, elevation: 0),
      ),
      home: LoginActivity(),
    );
  }
}
