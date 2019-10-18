import 'package:adonate/activity/CampanhasActivity.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'CadastroActivity.dart';

class LoginActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginActivityState();
}

class LoginActivityState extends State<LoginActivity> {
  final loginController = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(mask: '###.###.###-###');
  final senhaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.blue,
      body: Container(
        child: ListView(
          padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
          children: <Widget>[
            Center(
              child: Text(
                'Adonate',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 100.0, 40, 0),
              child: Center(
                child: TextField(
                  maxLength: 18,
                  inputFormatters: [maskFormatter],
                  controller: loginController,
                  style: TextStyle(color: Colors.black),
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
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'CPF/CNPJ',
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 15, 40, 0),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Senha',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  controller: senhaController,
                  obscureText: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CadastroActivity()));
                    },
                    child: Text('Cadastro'),
                    color: Colors.orange,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CampanhasActivity()));
                    },
                    child: Text('Logar'),
                    color: Colors.orange,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
