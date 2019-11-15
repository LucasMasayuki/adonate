import 'dart:io';

import 'package:adonate/campanhas/CampanhaModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DetalheMinhaCampanhaActivity extends StatefulWidget {
  const DetalheMinhaCampanhaActivity({this.campanha});

  final CampanhaModel campanha;

  @override
  _DetalheMinhaCampanhaActivityState createState() =>
      _DetalheMinhaCampanhaActivityState();
}

class _DetalheMinhaCampanhaActivityState
    extends State<DetalheMinhaCampanhaActivity> {
  File _image;
  TextEditingController _nomeController;
  TextEditingController _inicioController;
  TextEditingController _fimController;
  TextEditingController _shortDescController;
  String _valorProposeTag;
  String _valorTypeItemTag;

  final formatter = DateFormat("dd/MM/yyyy");

  @override
  void initState() {
    _nomeController = TextEditingController(text: widget.campanha.name);
    _inicioController =
        TextEditingController(text: formatter.format(widget.campanha.start));
    _fimController =
        TextEditingController(text: formatter.format(widget.campanha.end));
    _shortDescController =
        TextEditingController(text: widget.campanha.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text(
          'Editar ${widget.campanha.name}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.blue,
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
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    controller: _nomeController,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: TextField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          MaskTextInputFormatter(mask: '##/##/####')
                        ],
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                        controller: _inicioController,
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          MaskTextInputFormatter(mask: '##/##/####')
                        ],
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                        controller: _fimController,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  maxLength: 255,
                  minLines: 3,
                  maxLines: 10,
                  decoration: InputDecoration(border: OutlineInputBorder()),
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
