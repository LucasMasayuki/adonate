import 'dart:io';

import 'package:adonate/campanhas/CampanhaModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  @override
  Widget build(BuildContext context) {
    TextEditingController _nomeController =
        TextEditingController(text: widget.campanha.nomeCampanha);
    TextEditingController _inicioController = TextEditingController(
        text: widget.campanha.dataInicioCampanha.toIso8601String());
    TextEditingController _shortDescController =
        TextEditingController(text: widget.campanha.shortDesc);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text(
          'Editar ${widget.campanha.nomeCampanha}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                    controller: _nomeController,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  TextField(
                    controller: _inicioController,
                  ),
                  TextField(
                    controller: _inicioController,
                  ),
                ],
              ),
              TextField(
                controller: _shortDescController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _returnImageOfCampanha() {
    return GestureDetector(
      onTap: _getImage,
      child: Center(
        child: (_image == null
            ? Text('Selecione uma imagem')
            : Image.file(_image)),
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
