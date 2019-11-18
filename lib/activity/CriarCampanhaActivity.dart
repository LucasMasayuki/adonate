import 'dart:io';

import 'package:adonate/shared/constants.dart';
import 'package:adonate/shared/wigdets/raised_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CriarCampanhaActivity extends StatefulWidget {
  const CriarCampanhaActivity();

  @override
  _CriarCampanhaActivityState createState() => _CriarCampanhaActivityState();
}

class _CriarCampanhaActivityState extends State<CriarCampanhaActivity> {
  File _image;
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _inicioController = TextEditingController();
  TextEditingController _fimController = TextEditingController();
  TextEditingController _shortDescController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();
  String _valorProposeTag;
  String _valorTypeItemTag;

  final formatter = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Criar Campanha',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Container(
                child: _returnImageOfCampanha(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black38),
                        labelText: 'Nome da campanha'),
                    controller: _nomeController,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 8.0),
                      child: TextField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          MaskTextInputFormatter(mask: '##/##/####')
                        ],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Inicio',
                            labelStyle: TextStyle(color: Colors.black38)),
                        controller: _inicioController,
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 8.0),
                      child: TextField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          MaskTextInputFormatter(mask: '##/##/####')
                        ],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Fim',
                            labelStyle: TextStyle(color: Colors.black38)),
                        controller: _fimController,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLength: 255,
                  minLines: 3,
                  maxLines: 10,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Descrição',
                      labelStyle: TextStyle(color: Colors.black38)),
                  controller: _shortDescController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: DropdownButton(
                      hint: Text('Para quem'),
                      value: _valorProposeTag,
                      items: <String>['Crianças', 'Desabrigados']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _valorProposeTag = value;
                        });
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: DropdownButton(
                      hint: Text('O que'),
                      value: _valorTypeItemTag,
                      items:
                          <String>['Brinquedos', 'Roupas'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _valorTypeItemTag = value;
                        });
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Endereço',
                        labelStyle: TextStyle(color: Colors.black38)),
                    controller: _enderecoController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
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
                      onPressed: () {},
                      padding: defaultPaddingRaisedButton,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _returnImageOfCampanha() {
    return GestureDetector(
      onTap: _getImage,
      child: Container(
        width: 200,
        height: 150,
        child: Center(
          child: (_image == null
              ? Text('Selecione uma imagem')
              : Image.file(_image)),
        ),
      ),
    );
  }

  _getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 100, maxWidth: 200);

    setState(() {
      _image = image;
    });
  }
}
