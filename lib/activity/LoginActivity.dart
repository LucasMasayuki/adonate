import 'package:adonate/shared/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

import 'package:adonate/activity/CampaignActivity.dart';
import 'package:adonate/activity/RegisterActivity.dart';

import 'package:adonate/shared/wigdets/raised_gradient_button.dart';
import 'package:adonate/shared/wigdets/text_form_custom_field.dart';

import 'package:adonate/shared/constants.dart';
import 'package:adonate/shared/errorMessages.dart';
import 'package:adonate/shared/sharedPreferencesHelper.dart';

class LoginActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginActivityState();
}

class LoginActivityState extends State<LoginActivity> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailErrorMessage;
  String? passwordErrorMessage;

  Future<Response?> login() async {
    Map<String, dynamic> data = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    try {
      Response response = await DioAdapter().post<dynamic>(
        'login/',
        data: data,
      );

      if (response.statusCode == 500) {
        return response;
      }

      Map<String, dynamic> body = response.data;

      var responseList = body.entries.toList();

      if (response.statusCode != 200) {
        String firstKey = responseList[0].key;
        String message = responseList[0].value[0];

        setState(() {
          switch (firstKey) {
            case 'password':
              passwordErrorMessage = ErrorMessages.getError(firstKey, message);
              break;
            case 'email':
              emailErrorMessage = ErrorMessages.getError(firstKey, message);
              break;
          }
        });

        return response;
      }

      await SharedPreferencesHelper.save('token', body['key']);

      return response;
    } catch (error) {
      print(error);
    }
  }

  Future<void> showProgress(BuildContext context) async {
    try {
      var result = await showDialog(
        context: context,
        builder: (context) => FutureProgressDialog(
          login(),
          message: Text('Entrando...'),
        ),
      );

      showResultDialog(context, result);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CampaignActivity(
            passedIndex: null,
          ),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  void showResultDialog(BuildContext context, Response? response) {
    if (response?.statusCode == 500) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Algo deu errado"),
          content: Text("Tente novamente mais tarde"),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              primaryColor,
              secondaryColor,
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
          children: <Widget>[
            Center(
              child: Text(
                'Adonate',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
              child: Center(
                child: TextFormFieldCustom(
                    controller: emailController,
                    hintText: 'email',
                    errorText: emailErrorMessage,
                    contentPadding: defaultPaddingLoginTextField),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 4, 40, 0),
              child: Center(
                child: TextFormFieldCustom(
                    controller: passwordController,
                    hintText: 'senha',
                    errorText: passwordErrorMessage,
                    obscureText: true,
                    contentPadding: defaultPaddingLoginTextField),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: RaisedGradientButton(
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      gradient: LinearGradient(
                        colors: <Color>[
                          primaryGradientColorButton,
                          secondaryGradientColorButton,
                        ],
                      ),
                      onPressed: () => showProgress(context),
                      padding: defaultPaddingRaisedButton,
                      width: width,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: InkWell(
                        child: Text(
                          "não possui conta ? cadastre-se",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterActivity(),
                            ),
                          );
                        },
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
