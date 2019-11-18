import 'dart:io';

import 'package:adonate/campanhas/CampanhaModel.dart';
import 'package:adonate/shared/constants.dart';
import 'package:adonate/shared/wigdets/raised_gradient_button.dart';
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
  TextEditingController _enderecoController;
  String _valorProposeTag;
  String _valorTypeItemTag;

  final formatter = DateFormat("dd/MM/yyyy");
  final pageController = PageController(initialPage: 0);
  final scrollDirection = Axis.horizontal;
  var _index = 0;

  var steps;
  int currentStep = 0;
  bool complete = false;

  @override
  void initState() {
    _nomeController = TextEditingController(text: widget.campanha.name,);
    _inicioController = TextEditingController(text: formatter.format(widget.campanha.start));
    _fimController = TextEditingController(text: formatter.format(widget.campanha.end));
    _shortDescController = TextEditingController(text: widget.campanha.description);
    _enderecoController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 4,
        title: Text(
          'Editar ${widget.campanha.name}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: primaryColor,
      body: Column(
        children: <Widget>[
          Expanded(
            child: _builderStep()
          )
        ],
      )
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
            : Image.file(_image)
          ),
        ),
      ),
    );
  }

  _getImage() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery, maxHeight: 100, maxWidth: 200
    );

    setState(() {
      _image = image;
    });
  }

  getSteps() => [
    Step(
      title: Text("Informações"),
      content: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black38),
                labelText: 'Nome da campanha'
              ),
              controller: _nomeController,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      MaskTextInputFormatter(mask: '##/##/####')
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Inicio',
                      labelStyle: TextStyle(color: Colors.black38)
                    ),
                    controller: _inicioController,
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      MaskTextInputFormatter(mask: '##/##/####')
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Fim',
                      labelStyle: TextStyle(color: Colors.black38)
                    ),
                    controller: _fimController,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ] 
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
        ],
      ),
    ),
    Step(
      title: Text("Second"),
      content: Text("This is our second example."),
    ),
  ];

  Widget _builderStep() => Container(
    color: Colors.white,
    child: Stepper(
      type: StepperType.horizontal,
      steps: getSteps(),
      currentStep: currentStep,
      onStepContinue: next,
      onStepTapped: (step) => goTo(step),
      onStepCancel: cancel,
      controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: RaisedGradientButton(
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  gradient: LinearGradient(
                    colors: <Color>[
                      gradientOfCancelButtonPrimary,
                      gradientOfCancelButtonSecondary
                    ]
                  ),
                  onPressed: cancel,
                  padding: defaultPaddingRaisedButtonForm,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: RaisedGradientButton(
                  child: Text(
                    'Continuar',
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
                  onPressed: next,
                  padding: defaultPaddingRaisedButtonForm,
                ),
              ),
            ],
        );
      },
    ),
  );

  next() {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }
}
