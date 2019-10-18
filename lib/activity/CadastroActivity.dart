import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CadastroActivityState();
}

class CadastroActivityState extends State<CadastroActivity> {
  final loginController = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(mask: '###.###.###-###');
  final senhaController = TextEditingController();
  final emailController = TextEditingController();
  final nomeController = TextEditingController();
  final confirmSenhaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.blue,
      body: Container(
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                'Adonate',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 100, 40, 0),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Nome',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  controller: nomeController,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
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
                    hintText: 'E-mail',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
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
              padding: EdgeInsets.fromLTRB(40, 60, 40, 0),
              child: Center(
                child: MaterialButton(
                  color: Colors.orange,
                  onPressed: () {},
                  child: Text('Criar'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
