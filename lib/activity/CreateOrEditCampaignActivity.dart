import 'dart:convert';
import 'dart:io';
import 'package:adonate/shared/wigdets/tag_dropdowns.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:adonate/model/CampaignModel.dart';
import 'package:adonate/shared/api.dart';
import 'package:adonate/shared/constants.dart';
import 'package:adonate/shared/wigdets/raised_gradient_button.dart';

class CreateOrEditCampaignActivity extends StatefulWidget {
  const CreateOrEditCampaignActivity({this.campaign});

  final CampaignModel campaign;

  @override
  CreateOrEditCampaignActivityState createState() => CreateOrEditCampaignActivityState();
}

class CreateOrEditCampaignActivityState extends State<CreateOrEditCampaignActivity> {
  TextEditingController _nameController;
  TextEditingController _startController;
  TextEditingController _endController;
  TextEditingController _descriptionController;
  TextEditingController _zipcodeController;
  TextEditingController _streetController;
  TextEditingController _numberController;
  TextEditingController _cityController;
  TextEditingController _stateController;

  final formatter = DateFormat("dd/MM/yyyy");
  final pageController = PageController(initialPage: 0);
  final scrollDirection = Axis.horizontal;

  var steps;
  var progressDialog;

  String _valorProposeTag;
  String _valorTypeItemTag;
  int currentStep = 0;
  File _image;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.campaign != null ? widget.campaign.name : null);
    _startController = TextEditingController(text: widget.campaign != null ? formatter.format(widget.campaign.start) : null);
    _endController = TextEditingController(text: widget.campaign != null ? formatter.format(widget.campaign.end) : null);
    _descriptionController = TextEditingController(text: widget.campaign != null ? widget.campaign.description : null);
    _zipcodeController = TextEditingController(text: widget.campaign != null ? widget.campaign.zipcode.toString() : null);
    _streetController = TextEditingController(text: widget.campaign != null ? widget.campaign.street : null);
    _numberController = TextEditingController(text: widget.campaign != null ? widget.campaign.number.toString() : null);
    _cityController = TextEditingController(text: widget.campaign != null ? widget.campaign.city : null);
    _stateController = TextEditingController(text: widget.campaign != null ?widget.campaign.state : null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = new ProgressDialog(context);
    steps = getSteps();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 4,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          widget.campaign != null ? 'Editar ${widget.campaign.name}' : 'Adicionar campanha',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
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

  Widget _returnImageOfcampaign() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("Imagem da campanha"),
        ),
        GestureDetector(
          onTap: _getImage,
          child: SizedBox(
            height: 120,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Card(
                    color: Colors.grey,
                    child: returnPhotoOfFileOrUrl()
                  )
                ),
              ],
            ),
          )
        )
      ],
    );
  }

  Widget returnPhotoOfFileOrUrl() {
    if (widget.campaign.photoUrl != null && _image == null) {
      return CachedNetworkImage(
        imageUrl: widget.campaign.photoUrl,
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.image),
      );
    }

    if (_image == null) {
      return Center(child: Text('Selecione uma imagem'));
    }

    return Image.file(_image);
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
      title: Text("Informações básicas"),
      content: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black38),
                labelText: 'Nome da campaign'
              ),
              controller: _nameController,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Row(
            children: <Widget>[
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
                      labelText: 'Inicio',
                      labelStyle: TextStyle(color: Colors.black38)
                    ),
                    controller: _startController,
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
                    controller: _endController,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ]
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextField(
              maxLength: 255,
              minLines: 3,
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descrição',
                labelStyle: TextStyle(color: Colors.black38)
              ),
              controller: _descriptionController,
            ),
          ),
        ],
      ),
    ),
    Step(
      title: Text("Informações adicionais"),
      content: Card(
        margin: EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
             _returnImageOfcampaign(),
             Column(
              children: <Widget>[
                ListTile(
                  title: Text("Tags da campanha")
                ),
                FutureBuilder(
                  future: Api.getRequest('tags'),
                  builder: (context, projectSnap) {
                    if (projectSnap.connectionState == ConnectionState.none && projectSnap.hasData == null) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!projectSnap.hasData || projectSnap.data.statusCode != 200) {
                      return Center(child: CircularProgressIndicator());
                    }

                    Map<String, dynamic> body = jsonDecode(projectSnap.data.body);
                    var tags = body.entries.toList()[3].value;

                    return TagDropdowns(
                      tags: tags,
                      defaultPurpouseTagValue: widget.campaign.itemTypeTagName,
                      defaultItemTypeTagValue: widget.campaign.purposeTagName
                    );
                  }
                )
              ]
            )
          ],
        ),
      ),
    ),
    Step(
      title: Text("Endereço"),
      content: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black38),
                labelText: 'Rua'
              ),
              controller: _streetController,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      MaskTextInputFormatter(mask: '#####-###')
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CEP',
                      labelStyle: TextStyle(color: Colors.black38)
                    ),
                    controller: _zipcodeController,
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Número',
                      labelStyle: TextStyle(color: Colors.black38)
                    ),
                    controller: _numberController,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ] 
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: TextField(
                    maxLength: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Cidade',
                      labelStyle: TextStyle(color: Colors.black38)
                    ),
                    controller: _cityController,
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: TextField(
                    maxLength: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Estado',
                      labelStyle: TextStyle(color: Colors.black38)
                    ),
                    controller: _stateController,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ] 
          ),
        ],
      ),
    ),
  ];

  Widget _builderStep() => Container(
    color: Colors.white,
    child: Stepper(
      type: StepperType.vertical,
      steps: steps,
      currentStep: currentStep,
      onStepContinue: next,
      onStepTapped: (step) => goTo(step),
      onStepCancel: cancel,
      controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        var cancelLabel = 'Voltar';
        var nextLabel = 'Continuar';
        var paddingCancelButton = defaultPaddingRaisedButtonFormSecondary;
        var paddingNextButton = defaultPaddingRaisedButtonForm;

        if (currentStep == 0) {
          cancelLabel = 'Cancelar';
          paddingCancelButton = defaultPaddingRaisedButtonForm;
        }

        if (currentStep == steps.length - 1) {
          nextLabel = 'Salvar';
          paddingNextButton = defaultPaddingRaisedButtonFormSecondary;
        }

        return Row(
           mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: RaisedGradientButton(
                  child: Text(
                    cancelLabel,
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
                  padding: paddingCancelButton,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: RaisedGradientButton(
                  child: Text(
                    nextLabel,
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
                  padding: paddingNextButton,
                ),
              ),
            ],
        );
      },
    ),
  );

  save() async {
    Map data = {
      "campaign": {
        "id": widget.campaign.id,
        "name": _nameController.value,
        "start": _startController.value,
        "end": _endController.value,
        "description": _descriptionController.value,
      },
      "tags": {
        "names": [_valorProposeTag, _valorTypeItemTag]
      },
      "address": {
        "zipcode": _zipcodeController,
        "state": _stateController,
        "city": _cityController,
        "number": _numberController,
        "street": _streetController,
      },
      "photo": _image
    };

    progressDialog.style(
      message: 'Salvando campaign...',
    );

    progressDialog.show();

    var response = await Api.postRequest('register', data: data);
    Map<String, dynamic> body = jsonDecode(response.body);

    if (response.statusCode != 200) {
      progressDialog.hide();
      return;
    }

    Navigator.pop(context);
  }

  next() {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : save();
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    } else {
      Navigator.pop(context);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }
}
