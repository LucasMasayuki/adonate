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
  TextEditingController _nomeController;
  TextEditingController _inicioController;
  TextEditingController _shortDescController;
  @override
  void initState() {
    _nomeController = TextEditingController(text: widget.campanha.nomeCampanha);
    _inicioController = TextEditingController(
        text: widget.campanha.dataInicioCampanha.toIso8601String());
    _shortDescController =
        TextEditingController(text: widget.campanha.shortDesc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50))),
                    controller: _nomeController,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                        controller: _inicioController,
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                        controller: _inicioController,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  minLines: 3,
                  maxLines: 10,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50))),
                  controller: _shortDescController,
                ),
              ),
              DropdownButton(
                  items: <String>['A', 'B', 'C', 'D'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {})
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
        height: 100,
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
