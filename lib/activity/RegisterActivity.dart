import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:adonate/shared/api.dart';
import 'package:adonate/shared/wigdets/text_form_custom_field.dart';
import 'package:adonate/shared/wigdets/raised_gradient_button.dart';
import 'package:adonate/shared/constants.dart';
import 'package:adonate/shared/errorMessages.dart';
import 'package:adonate/shared/sharedPreferencesHelper.dart';
import 'package:adonate/activity/CampanhasActivity.dart';

class RegisterActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterActivityState();
}
class RegisterActivityState extends State<RegisterActivity> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var maskFormatter = new MaskTextInputFormatter(mask: '###.###.###-###');

  String usernameErrorMessage;
  String emailErrorMessage;
  String password1ErrorMessage;
  String password2ErrorMessage;

  var progressDialog;

  register() async {
    Map data = {
      "username": nameController.text,
      "email": emailController.text,
      "password1": passwordController.text,
      "password2": confirmPasswordController.text,
    };

    progressDialog.style(
      message: 'Criando usuario...',
    );

    progressDialog.show();

    Response response = await Api.postRequest('register', data: data);
    Map<String, dynamic> body = jsonDecode(response.body);

    var responseList = body.entries.toList();

    if (response.statusCode != 200) {
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

      progressDialog.hide();
    }

    await SharedPreferencesHelper.save('token', body['key']);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CampanhasActivity()));
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = new ProgressDialog(context);
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
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
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
              padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
              child: Center(
                child: TextFormFieldCustom(
                    controller: loginController,
                    hintText: 'CPF/CNPJ',
                    maxLength: 18,
                    inputFormatters: [maskFormatter],
                    onChanged: (value) {
                      if (value.length > 14) {
                        loginController.value =
                            maskFormatter.updateMask("##.###.###/####-##");
                      } else {
                        loginController.value =
                            maskFormatter.updateMask("###.###.###-###");
                      }
                    },
                    keyboardType: TextInputType.number,
                    contentPadding: defaultPaddingFormTextField),
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
              padding: EdgeInsets.fromLTRB(40, 24, 40, 20),
              child: Center(
                  child: RaisedGradientButton(
                child: Text(
                  'Criar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                gradient: LinearGradient(
                  colors: <Color>[
                    primaryGradientColorButton,
                    secondaryGradientColorButton,
                  ],
                ),
                onPressed: () {
                  register();
                },
                padding: defaultPaddingRaisedButton,
              )),
            )
          ],
        ),
      ),
    );
  }
}
