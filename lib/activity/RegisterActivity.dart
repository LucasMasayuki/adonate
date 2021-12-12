import 'dart:convert';

import 'package:adonate/shared/dio.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:http/http.dart';

import 'package:adonate/shared/api.dart';
import 'package:adonate/shared/wigdets/text_form_custom_field.dart';
import 'package:adonate/shared/wigdets/raised_gradient_button.dart';
import 'package:adonate/shared/constants.dart';
import 'package:adonate/shared/errorMessages.dart';
import 'package:adonate/shared/sharedPreferencesHelper.dart';
import 'package:adonate/activity/CampaignActivity.dart';

class RegisterActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterActivityState();
}

class RegisterActivityState extends State<RegisterActivity> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? usernameErrorMessage;
  String? emailErrorMessage;
  String? password1ErrorMessage;
  String? password2ErrorMessage;

  register() async {
    Map<String, dynamic> data = {
      "username": nameController.text,
      "email": emailController.text,
      "password1": passwordController.text,
      "password2": confirmPasswordController.text,
    };

    var response = await DioAdapter().post<dynamic>('register', data: data);

    Map<String, dynamic> body = response.data;

    var responseList = body.entries.toList();

    if (response.statusCode != 200 || response.statusCode != 201) {
      String firstKey = responseList[0].key;
      String message = responseList[0].value[0];

      setState(() {
        switch (firstKey) {
          case 'password':
            usernameErrorMessage = ErrorMessages.getError(firstKey, message);
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
  }

  Future<void> showProgress(BuildContext context) async {
    try {
      var result = await showDialog(
        context: context,
        builder: (context) => FutureProgressDialog(
          register(),
          message: Text('Criando usuario...'),
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
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                primaryColor,
                secondaryColor,
              ],
            ),
          ),
        ),
      ),
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
          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
          children: <Widget>[
            Center(
              child: Text(
                'Adonate',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
              child: Center(
                child: TextFormFieldCustom(
                    controller: nameController,
                    hintText: 'Nome',
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    contentPadding: defaultPaddingFormTextField,
                    errorText: usernameErrorMessage),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 15, 40, 0),
              child: Center(
                child: TextFormFieldCustom(
                    controller: emailController,
                    hintText: 'E-mail',
                    keyboardType: TextInputType.emailAddress,
                    contentPadding: defaultPaddingFormTextField,
                    errorText: emailErrorMessage),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 15, 40, 0),
              child: Center(
                child: TextFormFieldCustom(
                    controller: passwordController,
                    hintText: 'Senha',
                    obscureText: true,
                    contentPadding: defaultPaddingFormTextField,
                    errorText: password1ErrorMessage),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 15, 40, 0),
              child: Center(
                child: TextFormFieldCustom(
                    controller: confirmPasswordController,
                    hintText: 'Confirmar senha',
                    obscureText: true,
                    contentPadding: defaultPaddingFormTextField,
                    errorText: password2ErrorMessage),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 36, 40, 20),
              child: Center(
                child: RaisedGradientButton(
                  child: Text(
                    'Criar',
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
                  onPressed: () {
                    showProgress(context);
                  },
                  padding: defaultPaddingRaisedButton,
                  width: width,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
