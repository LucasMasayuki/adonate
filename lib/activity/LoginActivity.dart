import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart';

import 'package:adonate/activity/CampaignActivity.dart';
import 'package:adonate/activity/RegisterActivity.dart';

import 'package:adonate/shared/wigdets/raised_gradient_button.dart';
import 'package:adonate/shared/wigdets/text_form_custom_field.dart';

import 'package:adonate/shared/api.dart';
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

  String emailErrorMessage;
  String passwordErrorMessage;

  var progressDialog;

  login() async {
    Map data = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    progressDialog.style(
      message: 'Entrando...',
    );

    progressDialog.show();

    Response response = await Api.postRequest('login', data: json.encode(data));

    if (response.statusCode == 500) {
      progressDialog.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
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
          );
        }
      );

      return;
    }

    Map<String, dynamic> body = jsonDecode(
      utf8.decode(response.bodyBytes)
    );
  
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

      progressDialog.hide();
      return;
    }

    await SharedPreferencesHelper.save('token', body['key']);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CampaignActivity()));
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = new ProgressDialog(context);
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
                  contentPadding: defaultPaddingLoginTextField
                ),
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
                  contentPadding: defaultPaddingLoginTextField
                ),
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
                      onPressed: () => login(),
                      padding: defaultPaddingRaisedButton,
                      width: width,
                    )
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
                            builder: (context) => RegisterActivity()
                          )
                        );
                      },
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
